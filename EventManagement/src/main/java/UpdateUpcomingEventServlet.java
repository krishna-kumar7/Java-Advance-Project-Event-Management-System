import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUpcomingEventServlet")
public class UpdateUpcomingEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String date = request.getParameter("date");
        String address = request.getParameter("address");
        String description = request.getParameter("description");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
            String sql = "UPDATE upcoming_events SET title=?, event_date=?, address=?, description=? WHERE id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, title);
            pst.setString(2, date);
            pst.setString(3, address);
            pst.setString(4, description);
            pst.setInt(5, id);

            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
                request.getSession().setAttribute("successMsg", "Event updated successfully.");
            } else {
                request.getSession().setAttribute("errorMsg", "Failed to update event.");
            }

            pst.close(); con.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Error: " + e.getMessage());
        }

        response.sendRedirect("organizer_dashboard.jsp");
    }
}
