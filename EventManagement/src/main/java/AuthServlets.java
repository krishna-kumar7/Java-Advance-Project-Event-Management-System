import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/AuthServlet")
public class AuthServlets extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleLogout(request, response);
    }

    // ✅ User Registration
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String userType = request.getParameter("userType");

        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('Passwords do not match!'); window.location='signup.jsp';</script>");
            return;
        }

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String query = "INSERT INTO users (name, email, password, phone, address, userType) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setString(3, password);
                pst.setString(4, phone);
                pst.setString(5, address);
                pst.setString(6, userType);

                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    response.sendRedirect("signin.jsp?message=Registration Successful! Please Login.");
                } else {
                    out.println("<script>alert('Registration Failed! Try Again.'); window.location='signup.jsp';</script>");
                }
            }
        } catch (Exception e) {
            out.println("<script>alert('Database Error: " + e.getMessage() + "'); window.location='signup.jsp';</script>");
        }
    }

    // ✅ User Login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setString(1, email);
                pst.setString(2, password);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", rs.getString("name"));
                        session.setAttribute("email", email);
                        session.setAttribute("userType", rs.getString("userType"));
                        session.setAttribute("phone", rs.getString("phone"));
                        session.setAttribute("address", rs.getString("address"));

                        response.sendRedirect("client_profile.jsp");
                    } else {
                        out.println("<script>alert('Invalid Email or Password!'); window.location='signin.jsp';</script>");
                    }
                }
            }
        } catch (Exception e) {
            out.println("<script>alert('Database Error: " + e.getMessage() + "'); window.location='signin.jsp';</script>");
        }
    }

    // ✅ User Logout
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }
}
