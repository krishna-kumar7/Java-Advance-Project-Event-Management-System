import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUpcomingEventServlet")
public class DeleteUpcomingEventServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
            String sql = "DELETE FROM upcoming_events WHERE id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, eventId);

            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                request.getSession().setAttribute("successMsg", "Event deleted successfully.");
            } else {
                request.getSession().setAttribute("errorMsg", "Event not found or couldn't be deleted.");
            }

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Error: " + e.getMessage());
        }

        response.sendRedirect("organizer_dashboard.jsp");
    }
}
