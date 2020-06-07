/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author stive
 */
public class Conexion {
    private static Conexion conexion;
    private EntityManagerFactory bd;
    private static EntityManagerFactory em = null;

    private Conexion() {
        em = this.getEm();
        this.bd = Persistence.createEntityManagerFactory("BANCOPU");
    }

    public static Conexion getConexion() {
        if (conexion == null) {
            conexion = new Conexion();
        }
        return conexion;
    }

    public EntityManagerFactory getBd() {
        return bd;
    }

    public static EntityManagerFactory getEm() {

        if (em == null) {

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("BANCOPU");
            em = emf;

        }

        return em;

    }
}
