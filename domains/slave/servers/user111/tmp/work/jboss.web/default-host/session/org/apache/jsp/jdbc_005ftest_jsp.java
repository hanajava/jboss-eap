package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class jdbc_005ftest_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=euc-kr");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;


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

    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
