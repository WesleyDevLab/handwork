<%-- 
    Document   : index
    Created on : Sep 19, 2016, 3:00:56 PM
    Author     : Rashad Javadov
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="windows-1251"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
        <title>Opal.az - Admin</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script type="text/javascript" src="//code.jquery.com/jquery-1.12.0.min.js"></script> 
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    </head>
    <body>


        <sec:authorize access="isAuthenticated()">
            <sec:authentication var="firstname" scope="request" property="principal.users.firstname"/> 
            <sec:authentication var="lastname" scope="request" property="principal.users.lastname"/> 

            <sec:authentication var="imgUrlProfile" scope="request" property="principal.users.note"/>

            <img style="height: 40px;border: 2px solid;border-radius: 25px;" 
                 onerror="http://www.brentfordfc.co.uk/images/common/bg_player_profile_default_big.png"  src="${imgUrlProfile}"/>
            <br/>
            <spring:message code="welcome"/> ,  ${firstname} ${lastname}
        </sec:authorize>
        <br/>
        <a href="<c:url value="/logout" />">Log Out</a> 
        <div class="fb-login-button" style="margin-left: 30px;" data-max-rows="1" data-size="large" data-show-faces="false"
             onlogin="checkLoginState();" data-auto-logout-link="true"></div>


        <sec:authorize access="isRememberMe()">
            <h2># This user is login by "Remember Me Cookies".</h2>
        </sec:authorize>

        <sec:authorize access="isFullyAuthenticated()">
            <h2># This user is login by username / password.</h2>
        </sec:authorize>
    </body>
</html>
