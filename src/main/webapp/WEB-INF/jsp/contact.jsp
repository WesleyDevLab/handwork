<%-- 
    Document   : contact
    Created on : Oct 28, 2016, 10:13:35 PM
    Author     : rasha_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Opal.az - Əlaqə</title>
        <link rel="shortcut icon"  href="https://p.w3layouts.com/demos/pendent_store/web/images/cart1.png" type="image/png">
    </head>
    <body>
        <jsp:include page="fragment/header.jsp" />
        <jsp:include page="fragment/menu.jsp" />

        <!-- contact -->
        <div class="contact-bottom">
            <iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d96908.54934770924!2d-73.74913540000001!3d40.62123259999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1sanimal+rescue+service+near+Inwood%2C+New+York%2C+NY%2C+United+States!5e0!3m2!1sen!2sin!4v1436335928062" frameborder="0" style="border:0" allowfullscreen></iframe>
            <!---->
         
            <!--<script src='https://maps.googleapis.com/maps/api/js?v=3.exp'></script><div style='overflow:hidden;height:440px;width:700px;'><div id='gmap_canvas' style='height:440px;width:700px;'></div><div><small><a href="http://embedgooglemaps.com">embed google maps</a></small></div><div><small><a href="https://www.amazon.com/Pawhut-Outdoor-Guinea-Rabbit-Habitat/dp/B008CB764C/">Guinea Pig Hutch</a></small></div><style>#gmap_canvas img{max-width:none!important;background:none!important}</style></div><script type='text/javascript'>function init_map(){var myOptions = {zoom:13,center:new google.maps.LatLng(40.39867346023537,49.85868099252934),mapTypeId: google.maps.MapTypeId.ROADMAP};map = new google.maps.Map(document.getElementById('gmap_canvas'), myOptions);marker = new google.maps.Marker({map: map,position: new google.maps.LatLng(40.39867346023537,49.85868099252934)});infowindow = new google.maps.InfoWindow({content:'<strong>Handwork</strong><br>Baku , Azerbaijan<br>'});google.maps.event.addListener(marker, 'click', function(){infowindow.open(map,marker);});infowindow.open(map,marker);}google.maps.event.addDomListener(window, 'load', init_map);</script>-->
        </div>
        <div class="contact">
            <div class="container">
                <div class="col-md-4 contact-left">
                    <h3>Ünvan</h3>
                    <p>Bakı Şəhəri Nəsimi rayonu Nizami Küçəsi 
                        <span>Bina 26 Mağaza 31</span></p>
                    <ul>
                        <li>Free Phone :+994702234411</li>
                        <li>Telephone :+994554961177</li>
                        <li>Fax :+994554961177</li>
                        <li><a href="mailto:info@example.com">info@example.com</a></li>
                    </ul>
                </div>
                <div class="col-md-8 contact-left">
                    <h3>Əlaqə</h3>
                    <form action="submitmessage" method="get">
                        <input type="text" placeholder="Adınız" name="name" onfocus="this.value = '';" onblur="if (this.value === '') {
                                    this.value = 'Name';
                                }" required="">
                                <input type="email"  placeholder="Emailiniz" name="email" onfocus="this.value = '';" onblur="if (this.value === '') {
                                            this.value = 'Email';
                                        }" required="">
                        <input type="text" placeholder="Mobil"  name="phone" onfocus="this.value = '';" onblur="if (this.value === '') {
                                            this.value = 'Telephone';
                                        }" required="">
                        <textarea type="text"   name="ymsg"  onfocus="this.value = '';" onblur="if (this.value === '') {
                                    this.value = 'Mesajınız...';
                                }" required="">Message...</textarea>
                        <input type="submit" value="Göndər" >
                    </form>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
        <!-- //contact -->
        <jsp:include page="fragment/footer.jsp" />
    </body>
</html>
