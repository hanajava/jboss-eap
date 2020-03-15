<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
    // 데이터베이스 연결관련 변수 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 데이터베이스 연결관련정보를 문자열로 선언
    String jdbc_driver = "com.mysql.jdbc.Driver";
    String jdbc_url = "jdbc:mysql://localhost:13306/mysql?serverTimezone=UTC";
    out.println("jdbc_driver : "+jdbc_driver+"<br/>");
    out.println("jdbc_url : "+jdbc_url+"<br/>");
    System.out.println("jdbc_driver : "+jdbc_driver);
    System.out.println("jdbc_url : "+jdbc_url);

    try {
        // JDBC 드라이버 로드
        Class.forName(jdbc_driver);

        // 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
        conn = DriverManager.getConnection(jdbc_url,"pinpoint","pinpoint1!");

        // Connection 클래스의 인스턴스로 부터 SQL  문 작성을 위한 Statement 준비
        pstmt = conn.prepareStatement("select host, user, password from mysql.user");
        rs = pstmt.executeQuery();
        while(rs.next()) {
        out.println(rs.getString("host")+" : "+ rs.getString("user")+"<br/>");
        System.out.println(rs.getString("host")+" : "+ rs.getString("user"));
        }
        rs.close();
        pstmt.close();
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if(conn != null) {
                conn.close(); // 필수 사항
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
