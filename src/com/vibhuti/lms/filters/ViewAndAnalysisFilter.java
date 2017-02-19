package com.vibhuti.lms.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import com.google.appengine.api.utils.SystemProperty;



public class ViewAndAnalysisFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession(false);

        String info = request.getServletPath();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.


        if(     info.contains("login.jsp")||
                    info.contains("header.html")||
                    info.contains("/data")  ||
                    info.contains("/pages")  ||
                    info.contains("/layout")  ||
                    info.contains("/images")  ||
                    info.contains("/attendance")  ||
                    info.contains("index.html")  ||
                    info.contains("viewAllAttendance.jsp")  ||
                    info.contains("attendance.jsp")  ||
                    info.contains("download.jsp")||
                    info.contains("viewUploads.jsp")
              )
            {
                chain.doFilter(req, resp);
                return;
            }


        if(info.contains("login.html")){
            if(session==null){
                chain.doFilter(req, resp);
                return;
            }
            else if(session.getAttribute("username").equals("admingullu")){
                response.sendRedirect("AdminPanel.jsp");
                return;
            }
            else {
                response.sendRedirect("UserDashboard.jsp");
                return;
            }
        }


            if(session == (null))
            {
                response.setContentType("text/html");
                RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher("/login.html");
                response.getWriter().print("Please login to continue");
                requestDispatcher.include(request, response);
            }

            else if(session.getAttribute("username")!=null)  {

                printWriter = response.getWriter();
                chain.doFilter(req, resp);
            }


    }

    ServletContext servletContext;
    Connection con;
    PrintWriter printWriter;

    public void init(FilterConfig config) throws ServletException {

        try {
            servletContext = config.getServletContext();


            String url ;

            if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production)
            {
                Class.forName("com.mysql.jdbc.GoogleDriver");
                url = "jdbc:google:mysql://expensemanager28:expensedatabase/learnmahakal";
            }
            else
            {
                Class.forName("com.mysql.jdbc.Driver");
                url = "jdbc:mysql://localhost:3306/expensemanager";

                // jdbc:mysql://ip-address-of-google-cloud-sql-instance:3306/guestbook?user=root
            }


            con = DriverManager.getConnection(url, "root", "");


        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


}
