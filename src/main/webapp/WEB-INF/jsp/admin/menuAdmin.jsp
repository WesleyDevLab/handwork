<%-- 
    Document   : menuAdmin
    Created on : Nov 7, 2016, 10:24:16 AM
    Author     : Azik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

    </head>
    <body>
        <nav class="navbar-default navbar-side" role="navigation">
            <div id="sideNav" href="#"><i class="fa fa-caret-right"></i></div>
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">

                    <li>
                        <a class="active-menu" href="${pageContext.request.contextPath}/index.html"><i class="fa fa-dashboard"></i>Users</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/products"><i class="fa fa-desktop"></i> Product</a>
                    </li>
                    <li>
                        <a href="ui-elements.html"><i class="fa fa-desktop"></i> Order <span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level active-menu">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/checkoutList?typeId=3">Səbət</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/checkoutList?typeId=2">Təhvil Verilən</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/checkoutList?typeId=1">Gözləmədə olanlar</a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/checkoutList?typeId=4">Silinən</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/categoryAdmin"><i class="fa fa-bar-chart-o"></i> Category </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/brands"><i class="fa fa-qrcode"></i> Brand</a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/admin/faqAdmin"><i class="fa fa-table"></i> FAQ</a>
                    </li>
                    <li>
                        <a href="form.html"><i class="fa fa-edit"></i> Forms </a>
                    </li>


                    <li>
                        <a href="#"><i class="fa fa-sitemap"></i> Category <span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="#">Category</a>
                            </li>
                            <li>
                                <a href="#">Brand</a>
                            </li>
                            <li>
                                <a href="#">Second Level Link</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="empty.html"><i class="fa fa-fw fa-file"></i> Empty Page</a>
                    </li>
                </ul>

            </div>

        </nav>
    </body>
</html>
