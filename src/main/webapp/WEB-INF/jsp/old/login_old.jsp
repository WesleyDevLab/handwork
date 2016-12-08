<%-- 
    Document   : logintemplate
    Created on : Jul 4, 2016, 4:54:51 PM
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
        <title>Login Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <script type="text/javascript" src="//code.jquery.com/jquery-1.12.0.min.js"></script> 
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-social/5.0.0/bootstrap-social.min.css"></script>-->
    </head>



    <body>
        <div id="fb-root"></div>
        <script>

            function checkLoginState() {
                FB.getLoginStatus(function (response) {
                    statusChangeCallback(response);
                });
            }



            (function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id))
                    return;
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=888848437872798";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
            window.fbAsyncInit = function () {
                FB.init({
                    appId: '888848437872798',
                    cookie: true, // enable cookies to allow the server to access 
                    // the session
                    status: true, // check login status
                    xfbml: true, // parse social plugins on this page
                    version: 'v2.5' // use graph api version 2.5
                });
                FB.getLoginStatus(function (response) {
                    statusChangeCallback(response);
                });
            };
            function statusChangeCallback(response) {
                if (response.status === 'connected') {
                    fbLogin();
                } else {
                    console.log('connected to fb' + response.id);
                }

            }

            var fbLogin = function () {
                FB.login(function (response) {
                    var token = response.authResponse.accessToken;
                    var uid = response.authResponse.userID;
                    if (response.authResponse) {
                        FB.api('/me', 'get', {access_token: token, fields: 'id,name,gender,email,first_name,last_name,picture'}, function (response) {

                            document.getElementById('HiddenForId').setAttribute('value', JSON.stringify(response));
                            console.log(document.getElementById('HiddenForId').value);
//                            ajaxtoController(response);
                        });
                    }
                },
                        {scope: 'public_profile'}
                );
            };
            function ajaxtoController(response) {
//                var start = $(document).ready();
                console.log('start . .. .  . ' + document.getElementById('HiddenForId').value);
                response = JSON.parse(document.getElementById('HiddenForId').value);
                var user = {};
                user["username"] = response.email;
                user["firstname"] = response.first_name;
                user["lastname"] = response.last_name;
                user["password"] = response.id;
                user["note"] = response.picture.data.url;
                //ajax request to server from jsp
                $.ajax({
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    type: 'POST',
                    url: "${pageContext.request.contextPath}/authUser?${_csrf.parameterName}=${_csrf.token}",
                                data: JSON.stringify(user),
                                complete: function () {
                                    window.location.replace('admin');
                                },
                                success: function (data) {
                                    console.log("SUCCESS: ", data);
                                },
                                error: function (callback) {
                                    console.log(callback);
                                },
                                done: function (e) {
                                    console.log("DONE");
                                }
                            });
                        }
        </script>




        <spring:url value="/register" scope="request" var="registerUrl"/>
        
        <div class="container">
            <div id="loginbox" style="margin-top:15%; "  class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
                <div class="panel panel-primary" >
                    <div class="panel-heading">
                        <div class="panel-title">Sign In</div>
                        <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot password?</a></div>
                    </div>     

                    <div style="padding-top:30px;" class="panel-body" >

                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                        <spring:url var="loginUrl" value="/login" />
                        <form id="loginform" action="${loginUrl}" method="post" class="form-horizontal" role="form">

                            <c:if test="${param.error != null}">
                                <div class="alert alert-danger">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <p>Invalid username and password.</p>
                                </div>
                            </c:if>
                            <c:if test="${param.logout != null}">
                                <div class="alert alert-success">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <p>You have been logged out successfully.</p>
                                </div>
                            </c:if>

                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input id="username" type="text" class="form-control" name="ssoId" value="" placeholder="username or email">                                        
                            </div>

                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <input id="password" type="password" class="form-control" name="password" placeholder="password">
                            </div>



                            <div class="input-group">
                                <div class="checkbox">
                                    <label>
                                        <input id="login-remember" type="checkbox" name="remember-me" value="1"> Remember me
                                    </label>
                                </div>
                            </div>

                            <input type="hidden" name="${_csrf.parameterName}" 	value="${_csrf.token}" />

                            <div style="margin-top:10px" class="form-group">
                                <!-- Button -->

                                <div class="col-sm-12 controls">
                                    <input id="btn-login" type="submit" value="Login" class="btn btn-primary">   
                                    <!--                                    <div class="fb-login-button" style="margin-left: 30px;" data-max-rows="1" data-size="large" data-show-faces="false"
                                                                            id="fbloginbtn" name="fbloginbtn" data-auto-logout-link="true"></div>-->
                                    <fb:login-button scope="public_profile,email" onlogin="checkLoginState();ajaxtoController();" data-max-rows="1" data-size="large" data-show-faces="false">
                                    </fb:login-button>
                                </div>
                            </div>
                            <input id="HiddenForId" type="hidden" value="" />
                            
                            
                            <div class="form-group">
                                <div class="col-md-12 control">
                                    <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
                                        Don't have an account! 
                                        <a href="#" onClick="$('#loginbox').hide();
                                                $('#signupbox').show()">
                                            Sign Up Here
                                        </a>
                                    </div>
                                </div>
                            </div>  
                        </form>     



                    </div>                     
                </div>  
            </div>

            <jsp:include page="register.jsp"/>
            <!--end container-->
        </div> 
    </div>


</body>
</html>