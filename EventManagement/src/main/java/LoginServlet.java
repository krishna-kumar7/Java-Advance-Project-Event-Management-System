import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");

            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                String usertype = rs.getString("usertype");
                String name = rs.getString("name");

                HttpSession session = request.getSession();
                session.setAttribute("user", name);
                session.setAttribute("email", email);
                session.setAttribute("userType", usertype);
                session.setAttribute("phone", rs.getString("phone"));
                session.setAttribute("address", rs.getString("address"));

                // ✅ Show success alert just once
                session.setAttribute("successMsg", "Login successful!");

                if ("organizer".equalsIgnoreCase(usertype)) {
                    response.sendRedirect("organizer_dashboard.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }

            } else {
                request.getSession().setAttribute("errorMsg", "Invalid Email or Password!");
                response.sendRedirect("signin.jsp");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMsg", "Database Error: " + e.getMessage());
            response.sendRedirect("signin.jsp");

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (pst != null) pst.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
