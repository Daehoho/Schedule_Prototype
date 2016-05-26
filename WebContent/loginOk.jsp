<%@ page import = "com.schedule.pt.MemberDto" %>
<%@ page import = "com.schedule.pt.MemberDao" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
	
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	String appKey = request.getParameter("appkey");
	String kakaoId = request.getParameter("kakaoId");
	String kakaoName = request.getParameter("kakao");
	
	System.out.println("res:" + kakaoId);
	
	MemberDao dao = MemberDao.getInstance();
	if(kakaoId.equals("")) {
		int checkNum = dao.userCheck(email, pw);
		if(checkNum == -1) {
%>

		<script language="javascript">
			alert("아이디가 존재하지 않습니다.");
			history.go(-1);
		</script>
<%
		} else if (checkNum == 0) {
%>
		<script language="javascript">
			alert("비밀번호가 틀립니다.");
			history.go(-1);
		</script>
<%
		} else if (checkNum == 1) {
			MemberDto dto = dao.getMember(email);
		
			if(dto == null) {
%>
			<script language="javascript">
				alert("존재하지 않는 회원 입니다.");
				history.go(-1);
			</script>
<%
			} else {
				String name = dto.getName();
				session.setAttribute("email", email);
				session.setAttribute("name", name);
				session.setAttribute("ValidMem", "yes");
			}
		}
	} else {
		int checkNum = dao.confirmKakao(kakaoId);
		if (checkNum == 1) {
			MemberDto dto = dao.getMember(kakaoId);
			
			if(dto == null) {
				session.setAttribute("kakaoId", kakaoId);
				session.setAttribute("kakaoName", kakaoName);
				response.sendRedirect("join.jsp");
			} else {
				String name = dto.getName();
				session.setAttribute("kakaoId", kakaoId);
				session.setAttribute("name", name);
				session.setAttribute("ValidMem", "yes");
				session.setAttribute("appKey", appKey);
				response.sendRedirect("main.jsp");
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>

</body>
</html>