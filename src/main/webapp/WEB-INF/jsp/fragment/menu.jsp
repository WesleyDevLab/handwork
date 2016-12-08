<%-- 
    Document   : menu
    Created on : Oct 25, 2016, 1:04:05 AM
    Author     : Azik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <div class="mega_nav">
            <div class="container">
                <div class="menu_sec">
                    <!-- start header menu -->
                    <ul class="megamenu skyblue">
                        <li class="active grid">
                            <a class="color1" href="products">Ana Menu</a>
                            <div class="megapanel">
                                <div class="row">
                                    <div class="col1">
                                        <div class="h_nav">
                                            <h4>Kateqoriyalar</h4>
                                            <ul>
                                                <c:forEach items="${listWrapper.categoryList}" varStatus="i" var="function"> 
                                                    <li>
                                                        <a  href="products?catgs=[${function.catId}]">${function.name}</a>
                                                    </li>
                                                </c:forEach> 
                                            </ul>	
                                        </div>							
                                    </div>
                                    <!--                                    <div class="col1">
                                                                            <div class="h_nav">
                                                                                <h4>Style Zone</h4>
                                                                                <ul>
                                                                                    <li><a href="products.html">Men</a></li>
                                                                                    <li><a href="products.html">Women</a></li>
                                                                                    <li><a href="products.html">Brands</a></li>
                                                                                    <li><a href="products.html">Kids</a></li>
                                                                                    <li><a href="products.html">Accessories</a></li>
                                                                                    <li><a href="products.html">Style Videos</a></li>
                                                                                </ul>	
                                                                            </div>							
                                                                        </div>-->
                                </div>							
                            </div>
                        </li>
                        <c:forEach items="${listWrapper.brandCatList}" varStatus="i" var="function"> 
                            <li>
                                <a class="color1" href="products?brands=[${function.id}]">${function.name}</a>
                            </li>
                        </c:forEach>

                    </ul> 
                    <div class="search">
                        <form action="products"   method="get">
                            <input type="text" name="keyValue" value="" placeholder="Search...">
                            <input type="submit" value="">
                        </form>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </body>
</html>
