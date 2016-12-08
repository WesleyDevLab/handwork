<%-- 
    Document   : orderAdmin
    Created on : Nov 17, 2016, 12:55:27 PM
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
        <title>JSP Page</title>
    </head>
    <body>
        <div id="wrapper">
            <jsp:include page="headerAdmin.jsp" />
            <jsp:include page="menuAdmin.jsp" />
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="col-md-12">  
                        <div class="panel panel-default panel-table">  
<!--                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col col-xs-6">
                                        <a href="<c:url value="brand/add"/>" role="button" class="btn btn-info  btn " aria-pressed="true"  >New Brand</a>
                                    </div>
                                </div>
                            </div>-->
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
                                                <th>Product</th>
                                                <th>User</th>
                                                <th>Count</th>
                                                <th>Insert Date </th>
                                                 <th>Status</th>
                                                <th><em class="fa fa-cog "></em></th>
                                            </tr> 
                                        </thead>
                                        <c:forEach items="${orders}" var="ord">
                                            <tbody>
                                                <tr>
                                                    
                                                    <td class="col-sm-1">${ord.id }</td>
                                                    <td class="col-sm-2">${ord.productId.title }</td>
                                                    <td class="col-sm-2">${ord.userId.firstname }  ${ord.userId.lastname }</td>
                                                    <td class="col-sm-1">${ord.count }</td>
                                                    <td class="col-sm-2">${ord.insertDate }</td>
                                                    <td class="col-sm-1">${ord.statusId.status }</td>
                                                    <td class="col-sm-2" align="center">
                                                        <a href="<c:url value="viewOrder/${ord.id}"/>" class="btn btn-info"><em class="fa fa-search"></em></a>
                                                        <a href="<c:url value="editOrder/${ord.id}"/>" class="btn btn-success"><em class="fa fa-pencil"></em></a>
                                                        <a href="<c:url value="order/${ord.id}/delete"/>" class="btn btn-danger"><em class="fa fa-trash"></em></a>
                                                    </td>
                                                </tr>                  
                                            </tbody>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
