<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign In - Event Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body>
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
                    <li class="nav-item"><a class="nav-link" href="events.jsp">Events</a></li>
                    <li class="nav-item"><a class="nav-link" href="teams.jsp">Teams</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Sign In Form Section -->
    <div class="container mt-5">
        <h1 class="text-center">Sign In</h1>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="LoginServlet" method="POST">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Sign In</button>
                </form>
                <p class="text-center mt-3">Don't have an account? <a href="signup.jsp">Sign Up</a></p>
               
            </div>
             <p class="text-center mt-4"><a href="organizer_dashboard.jsp">Organizer</a></p>
        </div>
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
