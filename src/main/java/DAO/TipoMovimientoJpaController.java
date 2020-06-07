/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DAO.exceptions.IllegalOrphanException;
import DAO.exceptions.NonexistentEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import DTO.Movimiento;
import DTO.TipoMovimiento;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author stive
 */
public class TipoMovimientoJpaController implements Serializable {

    public TipoMovimientoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TipoMovimiento tipomovimiento) {
        if (tipomovimiento.getMovimientoList() == null) {
            tipomovimiento.setMovimientoList(new ArrayList<Movimiento>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Movimiento> attachedMovimientoList = new ArrayList<Movimiento>();
            for (Movimiento movimientoListMovimientoToAttach : tipomovimiento.getMovimientoList()) {
                movimientoListMovimientoToAttach = em.getReference(movimientoListMovimientoToAttach.getClass(), movimientoListMovimientoToAttach.getId());
                attachedMovimientoList.add(movimientoListMovimientoToAttach);
            }
            tipomovimiento.setMovimientoList(attachedMovimientoList);
            em.persist(tipomovimiento);
            for (Movimiento movimientoListMovimiento : tipomovimiento.getMovimientoList()) {
                TipoMovimiento oldIdTipoMovimientoOfMovimientoListMovimiento = movimientoListMovimiento.getIdTipoMovimiento();
                movimientoListMovimiento.setIdTipoMovimiento(tipomovimiento);
                movimientoListMovimiento = em.merge(movimientoListMovimiento);
                if (oldIdTipoMovimientoOfMovimientoListMovimiento != null) {
                    oldIdTipoMovimientoOfMovimientoListMovimiento.getMovimientoList().remove(movimientoListMovimiento);
                    oldIdTipoMovimientoOfMovimientoListMovimiento = em.merge(oldIdTipoMovimientoOfMovimientoListMovimiento);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TipoMovimiento tipomovimiento) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TipoMovimiento persistentTipomovimiento = em.find(TipoMovimiento.class, tipomovimiento.getId());
            List<Movimiento> movimientoListOld = persistentTipomovimiento.getMovimientoList();
            List<Movimiento> movimientoListNew = tipomovimiento.getMovimientoList();
            List<String> illegalOrphanMessages = null;
            for (Movimiento movimientoListOldMovimiento : movimientoListOld) {
                if (!movimientoListNew.contains(movimientoListOldMovimiento)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Movimiento " + movimientoListOldMovimiento + " since its idTipoMovimiento field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Movimiento> attachedMovimientoListNew = new ArrayList<Movimiento>();
            for (Movimiento movimientoListNewMovimientoToAttach : movimientoListNew) {
                movimientoListNewMovimientoToAttach = em.getReference(movimientoListNewMovimientoToAttach.getClass(), movimientoListNewMovimientoToAttach.getId());
                attachedMovimientoListNew.add(movimientoListNewMovimientoToAttach);
            }
            movimientoListNew = attachedMovimientoListNew;
            tipomovimiento.setMovimientoList(movimientoListNew);
            tipomovimiento = em.merge(tipomovimiento);
            for (Movimiento movimientoListNewMovimiento : movimientoListNew) {
                if (!movimientoListOld.contains(movimientoListNewMovimiento)) {
                    TipoMovimiento oldIdTipoMovimientoOfMovimientoListNewMovimiento = movimientoListNewMovimiento.getIdTipoMovimiento();
                    movimientoListNewMovimiento.setIdTipoMovimiento(tipomovimiento);
                    movimientoListNewMovimiento = em.merge(movimientoListNewMovimiento);
                    if (oldIdTipoMovimientoOfMovimientoListNewMovimiento != null && !oldIdTipoMovimientoOfMovimientoListNewMovimiento.equals(tipomovimiento)) {
                        oldIdTipoMovimientoOfMovimientoListNewMovimiento.getMovimientoList().remove(movimientoListNewMovimiento);
                        oldIdTipoMovimientoOfMovimientoListNewMovimiento = em.merge(oldIdTipoMovimientoOfMovimientoListNewMovimiento);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tipomovimiento.getId();
                if (findTipoMovimiento(id) == null) {
                    throw new NonexistentEntityException("The tipomovimiento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TipoMovimiento tipomovimiento;
            try {
                tipomovimiento = em.getReference(TipoMovimiento.class, id);
                tipomovimiento.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tipomovimiento with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Movimiento> movimientoListOrphanCheck = tipomovimiento.getMovimientoList();
            for (Movimiento movimientoListOrphanCheckMovimiento : movimientoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Tipomovimiento (" + tipomovimiento + ") cannot be destroyed since the Movimiento " + movimientoListOrphanCheckMovimiento + " in its movimientoList field has a non-nullable idTipoMovimiento field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tipomovimiento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TipoMovimiento> findTipoMovimientoEntities() {
        return findTipoMovimientoEntities(true, -1, -1);
    }

    public List<TipoMovimiento> findTipoMovimientoEntities(int maxResults, int firstResult) {
        return findTipoMovimientoEntities(false, maxResults, firstResult);
    }

    private List<TipoMovimiento> findTipoMovimientoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(TipoMovimiento.class));
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

    public TipoMovimiento findTipoMovimiento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TipoMovimiento.class, id);
        } finally {
            em.close();
        }
    }

    public int getTipomovimientoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<TipoMovimiento> rt = cq.from(TipoMovimiento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
