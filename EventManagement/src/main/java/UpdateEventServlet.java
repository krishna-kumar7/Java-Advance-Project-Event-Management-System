import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateEventServlet")
public class UpdateEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String name = request.getParameter("eventName");
        String desc = request.getParameter("eventDesc");
        String date = request.getParameter("eventDate");
        String location = request.getParameter("location");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
            String query = "UPDATE events SET event_name=?, event_desc=?, event_date=?, location=? WHERE id=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, desc);
            pst.setString(3, date);
            pst.setString(4, location);
            pst.setString(5, id);

            int rows = pst.executeUpdate();
            pst.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("organizer_dashboard.jsp?msg=updated");
            } else {
                response.getWriter().println("Update failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}
