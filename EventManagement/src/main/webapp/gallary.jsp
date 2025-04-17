<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Event Management</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-success bg-red">
        <div class="container-fluid">
            <a class="navbar-brand text-white" href="#">Aayojan</a>
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

    <!-- Gallery Section -->
    <section class="container my-5">
        <h2 class="text-center mb-4">Our Successful Events</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <img src="assets/images/service1.jpg" class="img-fluid rounded shadow" alt="Event 1">
            </div>
            <div class="col-md-4">
                <img src="assets/images/service1.jpg" class="img-fluid rounded shadow" alt="Event 2">
            </div>
            <div class="col-md-4">
                <img src="assets/images/service1.jpg" class="img-fluid rounded shadow" alt="Event 3">
            </div>
        </div>
        <div class="row g-4 mt-5">
            <div class="col-md-4">
                <img src="assets/images/service3.webp" class="img-fluid rounded shadow" alt="Event 1">
            </div>
            <div class="col-md-4">
                <img src="assets/images/service3.webp" class="img-fluid rounded shadow" alt="Event 2">
            </div>
            <div class="col-md-4">
                <img src="assets/images/service3.webp" class="img-fluid rounded shadow" alt="Event 3">
            </div>
        </div>
    </section>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
