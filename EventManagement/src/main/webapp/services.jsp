<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Services - Event Management System</title>
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
                    <li class="nav-item"><a class="nav-link active" href="services.jsp">Services</a></li>
                </ul>
                
            </div>
        </div>
    </nav>
    
    <!-- Services Section -->
    <div class="container mt-4">
        <h1 class="text-center">Our Services</h1>
        <div class="row mt-4">
            <!-- Service 1 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/service1.jpg" class="card-img-top" alt="Service 1">
                    <div class="card-body">
                        <h5 class="card-title">Event Planning</h5>
                        <p class="card-text">We offer expert event planning services to ensure your event runs smoothly from start to finish. From logistics to scheduling, we handle it all.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Service 2 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/service2.jpg" class="card-img-top" alt="Service 2">
                    <div class="card-body">
                        <h5 class="card-title">Venue Management</h5>
                        <p class="card-text">Our venue management service ensures your event space is optimized for your needs. We assist with venue selection, setup, and coordination to create the ideal environment.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Service 3 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/service3.webp" class="card-img-top" alt="Service 3">
                    <div class="card-body">
                        <h5 class="card-title">Catering Services</h5>
                        <p class="card-text">We provide catering services to satisfy your guests' tastes with delicious and diverse menu options. Whether it’s a corporate event or a wedding, we have you covered.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <!-- Service 4 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/service4.jpg" class="card-img-top" alt="Service 4">
                    <div class="card-body">
                        <h5 class="card-title">Entertainment</h5>
                        <p class="card-text">We offer various entertainment options, including live music, DJs, and interactive sessions, ensuring your event is filled with fun and excitement.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Service 5 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/service5.jpg" class="card-img-top" alt="Service 5">
                    <div class="card-body">
                        <h5 class="card-title">Event Registration</h5>
                        <p class="card-text">Our online event registration system allows attendees to sign up effortlessly, and we provide real-time tracking and management of registrations.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Service 6 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/service6.jpg" class="card-img-top" alt="Service 6">
                    <div class="card-body">
                        <h5 class="card-title">Event Marketing</h5>
                        <p class="card-text">Our team helps with event promotion, ensuring your event reaches the right audience through various marketing channels and strategies.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
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
