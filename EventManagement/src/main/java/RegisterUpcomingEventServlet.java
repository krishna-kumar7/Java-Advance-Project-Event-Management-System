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

@WebServlet("/RegisterUpcomingEventServlet")
public class RegisterUpcomingEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("signin.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");

            // Optional: check if already registered
            PreparedStatement check = con.prepareStatement("SELECT * FROM upcoming_event_registrations WHERE email=? AND event_id=?");
            check.setString(1, email);
            check.setInt(2, eventId);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                session.setAttribute("errorMsg", "You have already registered for this event.");
            } else {
                PreparedStatement pst = con.prepareStatement("INSERT INTO upcoming_event_registrations (event_id, email) VALUES (?, ?)");
                pst.setInt(1, eventId);
                pst.setString(2, email);
                pst.executeUpdate();
                session.setAttribute("successMsg", "Successfully registered for the event!");
            }

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            session.setAttribute("errorMsg", "Something went wrong: " + e.getMessage());
            response.sendRedirect("index.jsp");
        }
    }
}
