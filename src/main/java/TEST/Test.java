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
    
    public static void main(String[] args){
        ClienteJpaController clienteDao = new ClienteJpaController();
        List<Cliente> clientes = clienteDao.findClienteEntities();
        
        for(Cliente c: clientes){
            System.out.println("Cliente " + c.getNombre());
        }
    }
}
