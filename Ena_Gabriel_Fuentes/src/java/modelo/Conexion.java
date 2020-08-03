/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gabri
 */
public class Conexion {
    
    String driver = "com.mysql.jdbc.Driver";
    String usu = "root";
    String pass = "";
    String url = "jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull";
    Connection conex;
    PreparedStatement pst=null;
    ResultSet rs=null;
    
    public Conexion(){
        try {
            Class.forName(driver);
            conex=DriverManager.getConnection(url, usu, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public boolean autenticacion(String usuario, String contraseña){
        
        try {
            String consulta = "select nick,contraseña from usuarios where nick = ? and contraseña = ?";;
            pst = conex.prepareStatement(consulta);
            pst.setString(1, usuario);
            pst.setString(2, contraseña);
            rs=pst.executeQuery();
            
            if (rs.absolute(1)) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error" + e);
        }finally{
             try {
                if (conex != null) conex.close();
                if(pst != null) pst.close();
                if(rs != null) rs.close();
            } catch (Exception e) {
                System.err.println("Error" + e);
            }
        }
        
        return false;
    }
    

    
    public ResultSet listarGerencia() {
        
        String sql = "select distinct gerente from gerencia";
        try {
            pst = conex.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;

    }
    
    public ResultSet listarDepartamento(){
        
        String sql = "select departamento from depa";
        try {
            pst = conex.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public boolean guargarDatos(String gerencia, String depto, String asingado, String encargado, String requerimiento){
        
        String sql = "INSERT INTO requerimientos (gerencia, departamento, departamentom, encargado, requerimiento, estado, codigo) VALUES (?,?,?,?,?,'Abierto',null )";
        try {
            pst = conex.prepareStatement(sql);
            pst.setString(1, gerencia);
            pst.setString(2, depto);
            pst.setString(3, asingado);
            pst.setString(4, encargado);
            pst.setString(5, requerimiento);
            pst.execute();
            return true;
            
            
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        return false; 
    }
    
    public ResultSet consultaRequerimiento(String sql){
        
        try {
            pst = conex.prepareStatement(sql);
            rs = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public boolean cerrarRequerimiento(String codigo){
        
        String sql = "update requerimientos set estado='Cerrado' where codigo = ?";
        try {
            pst = conex.prepareStatement(sql);
            pst.setString(1, codigo); 
            pst.execute();
            return true;
            
            
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        return false;
        
    }
    
}
