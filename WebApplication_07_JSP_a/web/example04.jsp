<%-- 
    Document   : example04
    Created on : Feb 10, 2025, 1:36:25 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- in ra bang cua chuong -->
      
        <%
            for(int i=2;i<=9;i++){
            %>
            <hr/>
            <h3>bang cuu chuong <%=i%></h3>
            <%
            for(int j=1;j<=9;j++){
              
                %>
                <%=i%> * <%=j%> = <%=(i*j)%><br/>
                <%
            }
        }
        %>
    </body>
</html>
