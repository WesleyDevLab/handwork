<%-- 
    Document   : login2
    Created on : Oct 28, 2016, 9:00:35 PM
    Author     : Rashad Javadov
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Opal.az - Qeydiyyat</title>
        <link rel="shortcut icon"  href="https://p.w3layouts.com/demos/pendent_store/web/images/cart1.png" type="image/png">
    </head>
    <body>
        <jsp:include page="fragment/header.jsp" />
        <jsp:include page="fragment/menu.jsp" />




        <div class="reg-form">
            <div class="container">
                <div class="reg">
                    <h3>Register Now</h3>
                    <p>Welcome, please enter the following details to continue.</p>
                    <p>If you have previously registered with us, <a href="#">click here</a></p>





                    <spring:url var="registerUrl" value="/register" />
                    <form:form id="signupform"   method="post" modelAttribute="userReg" action="${registerUrl}">

                        <!--                        <div id="signupalert" style="display:none" class="alert alert-danger">
                                                    <p>Error:</p>
                                                    <span></span>
                                                </div>-->

                        <spring:bind path="email">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="email" class="text-info">Email</label> 
                                <form:input path="email" type="text"   placeholder="Email Address" />
                                <form:errors path="email" class="control-label" /> 
                            </div>
                        </spring:bind>



                        <spring:bind path="firstName">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="firstName" class="text-info">Adınız</label> 
                                <form:input path="firstName" type="text"   placeholder="Adınız" />
                                <form:errors path="firstName" class="control-label" /> 
                            </div>
                        </spring:bind>

                        <spring:bind path="lastName">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="lastName" class="text-info">Soyadınız</label> 
                                <form:input path="lastName" type="text"  placeholder="Soyadınız" />
                                <form:errors path="lastName" class="control-label" /> 
                            </div>
                        </spring:bind>

                        <spring:bind path="passwd">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="passwd" class="text-info">Şifrə</label> 
                                <form:input path="passwd" type="password"  class="form-control "  placeholder="Şifrə" />
                                <form:errors path="passwd" class="control-label" /> 
                            </div>
                        </spring:bind>

                        <spring:bind path="repasswd">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="repasswd" class="text-info">Təkrar Şifrə</label> 
                                <form:input path="repasswd" type="password"  placeholder="Təkrar Şifrə" />
                                <form:errors path="repasswd" class="control-label" /> 
                            </div>
                        </spring:bind>

                        <spring:bind path="gender">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="gender" class="text-info">Cins</label> 
                                <form:select path="gender"  class="form-control " >
                                    <form:option value="">Seçim et</form:option>
                                    <form:option value="1">Kişi</form:option>
                                    <form:option value="2">Qadın</form:option>
                                </form:select>
                                <form:errors path="gender" class="control-label" /> 
                            </div>
                        </spring:bind>     


                        <spring:bind path="phoneno">
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <label for="phoneno" class="text-info">Mobil</label> 
                                <form:input path="phoneno" type="text" placeholder="Mobil" />
                                <form:errors path="phoneno" class="control-label" /> 
                            </div>
                        </spring:bind>

                        <input type="submit"  value="Register Now">
                    </form:form>
                    <form style="margin-top: 2px !important;" action="connect/facebook" method="POST">
                        <input type="hidden" name="scope" value="user_posts" /> 
                        <input type="submit" style="background:  #0075b0" class="btn btn-primary" value="Sign Up  with Facebook">
                    </form>
                    <p class="click">By clicking this button, you are agree to my  <a href="privacyPolicy">Policy Terms and Conditions.</a></p> 



                </div>
            </div>
        </div> 




        <jsp:include page="fragment/footer.jsp" />
    </body>
</html>
