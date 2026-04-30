package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import db.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // ✅ NULL SAFETY
        if (role == null || role.trim().isEmpty()) {
            role = "student"; // default
        }

        System.out.println("---- LOGIN DEBUG ----");
        System.out.println("Email: " + email);
        System.out.println("Role: " + role);

        try {
            Connection con = DBConnection.getConnection();

            String query;

            // ✅ ROLE-BASED QUERY
            if ("admin".equalsIgnoreCase(role)) {
              query = "SELECT * FROM admin WHERE email=? AND password=?";
            } else {
                query = "SELECT * FROM student WHERE email=? AND password=?";
            }

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            // ✅ LOGIN SUCCESS
            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("user", email);
                session.setAttribute("role", role);

                // 🔴 ADMIN LOGIN
                if ("admin".equalsIgnoreCase(role)) {

                    System.out.println("Admin login success");
                    System.out.println("Redirecting to admin Dashboard");
                    response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                    return;

                }
                // 🔵 STUDENT LOGIN
                else {

                    // IMPORTANT: store student_id
                    try {
                        session.setAttribute("student_id", rs.getInt("student_id"));
                    } catch (Exception e) {
                        System.out.println("student_id column not found");
                    }

                    System.out.println("Student login success");
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                    return;
                }

            }
            // ❌ LOGIN FAILED
            else {
                System.out.println("Login Failed");
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Something went wrong: " + e.getMessage());
        }
    }
}