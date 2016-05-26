<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%! String appKey = "53903c029f7510f8fac072db4f592cf9"; %>
<% if(session.getAttribute("ValidMem") != null) {%>
	<jsp:forward page="main.jsp"></jsp:forward>
<% } %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<form id="form1" action="loginOk.jsp" method="post">
	<fieldset>
		<legend> Login Prototype</legend>
		
		<input type="email" name="email" placeholder="Email">
		<input type="password" name="password" placeholder="Password">
		<input type="hidden" name="appkey" value="<%= appKey %>">
		<input type="hidden" name="kakaoId" id="kakaoId" value="1">
		<input type="hidden" name="kakaoName" id="kakaoName" value="">
		
		<label for="remember">
			<input name="remember" type="checkbox">기억하기
		</label>
		
		<button type="submit">Login</button>
		<button type="submit">Join</button>
		<a id="kakao-login-btn"></a>
		<a href="http://alpha-developers.kakao.com/logout"></a>
		<script type='text/javascript'>
  			//<![CDATA[
    			// 사용할 앱의 JavaScript 키를 설정해 주세요.
    			Kakao.init('<%= appKey %>');
    			// 카카오 로그인 버튼을 생성합니다.
    		 Kakao.Auth.createLoginButton({
      			container: '#kakao-login-btn',
      			success: function(authObj) {
      				alert(JSON.stringify(authObj));
      				Kakao.API.request({
      				    url: '/v1/user/me',
      				    success: function(res) {
      			    	  alert(JSON.stringify(res));
      						document.getElementById("kakaoId").value = res.id;
      						document.getElementById("kakaoName").value = res.properties.nickname;
      						document.getElementById("form1").submit();
      			    	},
      			    	fail: function(error) {
      			    	  alert(JSON.stringify(error));
      			    	}
      			  	});
      			},
      			fail: function(err) {
        			alert(JSON.stringify(err));
      			}
    		});
  			//]]>
		</script>
	</fieldset>
</form>
</body>
</html>