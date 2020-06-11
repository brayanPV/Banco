/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROLLER;

import NEGOCIO.Banco;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import static java.lang.System.out;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author stive
 */
@WebServlet(name = "Extracto", urlPatterns = {"/Extracto"})
public class Extracto extends HttpServlet {

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
            Integer cedula = Integer.parseInt(request.getParameter("cedula"));
            String fechaInicio = request.getParameter("fechaInicio");
            String fechaFinal = request.getParameter("fechaFinal");

            Banco banquito = new Banco();

            if (request.getSession().getAttribute("banquito") != null) {
                banquito = (Banco) (request.getSession().getAttribute("banquito"));
            }
            if (banquito.mostrarExtractoBancario(cedula, fechaInicio, fechaFinal) != null) {

                Document documento = new Document();
                PdfWriter.getInstance(documento, out);

                documento.open();
                Paragraph titulo = new Paragraph();
                Font fuente = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, BaseColor.BLACK);
                titulo.add(new Phrase("Extracto bancario de " + cedula +" entre las fechas " + fechaInicio +" - " + fechaFinal, fuente));
                titulo.add(new Phrase(Chunk.NEWLINE));
                titulo.add(new Phrase(Chunk.NEWLINE));
                titulo.add(new Phrase(Chunk.NEWLINE));
                documento.add(titulo);
                Paragraph par = new Paragraph();
                par.add(new Phrase(banquito.mostrarExtractoBancario(cedula, fechaInicio, fechaFinal), fuente));
                documento.add(par);
                documento.close();

                request.getSession().setAttribute("banquito", cedula);
                request.getRequestDispatcher("./JSP/Cliente/extractoexitoso.jsp").forward(request, response);
            } else {
                System.err.println("falso");
                request.getSession().setAttribute("error", "jeje hay error");
                request.getRequestDispatcher("./JSP/Error/error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
            System.out.println("el error es: " + e.getMessage());
            request.getSession().setAttribute("error", e.getMessage());
            request.getRequestDispatcher("./JSP/Error/error.jsp").forward(request, response);
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
