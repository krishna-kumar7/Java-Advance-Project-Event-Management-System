import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddUpcomingEventServlet")
@MultipartConfig
public class AddUpcomingEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String date = request.getParameter("date");
        String address = request.getParameter("address");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("uploads") + File.separator + fileName;

        try (InputStream fileContent = filePart.getInputStream()) {
            File uploadsDir = new File(getServletContext().getRealPath("uploads"));
            if (!uploadsDir.exists()) uploadsDir.mkdir();

            Files.copy(fileContent, new File(uploadPath).toPath(), StandardCopyOption.REPLACE_EXISTING);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
            String query = "INSERT INTO upcoming_events (title, event_date, address, description, image_path) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, title);
            pst.setString(2, date);
            pst.setString(3, address);
            pst.setString(4, description);
            pst.setString(5, "uploads/" + fileName);

            int row = pst.executeUpdate();

            if (row > 0) {
                request.getSession().setAttribute("successMsg", "Upcoming Event added successfully!");
            } else {
                request.getSession().setAttribute("errorMsg", "Failed to add Upcoming Event.");
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
