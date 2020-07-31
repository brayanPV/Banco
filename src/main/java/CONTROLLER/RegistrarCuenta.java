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
@WebServlet(name = "RegistrarCuenta", urlPatterns = {"/RegistrarCuenta"})
public class RegistrarCuenta extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try {
            Integer nroCuenta = Integer.parseInt(request.getParameter("nrocuenta"));
            int t = Integer.parseInt(request.getParameter("tipocuenta"));
            Integer cedula = Integer.parseInt(request.getParameter("cedula"));

            //Banco banco = (Banco) (request.getSession().getAttribute("banco"));
            Banco banquito = new Banco();

            if (request.getSession().getAttribute("banquito") != null) {
                banquito = (Banco) (request.getSession().getAttribute("banquito"));
            }

            if (banquito.insertarCuenta(nroCuenta, cedula, t)) {
                request.getSession().setAttribute("banquito", banquito);
                request.getRequestDispatcher("./index.jsp").forward(request, response);
            } else {
                System.err.println("falso");
                request.getSession().setAttribute("error", "Dato ya registrado en el sistema");
                request.getRequestDispatcher("./JSP/Error/errorCta.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
            System.out.println("el error es: " + e.getMessage());
            request.getSession().setAttribute("error", e.getMessage());
            request.getRequestDispatcher("./JSP/Error/errorCta.jsp").forward(request, response);
        }
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
