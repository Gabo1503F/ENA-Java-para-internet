/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Conexion;

/**
 *
 * @author gabri
 */
public class ControlConsulta extends HttpServlet {

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
        PrintWriter out = response.getWriter();

        String query1 = "select*from requerimientos ";
        String p1 = "";
        String p2 = "";
        String p3 = "";

        String gerencia = request.getParameter("gerencia");
        String depto = request.getParameter("departamentog");
        String asignado = request.getParameter("departamentosm");
        String direccion = request.getParameter("acto");

        if (!"1".equals(gerencia)) {
            p1 = "where gerencia='" + gerencia + "' ";
        }

        if (!"1".equals(depto)) {

            if ("".equals(p1)) {
                p2 = "where departamento='" + depto + "' ";
            } else {
                p2 = "and departamento='" + depto + "' ";
            }
        }

        if (!"1".equals(asignado)) {
            if ("".equals(p1) || "".equals(p2)) {
                p3 = "where departamentom='" + asignado + "' ";
            } else {
                p3 = "and departamentom='" + asignado + "' ";
            }
        }

        String query2 = query1 + "" + p1 + "" + p2 + "" + p3;

        if ("3".equals(direccion)) {
            request.setAttribute("mensaje", query2);
            request.getRequestDispatcher("Consultar_requerimientos.jsp").forward(request, response);
        }
        if ("4".equals(direccion)) {
            request.setAttribute("mensaje", query2);
            request.getRequestDispatcher("Cerrar_requerimientos.jsp").forward(request, response);
        }
        if ("5".equals(direccion)) {
            Conexion con = new Conexion();
            String cod = request.getParameter("codigo");

            if (con.cerrarRequerimiento(cod)) {
                request.setAttribute("vacio", "El requerimiento se cerro correctamente");
                request.getRequestDispatcher("Cerrar_requerimientos.jsp").forward(request, response);

            } else {
                request.setAttribute("vacio", "error");
                request.getRequestDispatcher("Cerrar_requerimientos.jsp").forward(request, response);
            }
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
