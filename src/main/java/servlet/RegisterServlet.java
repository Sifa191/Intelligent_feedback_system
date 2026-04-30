package servlet;

import db.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps;

            if(role.equals("admin")) {

                String query = "INSERT INTO admin(email,password) VALUES(?,?)";
                ps = con.prepareStatement(query);

                ps.setString(1, email);
                ps.setString(2, password);

            } else {

                String course = request.getParameter("course");

                String query = "INSERT INTO student(name,email,course,password) VALUES(?,?,?,?)";
                ps = con.prepareStatement(query);

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, course);
                ps.setString(4, password);
            }

            ps.executeUpdate();

            response.sendRedirect("login.jsp?success=1");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}