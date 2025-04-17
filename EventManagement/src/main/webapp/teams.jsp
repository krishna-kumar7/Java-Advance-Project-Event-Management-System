<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Teams - Event Management System</title>
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
                    <li class="nav-item"><a class="nav-link active" href="teams.jsp">Teams</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                </ul>
                <div>
                   
                </div>
            </div>
        </div>
    </nav>
    
    <!-- Teams Section -->
    <div class="container mt-4">
        <h1 class="text-center">Our Teams</h1>
        <div class="row mt-4">
            <!-- Team 1 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/team1.png" class="card-img-top" alt="Team 1" class="img-fluid w-50 h-50">
                    <div class="card-body">
                        <h5 class="card-title">Krishna Kumar</h5>
                        <p class="card-text">Team Alpha is dedicated to organizing seamless and memorable events for all participants. Their expertise and teamwork ensure that every event is a success.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Team 2 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/team2.jpg" class="card-img-top" alt="Team 2" class="img-fluid w-50 h-50">
                    <div class="card-body">
                        <h5 class="card-title">Ashutosh Kumar</h5>
                        <p class="card-text">Team Beta specializes in creative event planning, bringing innovative ideas to life. They are passionate about making every event unique and impactful.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Team 3 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/team3.jpg" class="card-img-top" alt="Team 3" class="img-fluid w-50 h-50">
                    <div class="card-body">
                        <h5 class="card-title">Pappu Kumar</h5>
                        <p class="card-text">Team Gamma is known for its attention to detail and efficient execution. They ensure every aspect of the event runs smoothly, leaving attendees with a lasting impression.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <!-- Team 4 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/team1.png" class="card-img-top" alt="Team 4">
                    <div class="card-body">
                        <h5 class="card-title">Krishna Kumar</h5>
                        <p class="card-text">Team Delta is a group of dynamic event coordinators who specialize in large-scale events. They have the skills to manage complex events with ease and professionalism.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Team 5 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/team2.jpg" class="card-img-top" alt="Team 5">
                    <div class="card-body">
                        <h5 class="card-title">Ashutosh Kumar</h5>
                        <p class="card-text">Team Epsilon is a creative and energetic group, known for their out-of-the-box thinking and innovative event concepts. They focus on creating unforgettable experiences for all guests.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>
            
            <!-- Team 6 -->
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/images/team3.jpg" class="card-img-top" alt="Team 6">
                    <div class="card-body">
                        <h5 class="card-title">Pappu Kumar</h5>
                        <p class="card-text">Team Zeta is a highly skilled group that excels in technical and logistical aspects of event management. Their expertise ensures that every event runs smoothly from start to finish.</p>
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
