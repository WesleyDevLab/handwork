<%-- 
    Document   : banner
    Created on : Oct 25, 2016, 3:39:33 PM
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

        <div class="cate-bottom">
            <div class="container">
                <div class="cate-bottom-info">
                    <h3>Əl işləri Yeni kolleksiya </h3>
                    <p>En keyfiyyetli toxunma el işleri bizde 
                        <span> Zovqe uygun destler bizde sifaris vere bilersiz.</span></p>
                    <div class="buy let">
                        <a href="single.html">Read More</a>
                    </div>
                </div>
            </div>
        </div>
        <!--         //cate-bottom -->
        <!-- cate -->
        <div class="cate">
            <div class="container">
                <div class="cate-left">
                    <h3>Yeni <span>Son Məhsullar</span></h3>
                </div>
                <div class="cate-right">
                    <!-- slider -->
                    <ul id="flexiselDemo1">
                        <c:forEach items="${listLast}" var="last"  >
                            <li>
                                <div class="sliderfig-grid">
                                    <a href="<c:url value="view?code=${last.productId.PId}"/>">
                                        <img src="${pageContext.request.contextPath}/resources/images/${last.imgName}" alt=" " class="img-responsive" />
                                    </a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                </div>
                <!-- //slider -->
                <div class="clearfix"> </div>
            </div>
        </div>
        <!-- //cate -->
        <!-- cate -->
        <div class="cate">
            <div class="container">
                <div class="cate-left">
                    <h3>Ən Baxımlı <span>Məhsullarımız</span></h3>
                </div>
                <div class="cate-right">
                    <!-- slider -->
                    <ul id="flexiselDemo2">
                        <c:forEach items="${listMost}" var="best"  >
                            <li>
                                <div class="sliderfig-grid">
                                    <a href="<c:url value="view?code=${last.productId.PId}"/>"> 
                                        <img src="${pageContext.request.contextPath}/resources/images/${best.imgName}" alt=" " class="img-responsive" />
                                    </a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                </div>
                <!-- //slider -->
                <div class="clearfix"> </div>
            </div>
        </div>
    
        <script type="text/javascript">
            $(window).load(function () {
                $("#flexiselDemo1").flexisel({
                    visibleItems: 4,
                    animationSpeed: 1000,
                    autoPlay: true,
                    autoPlaySpeed: 3000,
                    pauseOnHover: true,
                    enableResponsiveBreakpoints: true,
                    responsiveBreakpoints: {
                        portrait: {
                            changePoint: 480,
                            visibleItems: 3
                        },
                        landscape: {
                            changePoint: 640,
                            visibleItems: 4
                        },
                        tablet: {
                            changePoint: 768,
                            visibleItems: 3
                        }
                    }
                });
                $("#flexiselDemo2").flexisel({
                    visibleItems: 4,
                    animationSpeed: 1000,
                    autoPlay: true,
                    autoPlaySpeed: 3000,
                    pauseOnHover: true,
                    enableResponsiveBreakpoints: true,
                    responsiveBreakpoints: {
                        portrait: {
                            changePoint: 480,
                            visibleItems: 3
                        },
                        landscape: {
                            changePoint: 640,
                            visibleItems: 4
                        },
                        tablet: {
                            changePoint: 768,
                            visibleItems: 3
                        }
                    }
                });
            });
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.flexisel.js"></script>
    </body>
</html>
