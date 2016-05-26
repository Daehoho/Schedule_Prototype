<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<%
	String kakaoId = (String)session.getAttribute("kakaoId");
	String kakaoName = (String)session.getAttribute("kakaoName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="joinOk.jsp" method="post" name="reg_frm">
	<fieldset>
		<legend>Register</legend>
		
	<% if(session.getAttribute("kakaoJoin") != null) {%>
		<label for="name">name</label>
		<input id="name" type="text" name="name" placeholder="name" value="<%= kakaoName %>">
		
		<input id="email" type="hidden" name="eMail" value="<%=kakaoId%>">
		<input id="kakao" type="hidden" name="isKakao" value="1">
	<% } else {%>
		<label for="name">name</label>
		<input id="name" name="name" type="text" placeholder="name">
		
		<label for="email">Email</label>
		<input id="email" type="email" name="email" placeholder="Email">
		<input id="kakao" type="hidden" name="isKakao" value="0">
	<% } %>
		
		<label for="pw">PW</label>
		<input id="pw" name="pw" type="password" placeholder="Password">
		
		<label for="confirmPw">Confirm PW</label>
		<input id="confirmPw" name="pw_check" type="password" placeholder="Repeat Password">

		<button type="submit">Register</button>
		
	</fieldset>
</form>
</body>
</html>
