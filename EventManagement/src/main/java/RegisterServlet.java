import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String userType = request.getParameter("userType");

        // ✅ Check if passwords match
        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('Passwords do not match!'); window.location='signup.jsp';</script>");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;

        try {
            // ✅ Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");

            // ✅ Insert User Into Database
            String query = "INSERT INTO users (name, email, password, phone, address, userType) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query);

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, phone);
            pst.setString(5, address);
            pst.setString(6, userType);

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                // ✅ Create Session & Store User Info
                HttpSession session = request.getSession();
                session.setAttribute("user", name);
                session.setAttribute("email", email);
                session.setAttribute("userType", userType);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                // ✅ Redirect to Login Page
                response.sendRedirect("signin.jsp?message=Registration Successful! Please Login.");
            } else {
                out.println("<script>alert('Registration Failed! Try Again.'); window.location='signup.jsp';</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Database Error: " + e.getMessage() + "'); window.location='signup.jsp';</script>");
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
