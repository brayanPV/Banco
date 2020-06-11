/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROLLER;

import NEGOCIO.Banco;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author stive
 */
@WebServlet(name = "Movimiento", urlPatterns = {"/Movimiento"})
public class Movimiento extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int tipo = Integer.valueOf(request.getParameter("tipo"));
            int cta = Integer.valueOf(request.getParameter("cuentaOrigen"));
            int valor = Integer.valueOf(request.getParameter("valor"));
            String fecha = request.getParameter("fecha");

            Banco banquito = new Banco();

            if (request.getSession().getAttribute("banquito") != null) {
                banquito = (Banco) (request.getSession().getAttribute("banquito"));
            }

            if (tipo == 1) {
                if (banquito.realizarConsignacion(fecha, valor, cta, tipo)) {
                    request.getSession().setAttribute("banquito", cta);
                    request.getRequestDispatcher("./index.jsp").forward(request, response);
                } else {
                    System.err.println("falso");
                    request.getSession().setAttribute("error", "Aca hay error pai");
                    request.getRequestDispatcher("./JSP/Error/errormovimiento.jsp").forward(request, response);
                }
            } else if (tipo == 2) {
                if (banquito.realizarRetiro(fecha, valor, cta, tipo)) {
                    request.getSession().setAttribute("banquito", banquito);
                    request.getRequestDispatcher("./index.jsp").forward(request, response);
                } else {
                    System.err.println("falso");
                    request.getSession().setAttribute("error", "Aca hay error pai");
                    request.getRequestDispatcher("./JSP/Error/errormovimiento.jsp").forward(request, response);
                }
            } else if (tipo == 3) {
                int retiro = 2;
                int consignacion = 1;
                int ctaDestino = Integer.parseInt(request.getParameter("cuentaDestino"));
                if (banquito.realizarTransferencia(fecha, valor, cta, ctaDestino, retiro, consignacion)) {
                    request.getSession().setAttribute("banquito", banquito);
                    request.getRequestDispatcher("./index.jsp").forward(request, response);
                } else {
                    System.err.println("falso");
                    request.getSession().setAttribute("error", "Aca hay error pai");
                    request.getRequestDispatcher("./JSP/Error/errormovimiento.jsp").forward(request, response);
                }
            } else {
                System.err.println("falso");
                request.getSession().setAttribute("error", "papi no ha seleccionado movimiento");
                request.getRequestDispatcher("./JSP/Error/errormovimiento.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
            System.out.println("el error es: " + e.getMessage());
            request.getSession().setAttribute("error", e.getMessage());
            request.getRequestDispatcher("./JSP/Error/errorCta.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
