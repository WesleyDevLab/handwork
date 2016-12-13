<%-- 
    Document   : login2
    Created on : Oct 28, 2016, 9:00:35 PM
    Author     : Rashad Javadov
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--https://siteorigin.com/thread/change-the-image-of-the-arrows-in-the-flexslider-of-metaslider/-->
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Opal.az - ${product.title}</title>
        <link rel="shortcut icon"  href="https://p.w3layouts.com/demos/pendent_store/web/images/cart1.png" type="image/png">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <link href="${pageContext.request.contextPath}/resources/css/social-share-kit.css" rel="stylesheet" />  
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/social-share-kit.js"></script> 
    </head>
    <body>
        <script type="text/javascript">
            SocialShareKit.init({
                onBeforeOpen: function (targetElement, network, paramsObj) {
                    console.log(arguments);
                },
                onOpen: function (targetElement, network, networkUrl, popupWindow) {
                    console.log(arguments);
                },
                onClose: function (targetElement, network, networkUrl, popupWindow) {
                    console.log(arguments);
                }
            });
        </script>
        <jsp:include page="fragment/header.jsp" />
        <jsp:include page="fragment/menu.jsp" />


        <script>
            window.fbAsyncInit = function () {
                FB.init({
                    appId: '213755122398029',
                    xfbml: true,
                    version: 'v2.5'
                });
            };

            (function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) {
                    return;
                }
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));

        </script>

        <div class="single">
            <div class="container">
                <div class="single-page">					 
                    <div class="flexslider details-lft-inf">

                        <div class="flex-viewport" style="overflow: hidden; position: relative;">
                            <ul class="slides" style="width: 1200%; transition-duration: 0.6s; transform: translate3d(-618px, 0px, 0px);">
                                <li data-thumb="${pageContext.request.contextPath}/resources/images/s4.jpg" class="clone" aria-hidden="true" style="width: 206px; height:  206px; float: left; display: block;">
                                    <img src="${pageContext.request.contextPath}/resources/images/s4.jpg" draggable="false">
                                </li>
                                <li data-thumb="${pageContext.request.contextPath}/resources/images/s1.jpg" class="" style="width: 206px; height:  206px; float: left; display: block;">
                                    <img src="${pageContext.request.contextPath}/resources/images/s1.jpg" draggable="false">
                                </li>
                                <li data-thumb="${pageContext.request.contextPath}/resources/images/s2.jpg" style="width: 206px; height:  206px; float: left; display: block;" class="">
                                    <img src="${pageContext.request.contextPath}/resources/images/s2.jpg" draggable="false">
                                </li>
                                <li data-thumb="${pageContext.request.contextPath}/resources/images/s3.jpg" style="width: 206px; height:  206px; float: left; display: block;" class="flex-active-slide">
                                    <img src="${pageContext.request.contextPath}/resources/images/s3.jpg" draggable="false">
                                </li>
                                <li data-thumb="${pageContext.request.contextPath}/resources/images/s4.jpg" style="width: 206px;  height:  206px; float: left; display: block;" class="">
                                    <img src="${pageContext.request.contextPath}/resources/images/s4.jpg" draggable="false">
                                </li>
                                <li data-thumb="${pageContext.request.contextPath}/resources/images/s1.jpg" class="clone" aria-hidden="true" style="width: 206px;  height:  206px; float: left; display: block;">
                                    <img src="${pageContext.request.contextPath}/resources/images/s1.jpg" draggable="false">
                                </li>
                            </ul>
                        </div>

                        <!--                        <ol class="flex-control-nav flex-control-thumbs">
                                                    <li>
                                                        <img src="$!{pageContext.request.contextPath}/resources/images/s1.jpg" class="" draggable="false">
                                                    </li>
                                                    <li>
                                                        <img src="$!{pageContext.request.contextPath}/resources/images/s2.jpg" draggable="false" class="">
                                                    </li>
                                                    <li>
                                                        <img src="$!{pageContext.request.contextPath}/resources/images/s3.jpg" draggable="false" class="flex-active">
                                                    </li>
                                                    <li>
                                                        <img src="$!{pageContext.request.contextPath}/resources/images/s4.jpg" draggable="false" class="">
                                                    </li>
                                                </ol>-->
                        <ul class="flex-direction-nav">
                            <li class="flex-nav-prev">
                                <a class="flex-prev" href="#">Previous</a>
                            </li>
                            <li class="flex-nav-next">
                                <a class="flex-next" href="#">Next</a>
                            </li>
                        </ul>
                    </div>
                    <!-- FlexSlider -->
                    <script defer="" src="${pageContext.request.contextPath}/resources/js/jquery.flexslider.js"></script>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flexslider.css" type="text/css" media="screen">

                    <script>
            // Can also be used with $(document).ready()
            $(window).load(function () {
                $('.flexslider').flexslider({
                    animation: "slide",
                    controlNav: "thumbnails"
                });
            });
                    </script>
                    <div class="details-left-info">
                        <h3>${product.title}</h3>
                        <h4>${product.categoryId.name} </h4>
                        <div class="simpleCart_shelfItem">
                            <p>
                                <span style="font-weight: bold;" class="item_price qwe">Qiymət :  ${product.price} AZN</span> 
                            </p>

                            <form method="post" action="addtocard">
                                <p class="qty">Say :</p>
                                <input min="1" type="number" id="quantity" name="quantity" value="1" class="form-control input-small">
                                <input type="hidden" name="${_csrf.parameterName}" 	value="${_csrf.token}" />
                                <input type="hidden" id="code" name="code"  value="1" />
                                <div class="single-but item_add">
                                    <input type="submit" value="add to cart">
                                </div>
                            </form>
                            <!--social share-->

                        </div>
                        <div class="flower-type">
                            <p>Brend  :  ${product.brandId.name}</p>
                            <p>Kateqoriya  :  ${product.categoryId.name}</p>
                            <p>Əlavə edilib  :  ${product.insertDate}</p>

                        </div>
                        <p class="desc">
                            ${product.description}
                        </p> 
                    </div>

                    <div class="ssk-sm ssk-group"  
                         data-url="opal.az/view?code=${dataCode}" 
                         data-text="${product.description}"
                         data-title="${product.title}" > <!--  data-image="$!{content.imgUrl}"   -->
                        <a  class="ssk ssk-facebook"></a>
                        <a  class="ssk ssk-twitter"></a>
                        <a  class="ssk ssk-google-plus"></a> 
                    </div>

                    <div class="clearfix"></div>

                </div>

                <!-- collapse -->
                <!---728x90--->
                <div class="panel-group collpse" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    Ətraflı
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body"> 
                                <div  class="fb-comments" data-href="http://opal.az/view?code=${dataCode}#configurator" data-mobile="true" data-numposts="5"></div>
                            </div>
                        </div>

                    </div> 


                </div>
                <!-- collapse -->
                <!-- related products -->
                <div class="related-products">
                    <h3>Uyğun Məhsullar</h3> 
                    <c:forEach items="${sameCatProducts}" var="pro" varStatus="index" >
                        <div class="col-md-4 related products-grid">
                            <img src="${pageContext.request.contextPath}/resources/images/19.jpg" alt=" " class="img-responsive">
                            <div class="simpleCart_shelfItem rel">
                                <p><span class="overline">AZN ${pro.price}</span> <span class="item_price val"></span></p>
<!--                                <div class="single-but item_add">
                                    <input type="submit" value="add to cart">
                                </div>-->
                            </div>
                        </div>
                    </c:forEach> 
 
                    <div class="clearfix"> </div>
                </div>
                <!-- //related products -->
            </div>
        </div>






        <jsp:include page="fragment/footer.jsp" />

    </body>
</html>
