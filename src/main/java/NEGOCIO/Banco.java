/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package NEGOCIO;

import DAO.ClienteJpaController;
import DAO.Conexion;
import DAO.CuentaJpaController;
import DAO.MovimientoJpaController;
import DAO.TipoJpaController;
import DAO.TipoMovimientoJpaController;
import DAO.exceptions.NonexistentEntityException;
import DTO.Cliente;
import DTO.Cuenta;
import DTO.Movimiento;
import DTO.Tipo;
import DTO.TipoMovimiento;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author stive
 */
public class Banco {

    Conexion con = Conexion.getConexion();
    ClienteJpaController clienteDAO = new ClienteJpaController(con.getBd());
    List<Cliente> clientes = clienteDAO.findClienteEntities();
    CuentaJpaController cuentaDAO = new CuentaJpaController(con.getBd());
    List<Cuenta> cuentas = cuentaDAO.findCuentaEntities();
    TipoJpaController tipoDAO = new TipoJpaController(con.getBd());
    List<Tipo> tipos = tipoDAO.findTipoEntities();
    TipoMovimientoJpaController tipoMovimientoDAO = new TipoMovimientoJpaController(con.getBd());
    List<TipoMovimiento> tipoMovimientos = tipoMovimientoDAO.findTipoMovimientoEntities();
    MovimientoJpaController movimientoDAO = new MovimientoJpaController(con.getBd());
    List<Movimiento> movimientos = movimientoDAO.findMovimientoEntities();

    public Banco() {
    }

