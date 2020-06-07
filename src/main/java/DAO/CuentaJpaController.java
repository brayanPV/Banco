/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DAO.exceptions.IllegalOrphanException;
import DAO.exceptions.NonexistentEntityException;
import DAO.exceptions.PreexistingEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import DTO.Cliente;
import DTO.Cuenta;
import DTO.Tipo;
import DTO.Movimiento;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author stive
 */
public class CuentaJpaController implements Serializable {

    public CuentaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Cuenta cuenta) throws PreexistingEntityException, Exception {
        if (cuenta.getMovimientoList() == null) {
            cuenta.setMovimientoList(new ArrayList<Movimiento>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cliente cedula = cuenta.getCedula();
            if (cedula != null) {
                cedula = em.getReference(cedula.getClass(), cedula.getCedula());
                cuenta.setCedula(cedula);
            }
            Tipo tipo = cuenta.getTipo();
            if (tipo != null) {
                tipo = em.getReference(tipo.getClass(), tipo.getId());
                cuenta.setTipo(tipo);
            }
            List<Movimiento> attachedMovimientoList = new ArrayList<Movimiento>();
            for (Movimiento movimientoListMovimientoToAttach : cuenta.getMovimientoList()) {
                movimientoListMovimientoToAttach = em.getReference(movimientoListMovimientoToAttach.getClass(), movimientoListMovimientoToAttach.getId());
                attachedMovimientoList.add(movimientoListMovimientoToAttach);
            }
            cuenta.setMovimientoList(attachedMovimientoList);
            em.persist(cuenta);
            if (cedula != null) {
                cedula.getCuentaList().add(cuenta);
                cedula = em.merge(cedula);
            }
            if (tipo != null) {
                tipo.getCuentaList().add(cuenta);
                tipo = em.merge(tipo);
            }
            for (Movimiento movimientoListMovimiento : cuenta.getMovimientoList()) {
                Cuenta oldNroCuentaOfMovimientoListMovimiento = movimientoListMovimiento.getNroCuenta();
                movimientoListMovimiento.setNroCuenta(cuenta);
                movimientoListMovimiento = em.merge(movimientoListMovimiento);
                if (oldNroCuentaOfMovimientoListMovimiento != null) {
                    oldNroCuentaOfMovimientoListMovimiento.getMovimientoList().remove(movimientoListMovimiento);
                    oldNroCuentaOfMovimientoListMovimiento = em.merge(oldNroCuentaOfMovimientoListMovimiento);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findCuenta(cuenta.getNroCuenta()) != null) {
                throw new PreexistingEntityException("Cuenta " + cuenta + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Cuenta cuenta) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cuenta persistentCuenta = em.find(Cuenta.class, cuenta.getNroCuenta());
            Cliente cedulaOld = persistentCuenta.getCedula();
            Cliente cedulaNew = cuenta.getCedula();
            Tipo tipoOld = persistentCuenta.getTipo();
            Tipo tipoNew = cuenta.getTipo();
            List<Movimiento> movimientoListOld = persistentCuenta.getMovimientoList();
            List<Movimiento> movimientoListNew = cuenta.getMovimientoList();
            List<String> illegalOrphanMessages = null;
            for (Movimiento movimientoListOldMovimiento : movimientoListOld) {
                if (!movimientoListNew.contains(movimientoListOldMovimiento)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Movimiento " + movimientoListOldMovimiento + " since its nroCuenta field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (cedulaNew != null) {
                cedulaNew = em.getReference(cedulaNew.getClass(), cedulaNew.getCedula());
                cuenta.setCedula(cedulaNew);
            }
            if (tipoNew != null) {
                tipoNew = em.getReference(tipoNew.getClass(), tipoNew.getId());
                cuenta.setTipo(tipoNew);
            }
            List<Movimiento> attachedMovimientoListNew = new ArrayList<Movimiento>();
            for (Movimiento movimientoListNewMovimientoToAttach : movimientoListNew) {
                movimientoListNewMovimientoToAttach = em.getReference(movimientoListNewMovimientoToAttach.getClass(), movimientoListNewMovimientoToAttach.getId());
                attachedMovimientoListNew.add(movimientoListNewMovimientoToAttach);
            }
            movimientoListNew = attachedMovimientoListNew;
            cuenta.setMovimientoList(movimientoListNew);
            cuenta = em.merge(cuenta);
            if (cedulaOld != null && !cedulaOld.equals(cedulaNew)) {
                cedulaOld.getCuentaList().remove(cuenta);
                cedulaOld = em.merge(cedulaOld);
            }
            if (cedulaNew != null && !cedulaNew.equals(cedulaOld)) {
                cedulaNew.getCuentaList().add(cuenta);
                cedulaNew = em.merge(cedulaNew);
            }
            if (tipoOld != null && !tipoOld.equals(tipoNew)) {
                tipoOld.getCuentaList().remove(cuenta);
                tipoOld = em.merge(tipoOld);
            }
            if (tipoNew != null && !tipoNew.equals(tipoOld)) {
                tipoNew.getCuentaList().add(cuenta);
                tipoNew = em.merge(tipoNew);
            }
            for (Movimiento movimientoListNewMovimiento : movimientoListNew) {
                if (!movimientoListOld.contains(movimientoListNewMovimiento)) {
                    Cuenta oldNroCuentaOfMovimientoListNewMovimiento = movimientoListNewMovimiento.getNroCuenta();
                    movimientoListNewMovimiento.setNroCuenta(cuenta);
                    movimientoListNewMovimiento = em.merge(movimientoListNewMovimiento);
                    if (oldNroCuentaOfMovimientoListNewMovimiento != null && !oldNroCuentaOfMovimientoListNewMovimiento.equals(cuenta)) {
                        oldNroCuentaOfMovimientoListNewMovimiento.getMovimientoList().remove(movimientoListNewMovimiento);
                        oldNroCuentaOfMovimientoListNewMovimiento = em.merge(oldNroCuentaOfMovimientoListNewMovimiento);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = cuenta.getNroCuenta();
                if (findCuenta(id) == null) {
                    throw new NonexistentEntityException("The cuenta with id " + id + " no longer exists.");
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
            Cuenta cuenta;
            try {
                cuenta = em.getReference(Cuenta.class, id);
                cuenta.getNroCuenta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The cuenta with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Movimiento> movimientoListOrphanCheck = cuenta.getMovimientoList();
            for (Movimiento movimientoListOrphanCheckMovimiento : movimientoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Cuenta (" + cuenta + ") cannot be destroyed since the Movimiento " + movimientoListOrphanCheckMovimiento + " in its movimientoList field has a non-nullable nroCuenta field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Cliente cedula = cuenta.getCedula();
            if (cedula != null) {
                cedula.getCuentaList().remove(cuenta);
                cedula = em.merge(cedula);
            }
            Tipo tipo = cuenta.getTipo();
            if (tipo != null) {
                tipo.getCuentaList().remove(cuenta);
                tipo = em.merge(tipo);
            }
            em.remove(cuenta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Cuenta> findCuentaEntities() {
        return findCuentaEntities(true, -1, -1);
    }

    public List<Cuenta> findCuentaEntities(int maxResults, int firstResult) {
        return findCuentaEntities(false, maxResults, firstResult);
    }

    private List<Cuenta> findCuentaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Cuenta.class));
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

    public Cuenta findCuenta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Cuenta.class, id);
        } finally {
            em.close();
        }
    }

    public int getCuentaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Cuenta> rt = cq.from(Cuenta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
