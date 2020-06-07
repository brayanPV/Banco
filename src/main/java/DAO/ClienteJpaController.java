/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DAO.exceptions.IllegalOrphanException;
import DAO.exceptions.NonexistentEntityException;
import DAO.exceptions.PreexistingEntityException;
import DTO.Cliente;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import DTO.Cuenta;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;

/**
 *
 * @author stive
 */
public class ClienteJpaController implements Serializable {

    public ClienteJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Cliente cliente) throws PreexistingEntityException, Exception {
        if (cliente.getCuentaList() == null) {
            cliente.setCuentaList(new ArrayList<Cuenta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Cuenta> attachedCuentaList = new ArrayList<Cuenta>();
            for (Cuenta cuentaListCuentaToAttach : cliente.getCuentaList()) {
                cuentaListCuentaToAttach = em.getReference(cuentaListCuentaToAttach.getClass(), cuentaListCuentaToAttach.getNroCuenta());
                attachedCuentaList.add(cuentaListCuentaToAttach);
            }
            cliente.setCuentaList(attachedCuentaList);
            em.persist(cliente);
            for (Cuenta cuentaListCuenta : cliente.getCuentaList()) {
                Cliente oldCedulaOfCuentaListCuenta = cuentaListCuenta.getCedula();
                cuentaListCuenta.setCedula(cliente);
                cuentaListCuenta = em.merge(cuentaListCuenta);
                if (oldCedulaOfCuentaListCuenta != null) {
                    oldCedulaOfCuentaListCuenta.getCuentaList().remove(cuentaListCuenta);
                    oldCedulaOfCuentaListCuenta = em.merge(oldCedulaOfCuentaListCuenta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findCliente(cliente.getCedula()) != null) {
                throw new PreexistingEntityException("Cliente " + cliente + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Cliente cliente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cliente persistentCliente = em.find(Cliente.class, cliente.getCedula());
            List<Cuenta> cuentaListOld = persistentCliente.getCuentaList();
            List<Cuenta> cuentaListNew = cliente.getCuentaList();
            List<String> illegalOrphanMessages = null;
            for (Cuenta cuentaListOldCuenta : cuentaListOld) {
                if (!cuentaListNew.contains(cuentaListOldCuenta)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Cuenta " + cuentaListOldCuenta + " since its cedula field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Cuenta> attachedCuentaListNew = new ArrayList<Cuenta>();
            for (Cuenta cuentaListNewCuentaToAttach : cuentaListNew) {
                cuentaListNewCuentaToAttach = em.getReference(cuentaListNewCuentaToAttach.getClass(), cuentaListNewCuentaToAttach.getNroCuenta());
                attachedCuentaListNew.add(cuentaListNewCuentaToAttach);
            }
            cuentaListNew = attachedCuentaListNew;
            cliente.setCuentaList(cuentaListNew);
            cliente = em.merge(cliente);
            for (Cuenta cuentaListNewCuenta : cuentaListNew) {
                if (!cuentaListOld.contains(cuentaListNewCuenta)) {
                    Cliente oldCedulaOfCuentaListNewCuenta = cuentaListNewCuenta.getCedula();
                    cuentaListNewCuenta.setCedula(cliente);
                    cuentaListNewCuenta = em.merge(cuentaListNewCuenta);
                    if (oldCedulaOfCuentaListNewCuenta != null && !oldCedulaOfCuentaListNewCuenta.equals(cliente)) {
                        oldCedulaOfCuentaListNewCuenta.getCuentaList().remove(cuentaListNewCuenta);
                        oldCedulaOfCuentaListNewCuenta = em.merge(oldCedulaOfCuentaListNewCuenta);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = cliente.getCedula();
                if (findCliente(id) == null) {
                    throw new NonexistentEntityException("The cliente with id " + id + " no longer exists.");
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
            Cliente cliente;
            try {
                cliente = em.getReference(Cliente.class, id);
                cliente.getCedula();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The cliente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Cuenta> cuentaListOrphanCheck = cliente.getCuentaList();
            for (Cuenta cuentaListOrphanCheckCuenta : cuentaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Cliente (" + cliente + ") cannot be destroyed since the Cuenta " + cuentaListOrphanCheckCuenta + " in its cuentaList field has a non-nullable cedula field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(cliente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Cliente> findClienteEntities() {
        return findClienteEntities(true, -1, -1);
    }

    public List<Cliente> findClienteEntities(int maxResults, int firstResult) {
        return findClienteEntities(false, maxResults, firstResult);
    }

    private List<Cliente> findClienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Cliente.class));
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

    public Cliente findCliente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Cliente.class, id);
        } finally {
            em.close();
        }
    }

    public int getClienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Cliente> rt = cq.from(Cliente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
