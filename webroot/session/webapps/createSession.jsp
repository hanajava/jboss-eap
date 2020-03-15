<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="net.hanajava.test.jboss.UserInfo"%>
<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String empno = request.getParameter("empno");

UserInfo userInfo = new UserInfo();
userInfo.setId(id);
userInfo.setName(name);
userInfo.setEmpno(empno);
userInfo.setServerPeerID(System.getProperty("jboss.node.name"));

session.setAttribute("userInfo", userInfo);
%>

<html>
<body>
<h2>세션생성</h2>

<table>
	<tr>
		<td>ServerPeerID</td>
		<td><%=System.getProperty("jboss.node.name")%></td>
	</tr>
	<tr>
		<td>id</td>
		<td><%=userInfo.getId()%></td>
	</tr>
	<tr>
		<td>name</td>
		<td><%=userInfo.getName()%></td>
	</tr>
	<tr>
		<td>empno</td>
		<td><%=userInfo.getEmpno()%></td>
	</tr>
	<tr>
		<td>serverPeerID</td>
		<td><%=userInfo.getServerPeerID()%></td>
	</tr>
</table>
<a href="viewSession.jsp">세션보기</a>
</body>
</html>