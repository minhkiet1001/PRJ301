<%-- 
    Document   : search
    Created on : Mar 17, 2025, 6:20:22 PM
    Author     : Admin
--%>

<%@page import="dto.BookDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if(session.getAttribute("user")!=null){
                UserDTO user = (UserDTO) session.getAttribute("user");
                
                %>
                <h1> Welcome <%=user.getFullName()%> </h1>
                <form action="MainController" >
                      <input type="hidden" name="action" value="logout"/>
                      <input type="submit" value="Logout"/>
                    
                </form>
               <%
               String searchTerm = request.getAttribute("searchTerm")+"";
               searchTerm = searchTerm.equals("null")?"":searchTerm;
                %>
                <form action="MainController">
                    <input type="hidden" name="action" value="search"/>
                    Search Books: <input type="text" name="searchTerm" value="<%=searchTerm%>"/>
                    <input type="submit" value="Search"/>
                </form>
                    
                    <a href="bookForm.jsp">
                        Add
                    </a>
                       
                <%
                   if(request.getAttribute("books")!=null){
                       List<BookDTO> books = (List<BookDTO>) request.getAttribute("books");
                       
                     %>
                     <table>
                         <thead>
                             <tr>
                                 <th>BookID</th>
                                 <th>Title</th>
                                 <th>Author</th>
                                 <th>PublishYear</th>
                                 <th>Price</th>
                                 <th>Quantity</th>
                                 <th>Action</th>
                                 
                             </tr>
                         </thead>
                         <tbody>
                             
                             <%
                                 for (BookDTO b : books){
                                     %>
                                     <tr>
                                         <td><%=b.getBookID()%></td>
                                         <td><%=b.getTitle()%></td>
                                         <td><%=b.getAuthor()%></td
                                         <td><%=b.getPublishYear()%></td>
                                         <td><%=b.getPrice()%></td>
                                         <td><%=b.getQuantity()%></td>
                                         <td><a href="MainController?action=delete&id=<%=b.getBookID()%>&searchTerm=<%=searchTerm%>"
                             
                                         <img src="assets/images/delete-icon.png" style="height: 25px"/>
                                             </a> </td>
                                             
                                     </tr> 
                                     
                                     
                                   <% 
                                 }
                             %>
                         </tbody>
                     </table>
                         
                  <%  
                   }
                    }else{ %>
               you do not have permission to access this content.
               <%}
                %>
               
            

        
    </body>
</html>
