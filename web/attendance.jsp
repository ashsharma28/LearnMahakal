<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.vibhuti.lms.Controller" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>



<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory,org.apache.commons.fileupload.servlet.ServletFileUpload, javax.servlet.ServletContext" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>


<HTML>

<head>
    <title>Upload file</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link rel="stylesheet" href="layout/styles/layout.css" type="text/css"/>
</head>


<jsp:include page="header.html"></jsp:include>

<div id="mainContent" style="margin-left:35%; margin-top: 3%; ">

    <h2>Upload Attendance file</h2>

    <form action="attendance.jsp" method="post" enctype="multipart/form-data">
    Description: <input type="text" name="description" /><br>
    <input type="file" name="file" /><br>
    <input type="submit" />
</form>



<%!
    Connection con;

    public void jspInit()
    {
        try {
             String url ;

            if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production)
            {
                Class.forName("com.mysql.jdbc.GoogleDriver");
                url = "jdbc:google:mysql://expensemanager28:expensedatabase/learnmahakal";
            }
            else
            {
                Class.forName("com.mysql.jdbc.Driver");
                url = "jdbc:mysql://localhost:3306/expensemanager";                  // jdbc:mysql://ip-address-of-google-cloud-sql-instance:3306/guestbook?user=root
            }

            con = DriverManager.getConnection(url, "root", "");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    String[] doUpload(JspWriter out, PageContext pageContext, HttpServletRequest request  ) throws IOException {
        File file;
        String path ="";

        int maxFileSize = 5000 * 1024;
        int maxMemSize = 5000 * 1024;
        ServletContext context = pageContext.getServletContext();
        String filePath = context.getInitParameter("attendance-upload");


        String[] toReturn = new String[3];

        if (request.getMethod().equalsIgnoreCase("POST")) {

            // Verify the content type
            String contentType = request.getContentType();
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
                // Location to save data that is larger than maxMemSize.
                factory.setRepository(new File("c:\\temp"));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);
                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(request);

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>JSP File upload</title>");
                    out.println("</head>");
                    out.println("<body>");

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {

                            // Get the uploaded file parameters
                            String fieldName = fi.getFieldName();
                            String fileName = fi.getName();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            // Write the file
                            if (fileName.lastIndexOf("\\") >= 0) {
                                file = new File(filePath +
                                        fileName.substring(fileName.lastIndexOf("\\")));
                            } else {
                                file = new File(filePath +
                                        fileName.substring(fileName.lastIndexOf("\\") + 1));
                            }
                            fi.write(file);


                            toReturn[2] = filePath+fileName;
                        }

                        else{

                            String fieldname = fi.getFieldName();
                            if(fieldname.equals("description")){
                                InputStream filecontent = fi.getInputStream();
                                byte b[] = new byte[filecontent.available()];
                                filecontent.read(b);


                                toReturn[1] = new String(b);
                            }

                            if(fieldname.equals("subject")){
                                InputStream filecontent = fi.getInputStream();
                                byte b[] = new byte[filecontent.available()];
                                filecontent.read(b);


                                toReturn[0] = new String(b);
                            }

                        }
                    }
                    out.println("</body>");
                    out.println("</html>");
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            else
            {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet upload</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<p>No file uploaded</p>");
                out.println("</body>");
                out.println("</html>");
                toReturn[2] = "FILE NOT FOUND";
            }


        }

        return toReturn;

    }
%>



<%


    if (request.getMethod().equalsIgnoreCase("POST"))
    {
        String[] ourPackage = doUpload(out, pageContext, request);

        String subject = ourPackage[0];
        String description  = ourPackage[1];
        String path  = ourPackage[2];


        Controller controller = new Controller();
        Exception exception = controller.addAttendance(con, description, path);

        if(exception==null)out.print("Success");
        else out.print("Failed. Reason: \n -> " +exception);

    }





%>


</div>

</body>
</HTML>