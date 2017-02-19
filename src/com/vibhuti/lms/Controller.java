package com.vibhuti.lms;

import javax.jws.Oneway;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Objects;

/**
 *A common controller class for handling CRUD operations
 * Created by admin on 22-Mar-16.
 */
public class Controller {

    public Exception createFacultyAccount(Connection con,  String username,
                                     String password, String subject1,
                                     String subject2, String subject3, String subject4 ){
        try {



            PreparedStatement statement = con.prepareStatement
                    ("INSERT INTO users (subject1, subject2, subject3, subject4 ,username, password) VALUES (? ,? , ? , ? , ?, ?);");
            statement.setString(1, subject1);
            statement.setString(2, subject2);
            statement.setString(3, subject3);
            statement.setString(4, subject4);
            statement.setString(5, username);
            statement.setString(6,password);


          statement.execute();


            return null;


        } catch (SQLException e) {
            e.printStackTrace();
            return e;
        }

    }



    public Exception addFile(Connection con, String subject, String description, String path){
        try {
            PreparedStatement statement = con.prepareStatement
                    ("INSERT INTO filesRecord (subject, description, path ) VALUES (?, ?, ?);");
            statement.setString(1, subject);
            statement.setString(2, description);
            statement.setString(3, path);

            statement.execute();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return e;
        }

    }


 public Exception addAttendance(Connection con, String description, String path){
        try {
            PreparedStatement statement = con.prepareStatement
                    ("INSERT INTO attendancerecord (description, path ) VALUES (?, ?);");
            statement.setString(1, description);
            statement.setString(2, path);

            statement.execute();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return e;
        }

    }


    public ResultSet getFiles(Connection con, String query ) {
        ResultSet resultSet = null;
        try {

            PreparedStatement preparedStatement = preparedStatement = con.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultSet;
    }

    public ResultSet readFacultyAccount(Connection con, String query ) {
        ResultSet resultSet = null;


        try {

            PreparedStatement preparedStatement = preparedStatement = con.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultSet;
    }


    /**
     *
     * @param con is the Connection object
     * @param query is the SQL query that is sent to MySQL
     * @return
     */

    public Exception updateFacultyInfoWithQuery(Connection con, String query){
        int i =0;
        try {
            Statement statement = con.createStatement();
            statement.executeUpdate(query);

            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return e;
        }

    }


    public boolean deleteFacultyWithQuery(Connection con, String query){
        int i =0;
        try {
            Statement statement = con.createStatement();
            i = statement.executeUpdate(query);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        if(i==0)return false;
        else return true;
    }


    /**
     * This is an wrapper on readFacultyAccount that prints the complete table of MySql in <code>HttpServletResponse</code>
     * @param response is the HttpServletResponse of the Servlet that is calling this method
     * @param con is the Connection object
    */
    public void getInfo(HttpServletResponse response, Connection con){

        try {
            PrintWriter printWriter = response.getWriter();

            printWriter = response.getWriter();
            response.setContentType("text/html");
            Controller controller = new Controller();
            ResultSet resultSet = controller.readFacultyAccount(con, "SELECT * FROM facultyinfo");


            printWriter.append("<table border=1px>");
            while (resultSet.next()){
                printWriter.append("<tr>");

                printWriter.append("<td>");
                printWriter.append(resultSet.getString(1)+ "\t");
                printWriter.append("</td>");

                printWriter.append("<td>");
                printWriter.append(resultSet.getString(2)+ "\t");
                printWriter.append("</td>");

                printWriter.append("<td>");
                printWriter.append(resultSet.getString(3)+ "\t");
                printWriter.append("</td>");

                printWriter.append("<td>");
                printWriter.append(resultSet.getString(4)+ "\t");
                printWriter.append("</td>");

                printWriter.append("<td>");
                printWriter.append(resultSet.getInt(5) + "\n");
                printWriter.append("</td>");

                printWriter.append("</tr>");
            }

            printWriter.append("</table>");
            printWriter.append("\n" + "<h3>end</h3>");


        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

}






    /*

    ADIMN:
    DONE - add users C
    DONE - retrieving the information R
    DONE  -update users info U
    TODO -delete user D
    */


    /*

    Faculty members can
    TODO view- as Profiles R
    TODO update  U TODO their personal and professional information

    */
