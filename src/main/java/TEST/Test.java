/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TEST;

import DAO.ClienteJpaController;
import DTO.Cliente;
import java.util.List;

/**
 *
 * @author stive
 */
public class Test {

    public static void main(String[] args) {
        ClienteJpaController clienteDao = new ClienteJpaController();
        List<Cliente> clientes = clienteDao.findClienteEntities();
        if (clientes != null) {
            for (Cliente c : clientes) {
                System.out.println("Cliente " + c.getNombre());
            }
        } else {
            System.out.println("No hay clientes");
        }
    }
}
