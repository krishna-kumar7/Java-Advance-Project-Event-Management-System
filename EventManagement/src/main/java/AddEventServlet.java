import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddEventServlet")
@MultipartConfig
public class AddEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String eventName = request.getParameter("eventName");
        String eventDesc = request.getParameter("eventDesc");
        String eventDate = request.getParameter("eventDate");
        String location = request.getParameter("location");
        Part imagePart = request.getPart("image");

        String imageFileName = imagePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + "event_images";

        // Create folder if not exists
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        try (InputStream inputStream = imagePart.getInputStream()) {
            Files.copy(inputStream, new File(uploadPath + File.separator + imageFileName).toPath());
        }

        String createdAt = LocalDate.now().toString();
        String imagePath = "event_images/" + imageFileName;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");

            String sql = "INSERT INTO events (event_name, event_desc, event_date, location, image, created_at) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setString(1, eventName);
            pst.setString(2, eventDesc);
            pst.setString(3, eventDate);
            pst.setString(4, location);
            pst.setString(5, imagePath);
            pst.setString(6, createdAt);

            int row = pst.executeUpdate();

            if (row > 0) {
                session.setAttribute("successMsg", "Event added successfully!");
            } else {
                session.setAttribute("errorMsg", "Failed to add event. Try again!");
            }

            con.close();
            response.sendRedirect("organizer_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Server error: " + e.getMessage());
            response.sendRedirect("admin-dashboard.jsp");
        }
    }
}
