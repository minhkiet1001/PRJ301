<%-- 
    Document   : login
    Created on : Mar 17, 2025, 5:58:59 PM
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
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="login"/>
            <label for="userId" > ten dang nhap</label>
            <input type="text" id="userId" name="txtUserID" required />
            <label for="password" >mat khau</label>
            <input type="password" id="password" name="txtPassword" required/>
            <button type="submit" >dang nhap</button>
                
        </form>
        <%
           String message = request.getAttribute("message")+"";
        %>
        
        <%=message.equals("null")?"":message%>
    </body>
</html>
