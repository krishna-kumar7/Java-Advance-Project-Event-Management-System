import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // ✅ Get user input
        String name = request.getParameter("name");
        String email = request.getParameter("email"); // Email ko update nahi karenge
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("signin.jsp"); // Session expire to login page
            return;
        }

        String loggedInEmail = (String) session.getAttribute("email"); // Session se email

        Connection con = null;
        PreparedStatement pst = null;

        try {
            // ✅ Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");

            // ✅ Update query
            String query = "UPDATE users SET name=?, phone=?, address=? WHERE email=?";
            pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, phone);
            pst.setString(3, address);
            pst.setString(4, loggedInEmail);

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                // ✅ Update Session Variables
                session.setAttribute("user", name);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                response.sendRedirect("client_profile.jsp?message=Profile Updated Successfully");
            } else {
                response.sendRedirect("edit_profile.jsp?error=Update Failed! Try Again.");
            }
        } catch (Exception e) {
            response.sendRedirect("edit_profile.jsp?error=Database Error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
