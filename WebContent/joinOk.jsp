<%@ page import="com.schedule.pt.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="dto" class="com.schedule.pt.MemberDto"/>
<jsp:setProperty name="dto" property="*" />
<%

String kakaoId = dto.geteMail(); 
String name = dto.getName(); 
	MemberDao dao = MemberDao.getInstance();
	int ri = dao.insertMember(dto);
	if (ri == MemberDao.MEMBER_JOIN_SUCCESS) {
		session.setAttribute("email", dto.geteMail());
%>
	<script language="javascript">
		alert("회원가입을 축하합니다")
		document.location.href="index.jsp";
	</script>
<%	} else {  %>
	<script language="javascript">
	alert("<%= kakaoId %>");
	alert("<%= name %>");
		alert("회원가입에 실패하였습니다");
		document.location.href="index.jsp";
	</script>
<% 	} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>