<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    HttpSession userSession = request.getSession(false);
    boolean isLoggedIn = (userSession != null && userSession.getAttribute("user") != null);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Event Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="style.css">
    <style>
        #profileCard {
            display: none;
            position: absolute;
            top: 50px;
            right: 20px;
            width: 250px;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 15px;
            z-index: 1000;
        }
        .carousel-item img {
            max-height: 500px;
            object-fit: cover;
        }
        .card {
            transition: transform 0.3s ease-in-out;
        }
        .card:hover {
            transform: scale(1.05);
        }
    </style>
    <script>
        function toggleProfile() {
            var profileCard = document.getElementById("profileCard");
            profileCard.style.display = (profileCard.style.display === "none" || profileCard.style.display === "") ? "block" : "none";
        }
        document.addEventListener("click", function(event) {
            var profileCard = document.getElementById("profileCard");
            var profileButton = document.getElementById("profileButton");
            if (profileCard && profileButton && !profileCard.contains(event.target) && !profileButton.contains(event.target)) {
                profileCard.style.display = "none";
            }
        });
    </script>
</head>
<body>

<%
    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");
    if (successMsg != null) {
%>
    <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
        <%= successMsg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        session.removeAttribute("successMsg");
    }
    if (errorMsg != null) {
%>
    <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
        <%= errorMsg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        session.removeAttribute("errorMsg");
    }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Aayojan</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="events.jsp">Events</a></li>
                <li class="nav-item"><a class="nav-link" href="teams.jsp">Teams</a></li>
                <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="gallary.jsp">Gallery</a></li>
            </ul>
            <div>
                <% if (!isLoggedIn) { %>
                    <a href="signin.jsp" class="btn btn-outline-light me-2">Sign In</a>
                    <a href="signup.jsp" class="btn btn-light">Sign Up</a>
                <% } else { %>
                    <button id="profileButton" onclick="toggleProfile()" class="btn btn-light">Profile</button>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<% if (isLoggedIn) { %>
<div id="profileCard">
    <p>Welcome, <%= userSession.getAttribute("user") %></p>
    <a href="client_profile.jsp" class="btn btn-primary btn-sm d-block mb-2">View Profile</a>
    <a href="logout.jsp" class="btn btn-danger btn-sm d-block">Logout</a>
</div>
<% } %>

<!-- Carousel -->
<div id="carouselExampleIndicators" class="carousel slide mt-2" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="assets/images/banner1.jpg" class="d-block w-100" alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="assets/images/banner4.jpg" class="d-block w-100" alt="Banner 2">
        </div>
        <div class="carousel-item">
            <img src="assets/images/banner5.jpg" class="d-block w-100" alt="Banner 3">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
    </button>
</div>

<!-- Upcoming Events -->
<div class="container mt-5">
    <h2 class="text-center mb-4">Upcoming Events</h2>
    <div class="row">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM upcoming_events ORDER BY event_date DESC");

            while (rs.next()) {
    %>
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <img src="<%= request.getContextPath() + "/" + rs.getString("image_path") %>"
                     class="card-img-top" alt="Event Image"
                     style="height: 250px; object-fit: cover;">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= rs.getString("title") %></h5>
                    <p class="card-text flex-grow-1"><%= rs.getString("description") %></p>
                    <p class="text-muted">Date: <%= rs.getString("event_date") %></p>
                    <p class="text-muted">Location: <%= rs.getString("address") %></p>

                    <% if (isLoggedIn) { %>
                        <form action="RegisterUpcomingEventServlet" method="post">
                            <input type="hidden" name="eventId" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-primary btn-sm mt-2">Register</button>
                        </form>
                    <% } else { %>
                        <a href="signin.jsp" class="btn btn-outline-primary btn-sm mt-2">Login to Register</a>
                    <% } %>
                </div>
            </div>
        </div>
    <%
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error loading upcoming events: " + e.getMessage() + "</p>");
        }
    %>
    </div>
</div>

<!-- Contact Us -->
<div class="container mt-5">
    <h2 class="text-center">Contact Us</h2>
    <form class="mt-4">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" placeholder="Enter your name">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" placeholder="Enter your email">
        </div>
        <div class="mb-3">
            <label for="message" class="form-label">Message</label>
            <textarea class="form-control" id="message" rows="4" placeholder="Write your message"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4 mt-5">
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
