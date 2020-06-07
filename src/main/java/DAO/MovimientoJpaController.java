/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DAO.exceptions.NonexistentEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import DTO.Cuenta;
import DTO.Movimiento;
import DTO.TipoMovimiento;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author stive
 */
public class MovimientoJpaController implements Serializable {

    public MovimientoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Movimiento movimiento) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cuenta nroCuenta = movimiento.getNroCuenta();
            if (nroCuenta != null) {
                nroCuenta = em.getReference(nroCuenta.getClass(), nroCuenta.getNroCuenta());
                movimiento.setNroCuenta(nroCuenta);
            }
            TipoMovimiento idTipoMovimiento = movimiento.getIdTipoMovimiento();
            if (idTipoMovimiento != null) {
                idTipoMovimiento = em.getReference(idTipoMovimiento.getClass(), idTipoMovimiento.getId());
                movimiento.setIdTipoMovimiento(idTipoMovimiento);
            }
            em.persist(movimiento);
            if (nroCuenta != null) {
                nroCuenta.getMovimientoList().add(movimiento);
                nroCuenta = em.merge(nroCuenta);
            }
            if (idTipoMovimiento != null) {
                idTipoMovimiento.getMovimientoList().add(movimiento);
                idTipoMovimiento = em.merge(idTipoMovimiento);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Movimiento movimiento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Movimiento persistentMovimiento = em.find(Movimiento.class, movimiento.getId());
            Cuenta nroCuentaOld = persistentMovimiento.getNroCuenta();
            Cuenta nroCuentaNew = movimiento.getNroCuenta();
            TipoMovimiento idTipoMovimientoOld = persistentMovimiento.getIdTipoMovimiento();
            TipoMovimiento idTipoMovimientoNew = movimiento.getIdTipoMovimiento();
            if (nroCuentaNew != null) {
                nroCuentaNew = em.getReference(nroCuentaNew.getClass(), nroCuentaNew.getNroCuenta());
                movimiento.setNroCuenta(nroCuentaNew);
            }
            if (idTipoMovimientoNew != null) {
                idTipoMovimientoNew = em.getReference(idTipoMovimientoNew.getClass(), idTipoMovimientoNew.getId());
                movimiento.setIdTipoMovimiento(idTipoMovimientoNew);
            }
            movimiento = em.merge(movimiento);
            if (nroCuentaOld != null && !nroCuentaOld.equals(nroCuentaNew)) {
                nroCuentaOld.getMovimientoList().remove(movimiento);
                nroCuentaOld = em.merge(nroCuentaOld);
            }
            if (nroCuentaNew != null && !nroCuentaNew.equals(nroCuentaOld)) {
                nroCuentaNew.getMovimientoList().add(movimiento);
                nroCuentaNew = em.merge(nroCuentaNew);
            }
            if (idTipoMovimientoOld != null && !idTipoMovimientoOld.equals(idTipoMovimientoNew)) {
                idTipoMovimientoOld.getMovimientoList().remove(movimiento);
                idTipoMovimientoOld = em.merge(idTipoMovimientoOld);
            }
            if (idTipoMovimientoNew != null && !idTipoMovimientoNew.equals(idTipoMovimientoOld)) {
                idTipoMovimientoNew.getMovimientoList().add(movimiento);
                idTipoMovimientoNew = em.merge(idTipoMovimientoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = movimiento.getId();
                if (findMovimiento(id) == null) {
                    throw new NonexistentEntityException("The movimiento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Movimiento movimiento;
            try {
                movimiento = em.getReference(Movimiento.class, id);
                movimiento.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The movimiento with id " + id + " no longer exists.", enfe);
            }
            Cuenta nroCuenta = movimiento.getNroCuenta();
            if (nroCuenta != null) {
                nroCuenta.getMovimientoList().remove(movimiento);
                nroCuenta = em.merge(nroCuenta);
            }
            TipoMovimiento idTipoMovimiento = movimiento.getIdTipoMovimiento();
            if (idTipoMovimiento != null) {
                idTipoMovimiento.getMovimientoList().remove(movimiento);
                idTipoMovimiento = em.merge(idTipoMovimiento);
            }
            em.remove(movimiento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Movimiento> findMovimientoEntities() {
        return findMovimientoEntities(true, -1, -1);
    }

    public List<Movimiento> findMovimientoEntities(int maxResults, int firstResult) {
        return findMovimientoEntities(false, maxResults, firstResult);
    }

    private List<Movimiento> findMovimientoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Movimiento.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Movimiento findMovimiento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Movimiento.class, id);
        } finally {
            em.close();
        }
    }

    public int getMovimientoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Movimiento> rt = cq.from(Movimiento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
