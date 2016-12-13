<%--
    Document   : header
    Created on : Oct 25, 2016, 1:03:55 AM
    Author     : Rashad Javadov
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- //for-mobile-apps -->
        <link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <!-- js -->
        <script src="${pageContext.request.contextPath}/resources/js/jquery-1.10.2.js"></script>

        <link href="${pageContext.request.contextPath}/resources/css/megamenu.css" rel="stylesheet" type="text/css" media="all" />

        <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

        <script src="${pageContext.request.contextPath}/resources/js/responsiveslides.min.js"></script>
        <script type="text/javascript">

            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
                });
            });
        </script>


        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/megamenu.js"></script>
        <script>$(document).ready(function () {
                $(".megamenu").megamenu();
            });
        </script>

        <!-- Google Analytics -->
        <script>
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r;
                i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments);
                }, i[r].l = 1 * new Date();
                a = s.createElement(o),
                        m = s.getElementsByTagName(o)[0];
                a.async = 1;
                a.src = g;
                m.parentNode.insertBefore(a, m);
            })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');

            ga('create', 'UA-88577023-1', 'auto');
            ga('send', 'pageview');

        </script>
        <!-- End Google Analytics --> 
        <script src="${pageContext.request.contextPath}/resources/js/simpleCart.min.js"></script> 
    </head>
    <body>
        <div class="top_bg">
            <div class="container">
                <div class="header_top-sec">
                    <div class="top_right">
                        <ul>
                            <li><a href="contact">Əlaqə</a></li>|
                            <li><a href="mailto:info@example.com">info@opal.az</a></li>
                        </ul>
                    </div>
                    <div class="top_left">
                        <ul> 
                            <li class="top_link"><a href="checkout?typeId=3">Səbət</a></li>|
                                <sec:authorize access="!isAuthenticated()">
                                <li class="top_link"><a href="profile">Hesabım</a></li>
                                </sec:authorize> 
                                <sec:authorize access="isAuthenticated()">
                                    <sec:authentication var="imgUrlProfile" scope="request" property="principal.users.image"/>
                                <li class="top_link">
                                    <a style="padding-top : 1px  ! important; padding-bottom: 1px ! important;" href="<c:url value="/profile" />">
                                        <img style="height: 30px;border: 2px solid;border-radius: 25px;" 
                                             onerror="http://www.brentfordfc.co.uk/images/common/bg_player_profile_default_big.png"  src="${imgUrlProfile}">
                                    </a>
                                </li> | 

                                <li class="top_link"><a href="<c:url value="/logout" />">Log Out</a></li>  
                                </sec:authorize>


                        </ul> 
                    </div>

                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <!-- top-header -->
        <!-- logo-cart -->
        <div class="header_top">
            <div class="container">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/index">Opal.az</a>			 
                </div>
                <div class="header_right">
                    <!--                    <div class="cart box_1">
                                            <a href="checkout.html">
                                                <h3> <div class="total">
                                                        <span class="simpleCart_total"></span> (<span id="simpleCart_quantity" class="simpleCart_quantity"></span> items)</div>
                                                    <img src="$1{pageContext.request.contextPath}/resources/images/cart1.png" alt=""/></h3>
                                            </a>
                                            <p><a href="javascript:;" class="simpleCart_empty">Empty Cart</a></p>
                                            <div class="clearfix"> </div>
                                        </div>				 -->
                </div>
                <div class="clearfix"></div>	
            </div>
        </div>
    </body>
</html>