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

@WebServlet("/EventRegisterServlet")
public class EventRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // ✅ Step 1: Check if user is logged in
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("signin.jsp?msg=Please+login+first");
            return;
        }

        // ✅ Step 2: Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String eventIdStr = request.getParameter("event_id");

        // Check if event_id is missing
        if (eventIdStr == null || eventIdStr.isEmpty()) {
            session.setAttribute("errorMsg", "Event ID is missing!");
            response.sendRedirect("events.jsp");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);

            // ✅ Step 3: Insert data into database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");

            String query = "INSERT INTO event_registrations (event_id, name, email, phone) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setInt(1, eventId);
            pst.setString(2, name);
            pst.setString(3, email);
            pst.setString(4, phone);

            int row = pst.executeUpdate();
            if (row > 0) {
                session.setAttribute("successMsg", "Successfully registered for the event!");
            } else {
                session.setAttribute("errorMsg", "Registration failed!");
            }

            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Error: " + e.getMessage());
        }

        // ✅ Step 4: Redirect back to events page with message
        response.sendRedirect("events.jsp");
    }
}
