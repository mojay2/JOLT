/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;

import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;

public class PrintJobInfo extends HttpServlet {

Connection conn;    

    public void init() throws ServletException {
            ServletContext context = getServletContext();
            try {	
                    Class.forName(context.getInitParameter("jdbcClassName"));
                    //System.out.println("jdbcClassName: " + config.getInitParameter("jdbcClassName"));
                    String username = context.getInitParameter("dbUserName");
                    String password = context.getInitParameter("dbPassword");
                    StringBuffer url = new StringBuffer(context.getInitParameter("jdbcDriverURL"))
                            .append("://")
                            .append(context.getInitParameter("dbHostName"))
                            .append(":")
                            .append(context.getInitParameter("dbPort"))
                            .append("/")
                            .append(context.getInitParameter("databaseName"));
                    conn = 
                      DriverManager.getConnection(url.toString(),username,password);
            } catch (SQLException sqle){
                    System.out.println("SQLException error occured - " 
                            + sqle.getMessage());
            } catch (ClassNotFoundException nfe){
                    System.out.println("ClassNotFoundException error occured - " 
                    + nfe.getMessage());
            }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");   
        Document document = new Document();     
        ServletOutputStream os = response.getOutputStream();

        try {	
                if (conn != null) {
                    HttpSession session = request.getSession();

                    //Prepare Document
                    PdfWriter writer = PdfWriter.getInstance(document, os);
                    Font titleFont = new Font(Font.FontFamily.HELVETICA, 38, Font.BOLD);
                    Font paragraphFontBold = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
                    Font paragraphFont = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL);

                    document.open();
                    document.addTitle("job-info.pdf");

                    String query;
                    PreparedStatement ps;
                    ResultSet rs;
                    Integer jobID = Integer.parseInt(request.getParameter("job"));
                    query = "SELECT * FROM JOBS "
                                + "INNER JOIN EMPLOYERS ON JOBS.EMP_ID = EMPLOYERS.EMP_ID "
                                + "INNER JOIN INDUSTRIES ON INDUSTRY_ID = IND_ID "
                                + "INNER JOIN TYPES ON JOB_TYPE = TYPE_ID "
                                + "INNER JOIN LEVELS ON JOB_LEVEL = LEVEL_ID "
                                + "WHERE JOB_ID = ?"
                    ;                    
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, jobID);
                    rs = ps.executeQuery();

                    if(rs.next()){
                        //Job title
                        Paragraph jobTitle = new Paragraph(rs.getString("JOB_TITLE"), titleFont);
                        jobTitle.setAlignment(Element.ALIGN_CENTER);
                        document.add(jobTitle);
                        //Employer, location, industry, date
                        PdfPTable table1 = new PdfPTable(4);
                        PdfPCell emp = new PdfPCell(new Paragraph(rs.getString("EMP_NAME") , paragraphFontBold));
                        PdfPCell loc = new PdfPCell(new Paragraph(rs.getString("JOB_LOCATION") , paragraphFontBold));
                        PdfPCell ind = new PdfPCell(new Paragraph(rs.getString("IND_NAME"), paragraphFontBold));
                        PdfPCell date = new PdfPCell(new Paragraph("Posted 2 days ago" , paragraphFontBold));
                        emp.setHorizontalAlignment(1);
                        loc.setHorizontalAlignment(1);
                        ind.setHorizontalAlignment(1);
                        date.setHorizontalAlignment(1);
                        emp.setBorder(0);
                        loc.setBorder(0);
                        ind.setBorder(0);
                        date.setBorder(0);
                        table1.addCell(emp);
                        table1.addCell(loc);
                        table1.addCell(ind);
                        table1.addCell(date);
                        document.add(table1);

                        //salary, job type, job level
                        PdfPTable table2 = new PdfPTable(3);
                        PdfPCell salary = new PdfPCell(new Paragraph("Php "+rs.getString("JOB_SALARY_MAX")+"/Month" , paragraphFont));
                        PdfPCell jobtype = new PdfPCell(new Paragraph(rs.getString("TYPE_NAME"), paragraphFont));
                        PdfPCell joblevel = new PdfPCell(new Paragraph(rs.getString("LEVEL_NAME") , paragraphFont));
                        salary.setHorizontalAlignment(1);
                        jobtype.setHorizontalAlignment(1);
                        joblevel.setHorizontalAlignment(1);
                        salary.setBorder(0);
                        jobtype.setBorder(0);
                        joblevel.setBorder(0);
                        table2.addCell(salary);
                        table2.addCell(jobtype);
                        table2.addCell(joblevel);
                        document.add(table2);

                        document.add(new Paragraph(" "));

                        //job desc
                        PdfPTable table3 = new PdfPTable(2);
                        PdfPCell jobdesc = new PdfPCell(new Paragraph("Job Description", paragraphFontBold));
                        PdfPCell emptycell = new PdfPCell(new Paragraph(" "));
                        emptycell.setBorder(2);
                        jobdesc.setBorder(2);
                        jobdesc.setHorizontalAlignment(0);
                        table3.addCell(jobdesc);
                        table3.addCell(emptycell);

                        PdfPTable table4 = new PdfPTable(1);
                        PdfPCell jobDescContent = new PdfPCell(new Paragraph(rs.getString("JOB_DESC")));
                        jobDescContent.setBorder(0);
                        table4.addCell(jobDescContent);
                        document.add(table3);
                        document.add(table4);

                        document.add(new Paragraph(" "));

                        //Company Overview
                        PdfPTable table5 = new PdfPTable(2);
                        PdfPCell overview = new PdfPCell(new Paragraph("Company Overview", paragraphFontBold));
                        overview.setBorder(2);
                        table5.addCell(overview);
                        table5.addCell(emptycell);

                        PdfPTable table6 = new PdfPTable(1);
                        PdfPCell overviewContent = new PdfPCell(new Paragraph(rs.getString("EMP_OVERVIEW")));
                        overviewContent.setBorder(0);
                        table6.addCell(overviewContent);
                        document.add(table5);
                        document.add(table6);

                        document.add(new Paragraph(" "));

                        //Job responsibilities
                        PdfPTable table7 = new PdfPTable(2);
                        PdfPCell jobresp = new PdfPCell(new Paragraph("Responsibilities", paragraphFontBold));
                        jobresp.setBorder(2);
                        table7.addCell(jobresp);
                        table7.addCell(emptycell);

                        PdfPTable table8 = new PdfPTable(1);
                        PdfPCell jobrespContent = new PdfPCell(new Paragraph(splitAndFormat(rs.getString("JOB_RESP"))));
                        jobrespContent.setBorder(0);
                        table8.addCell(jobrespContent);
                        document.add(table7);
                        document.add(table8);

                        document.add(new Paragraph(" "));

                        //Job requirements
                        PdfPTable table9 = new PdfPTable(2);
                        PdfPCell jobreqs = new PdfPCell(new Paragraph("Requirements", paragraphFontBold));
                        jobreqs.setBorder(2);
                        table9.addCell(jobreqs);
                        table9.addCell(emptycell);

                        PdfPTable table10 = new PdfPTable(1);
                        PdfPCell jobreqsContent = new PdfPCell(new Paragraph(splitAndFormat(rs.getString("JOB_REQS"))));
                        jobreqsContent.setBorder(0);
                        table10.addCell(jobreqsContent);
                        document.add(table9);
                        document.add(table10);

                        document.add(new Paragraph(" "));

                        //Job benefit
                        PdfPTable table11 = new PdfPTable(2);
                        PdfPCell jobbenefit = new PdfPCell(new Paragraph("Benefits", paragraphFontBold));
                        jobbenefit.setBorder(2);
                        table11.addCell(jobbenefit);
                        table11.addCell(emptycell);

                        PdfPTable table12 = new PdfPTable(1);
                        PdfPCell jobbenefitContent = new PdfPCell(new Paragraph(splitAndFormat(rs.getString("JOB_BENEFIT"))));
                        jobbenefitContent.setBorder(0);
                        table12.addCell(jobbenefitContent);
                        document.add(table11);
                        document.add(table12);

                        document.add(new Paragraph(" "));
                    }
                    document.close();
                } else {
                        response.sendRedirect("connection-error.jsp");
                }
        } catch (SQLException sqle){
                response.sendRedirect("index.jsp");
        } catch (DocumentException ex) { 
                Logger.getLogger(PrintJobInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NullPointerException e){
                response.sendRedirect("session-error.jsp");
        }
    }

    String splitAndFormat(String input){
        String output = "";
        String[] arr = input.split("\\*");
        for(String bullet: arr){
            if(bullet.trim().isEmpty()){
                continue;
            }
            output += "• "+bullet+"\n";
        }
        return output;
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
