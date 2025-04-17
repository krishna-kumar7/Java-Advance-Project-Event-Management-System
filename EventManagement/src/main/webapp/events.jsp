<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
        stmt = conn.prepareStatement("SELECT * FROM events");
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Events - Event Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%
    HttpSession session2 = request.getSession(false);
    if (session2 != null) {
        String successMsg = (String) session2.getAttribute("successMsg");
        String errorMsg = (String) session2.getAttribute("errorMsg");

        if (successMsg != null) {
%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= successMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
<%
            session2.removeAttribute("successMsg");
        }

        if (errorMsg != null) {
%>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= errorMsg %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
<%
            session2.removeAttribute("errorMsg");
        }
    }
%>

    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Aayojan</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                    <li class="nav-item"><a class="nav-link active" href="events.jsp">Events</a></li>
                    <li class="nav-item"><a class="nav-link" href="teams.jsp">Teams</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Events Section -->
    <div class="container mt-4">
        <h1 class="text-center">Our Events</h1>
        <div class="row mt-4">
            <%
                while (rs.next()) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <img src="<%= rs.getString("image") %>" class="card-img-top" alt="Event Image" style="height: 250px; object-fit: cover;">
                    <div class="card-body d-flex flex-column">
                        <h4 class="card-title fw-bold"><%= rs.getString("event_name") %></h4>
                        <p class="card-text flex-grow-1"><%= rs.getString("event_desc") %></p>
                        <p class="card-text"><strong>Date:</strong> <%= rs.getString("event_date") %></p>
                        <p class="card-text"><strong>Location:</strong> <%= rs.getString("location") %></p>
                        <a href="event_register.jsp?event_id=<%= rs.getInt("id") %>" class="btn btn-primary">Register</a>

                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Services</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Event Planning</a></li>
                        <li><a href="#" class="text-white">Catering</a></li>
                        <li><a href="#" class="text-white">Venue Booking</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Venues</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Conference Halls</a></li>
                        <li><a href="#" class="text-white">Outdoor Spaces</a></li>
                        <li><a href="#" class="text-white">Banquet Halls</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Follow Us</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Facebook</a></li>
                        <li><a href="#" class="text-white">Twitter</a></li>
                        <li><a href="#" class="text-white">Instagram</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <p class="mt-3">&copy; 2025 Event Management System. All rights reserved.</p>
    </footer>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
