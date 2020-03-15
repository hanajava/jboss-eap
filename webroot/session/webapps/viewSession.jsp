<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="net.hanajava.test.jboss.UserInfo"%>
<%
UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
%>

<html>
<body>
<h2>세션확인</h2>

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
		<td>generateServerPeerID</td>
		<td><%=userInfo.getServerPeerID()%></td>
	</tr>
</table>
</body>
</html>