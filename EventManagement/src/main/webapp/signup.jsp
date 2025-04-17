<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - Event Management System</title>
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
    
    <!-- Sign Up Form Section -->
    <div class="container mt-5">
        <h1 class="text-center">Sign Up</h1>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form action="RegisterServlet" method="POST">
                    <div class="mb-3">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="text" class="form-control" id="phone" name="phone" required>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                    </div>
                    <div class="mb-3">
                        <label for="userType" class="form-label">Select User Type</label>
                        <select class="form-select" id="userType" name="userType" required>
                            <option value="attendee">Attendee</option>
                            <option value="organizer">Organizer</option>
                            
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Sign Up</button>
                </form>
                <p class="text-center mt-3">Already have an account? <a href="signin.jsp">Sign In</a></p>
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
