<%-- 
    Document   : userAdmin
    Created on : Nov 24, 2016, 9:38:26 PM
    Author     : Azik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/mainPagingTag.tld"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users Admin</title>
    </head>
    <body>
        <div id="wrapper">
            <jsp:include page="headerAdmin.jsp" />
            <jsp:include page="menuAdmin.jsp" />
             <spring:url value="/users" var="users" />
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="col-md-12">  
                        <div class="panel panel-default panel-table">  
                            <div class="panel-heading ">
                                <div class="row ">
                                    <form:form id="headerSearchForm" action="users" modelAttribute="users" class="col-sm-3 col-md-3 col-lg-12"  method="GET">
                                        <div class="navbar-btn navbar-btn">
                                            <spring:bind path="username">   
                                                <div class="col-sm-3 col-md-3 col-lg-3"> 
                                                    <form:input path="username" type="text" class="form-control" id="username" placeholder="Enter Username"/>
                                                </div> 
                                            </spring:bind> 
                                            <spring:bind path="firstname">  
                                                <div class="col-sm-3 col-md-3 col-lg-3"> 
                                                    <form:input path="firstname" type="text" class="form-control" id="firstname" placeholder="Enter Firstname"/>
                                                </div> 
                                            </spring:bind> 
                                            <spring:bind path="lastname">  
                                                <div class="col-sm-3 col-md-3 col-lg-3 "> 
                                                    <form:input path="lastname" type="text" class="form-control" id="lastname" placeholder="Enter Lastname"/>
                                                </div> 
                                            </spring:bind> 
                                            <spring:bind path="phone">  
                                                <div class="col-sm-3 col-md-3 col-lg-3"> 
                                                    <form:input path="phone" type="text" class="form-control" id="phone" placeholder="Enter Phone"/>
                                                </div> 
                                            </spring:bind> 
                                            <div class="col-sm-3 col-md-3 col-lg-3">                                     
                                                </div> 
                                                 
                                            <div class="col-sm-3 col-md-3 col-lg-4"> 
                                                <spring:bind path="enabled">  
                                                    <form:select id="keyValue" class="btn  btn active" path="enabled">
                                                        <form:option value="1">Aktiv</form:option>>
                                                        <form:option value="2">Deleted</form:option>>
                                                    </form:select>
                                                </spring:bind> 
                                            </div>
                                            <div class="col-sm-3 col-md-3 col-lg-3 "> 

                                                <button type="submit"  class="btn btn-primary">Search</button>
                                            </div>

                                        </div>
                                    </form:form>
                                </div>
                            </div>
                            <div class="panel-body">
                                <c:if test="${not empty msg}">
                                    <div class="alert alert-${css} alert-dismissible" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>${msg}</strong>
                                    </div>
                                </c:if> 
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-list">
                                        <thead>
                                            <tr>

                                                <th class="hidden-xs">ID</th>
                                                <th>Username</th>
                                                <th>Name</th>
                                                <th>Surname</th>
                                                <th>Phone</th>
                                                <th>Gender</th>
                                                <th><em class="fa fa-cog "></em></th>
                                            </tr> 
                                        </thead>
                                        <c:forEach items="${usersList}" var="us">
                                            <tbody>
                                                <tr>

                                                    <td class="col-sm-1">${us.userId}</td>
                                                    <td class="col-sm-2">${us.username}</td>
                                                    <td class="col-sm-2">${us.firstname}</td>
                                                    <td class="col-sm-2">${us.lastname}</td>
                                                    <td class="col-sm-2">${us.phone}</td>
                                                    <td class="col-sm-1">${us.genderId.type}</td>
                                                    <td align="center">
                                                        <a href="<c:url value="editUser/${us.userId}"/>" class="btn btn-info"><em class="fa fa-pencil"></em></a>
                                                        <a href="<c:url value="user/${us.userId}/delete"/>" class="btn btn-danger"><em class="fa fa-trash"></em></a>
                                                    </td>
                                                </tr>                  
                                            </tbody>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                            <div style="margin-left: 10px;margin-top: 10px;" class="panel"> 
                                <tag:paginate max="15" offset="${offset}"  count="${count}" uri="users"  keyValue="${keyValue}" next="&raquo;" previous="&laquo;" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
