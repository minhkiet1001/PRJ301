<%-- 
    Document   : index
    Created on : Mar 13, 2025, 1:44:01 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="dto.BookDTO"%>
<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
                if (request.getAttribute("books") != null) {
                    List<BookDTO> books = (List<BookDTO>) request.getAttribute("books");

            %>
            <table class="book-table">
                <thead>
                    <tr>
                        <th>BookID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>PublishYear</th>
                        <th>Price</th>
                        <th>Quantity</th>
                            <%  if (AuthUtils.isAdmin(session)) {%>
                        <th>Action</th>
                            <%}%>
                    </tr>
                </thead>
                <tbody>
                    <%            for (BookDTO b : books) {
                    %>
                    <tr>
                        <td><%=b.getBookID()%></td>
                        <td><%=b.getTitle()%></td>
                        <td><%=b.getAuthor()%></td>
                        <td><%=b.getPublishYear()%></td>
                        <td><%=b.getPrice()%></td>
                        <td><%=b.getQuantity()%></td>
                       
                       
                                <img src="assets/images/delete-icon.png"  style="height: 25px"/>                              
                            </a></td>
                            
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%    }
           
            %>
    </body>
</html>
