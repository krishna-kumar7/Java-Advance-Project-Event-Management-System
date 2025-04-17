import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        Connection con = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
            String sql = "DELETE FROM users WHERE id = ?";
            pst = con.prepareStatement(sql);
            pst.setInt(1, userId);
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                request.getSession().setAttribute("successMsg", "User deleted successfully!");
            } else {
                request.getSession().setAttribute("errorMsg", "User not found!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMsg", "Error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        response.sendRedirect("organizer_dashboard.jsp");
    }
}