    public boolean insertarCliente(Integer cedula, String nombre, String fechanacimiento, String dircorrespondencia, int telefono, String email) throws ParseException {
        Cliente c = new Cliente();
        c.setCedula(cedula);
        c.setNombre(nombre);
        c.setFechanacimiento(crearFecha(fechanacimiento));
        c.setDircorrespondencia(dircorrespondencia);
        c.setTelefono(telefono);
        c.setEmail(email);
        try {
            clienteDAO.create(c);
            return true;
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return false;
    }

    public boolean insertarCuenta(Integer nroCuenta, Integer cedula, int tipo) {
        Cliente x = new Cliente();
        x.setCedula(cedula);
        x = buscarCliente(x);
        if (x == null) {
            return false;
        }
        Tipo t = new Tipo();
        t.setId(tipo);
        t = buscarTipo(t);
        if (t == null) {
            return false;
        }
        Cuenta cta = new Cuenta();
        cta.setNroCuenta(nroCuenta);
        cta.setCedula(x);
        cta.setTipo(t);
        cta.setFechacreacion(currentDate());
        try {
            cuentaDAO.create(cta);
            return true;
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }

        return false;
    }

    public boolean realizarConsignacion(String fecha, int valor, int nroCuenta, int tipoMovimiento) throws ParseException, NonexistentEntityException, Exception {
        Cuenta cta = new Cuenta();
        cta.setNroCuenta(nroCuenta);
        cta = findCuentaByNroCuenta(cta);
        if (cta == null) {
            return false;
        }
        TipoMovimiento t = new TipoMovimiento();
        t.setId(tipoMovimiento);
        t = buscarTipoMovimiento(t);
        if (t != null && t.getId() == 1) {
            Movimiento mov = new Movimiento();
            mov.setFecha(crearFecha(fecha));
            mov.setValor(valor);
            mov.setNroCuenta(cta);
            cta.setSaldo(cta.getSaldo() + valor);
            cuentaDAO.edit(cta);
            mov.setIdTipoMovimiento(t);
            try {
                movimientoDAO.create(mov);
                return true;
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
        }

        return false;
    }

    public boolean realizarRetiro(String fecha, int valor, int nroCuenta, int tipoMovimiento) throws ParseException, NonexistentEntityException, Exception {
        Cuenta cta = new Cuenta();
        cta.setNroCuenta(nroCuenta);
        cta = findCuentaByNroCuenta(cta);
        if (cta == null) {
            return false;
        }
        TipoMovimiento t = new TipoMovimiento();
        t.setId(tipoMovimiento);
        t = buscarTipoMovimiento(t);
        if (t != null && t.getId() == 2) {
            Movimiento mov = new Movimiento();
            mov.setFecha(crearFecha(fecha));
            mov.setValor(valor);
            mov.setNroCuenta(cta);
            if (cta.getSaldo() >= valor) {
                cta.setSaldo(cta.getSaldo() - valor);
                cuentaDAO.edit(cta);
                mov.setIdTipoMovimiento(t);
                try {
                    movimientoDAO.create(mov);
                    return true;
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
            }

        }
        return false;
    }

    public boolean realizarTransferencia(String fecha, int valor, int nroCuenta, int nroCuentaDestino, int retiro, int consignacion) throws NonexistentEntityException, Exception {
        Cuenta cta = new Cuenta();
        cta.setNroCuenta(nroCuenta);
        cta = findCuentaByNroCuenta(cta);
        if (cta == null) {
            return false;
        }
        TipoMovimiento t = new TipoMovimiento();
        t.setId(retiro);
        t = buscarTipoMovimiento(t);
        if (t != null && t.getId() == 2) {
            realizarRetiro(fecha, valor, nroCuenta, retiro);
            TipoMovimiento c = new TipoMovimiento();
            c.setId(consignacion);
            c = buscarTipoMovimiento(c);
            if (c != null && c.getId() == 1) {
                realizarConsignacion(fecha, valor, nroCuentaDestino, consignacion);
                return true;
            }
        }
        return false;
    }

    public String mostrarExtractoBancario(int cedula, String fechaInicio, String fechaFinal) throws ParseException {
        String msg = "";
        ArrayList<Cuenta> cta = findCuentaByNroCedula(cedula);
        if (cta == null) {
            return null;
        }
        for (int i = 0; i < cta.size(); i++) {
            ArrayList<Movimiento> mov = buscarMovimientos(cta.get(i).getNroCuenta());
            for (int j = 0; j < mov.size(); j++) {
                if (mov.get(j).getFecha().after(crearFecha(fechaInicio)) && mov.get(j).getFecha().before(crearFecha(fechaFinal))) {
                    msg += mov.get(j).toString();

                }
            }
            return msg;
        }
        return msg;
    }

    private ArrayList buscarMovimientos(int nroCta) {
        ArrayList<Movimiento> mov = new ArrayList<Movimiento>();
        Cuenta c = new Cuenta();
        c.setNroCuenta(nroCta);
        c = findCuentaByNroCuenta(c);
        for (Movimiento m : movimientos) {
            if (m.getNroCuenta().equals(c)) {
                mov.add(m);
            }
        }
        return mov;
    }

    public Date currentDate() {
        DateTimeFormatter day = DateTimeFormatter.ofPattern("dd");
        DateTimeFormatter month = DateTimeFormatter.ofPattern("MM");
        DateTimeFormatter year = DateTimeFormatter.ofPattern("yyyy");
        LocalDateTime now = LocalDateTime.now();
        int dia = Integer.parseInt(day.format(now));
        int mes = Integer.parseInt(month.format(now));
        int anio = Integer.parseInt(year.format(now));
        return new Date(anio - 1900, mes - 1, dia);
    }

    private Date crearFecha(String fecha) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
        Date date = formatter.parse(fecha);
        return date;
    }

    private Tipo buscarTipo(Tipo x) {
        for (Tipo t : this.tipos) {
            if (t.equals(x)) {
                return t;
            }
        }
        return null;
    }

    private TipoMovimiento buscarTipoMovimiento(TipoMovimiento x) {
        for (TipoMovimiento t : tipoMovimientos) {
            if (t.equals(x)) {
                return t;
            }
        }
        return null;
    }

    public Cuenta findCuentaByNroCuenta(Cuenta x) {
        for (Cuenta c : cuentas) {
            if (c.equals(x)) {
                return c;
            }
        }
        return null;
    }

    public ArrayList findCuentaByNroCedula(int nroCedula) {
        ArrayList<Cuenta> resultado = new ArrayList<Cuenta>();
        Cliente c = new Cliente();
        c.setCedula(nroCedula);
        c = buscarCliente(c);
        for (Cuenta cta : cuentas) {
            if (cta.getCedula().equals(c)) {
                resultado.add(cta);
            }
        }
        return resultado;
    }

    private Cliente buscarCliente(Cliente x) {
        for (Cliente y : this.clientes) {
            if (y.equals(x)) {
                return y;
            }
        }
        return null;
    }

    public ClienteJpaController getClienteDAO() {
        return clienteDAO;
    }

    public void setClienteDAO(ClienteJpaController clienteDAO) {
        this.clienteDAO = clienteDAO;
    }

    public List<Cliente> getClientes() {
        return clientes;
    }

    public void setClientes(List<Cliente> clientes) {
        this.clientes = clientes;
    }

    public Cliente findCliente(int cedula) {
        return clienteDAO.findCliente(cedula);
    }

    public boolean UpdateCliente(Integer cedula, String nombre, String fechanacimiento, String dircorrespondencia, int telefono, String email) throws ParseException {
        Cliente c = clienteDAO.findCliente(cedula);
        c.setCedula(cedula);
        c.setNombre(nombre);
        c.setFechanacimiento(crearFecha(fechanacimiento));
        c.setDircorrespondencia(dircorrespondencia);
        c.setTelefono(telefono);
        c.setEmail(email);

        try {
            clienteDAO.edit(c);
            return true;
        } catch (Exception e) {
            System.err.println(e);
        }
        return false;
    }

    public List<Cuenta> getCuentas() {
        return cuentas;
    }

    public List<Movimiento> getMovimientos() {
        return movimientos;
    }
}
