<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
    
    String username = (String) userSession.getAttribute("user");
    List<Map<String, String>> myEvents = new ArrayList<>();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
        
        // Get events registered by this user
        String query = "SELECT e.* FROM events e " +
                      "JOIN event_registrations r ON e.id = r.event_id " +
                      "WHERE r.username = ? ORDER BY e.event_date DESC";
        
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, String> event = new HashMap<>();
            event.put("id", rs.getString("id"));
            event.put("event_name", rs.getString("event_name"));
            event.put("event_desc", rs.getString("event_desc"));
            event.put("event_date", rs.getString("event_date"));
            event.put("location", rs.getString("location"));
            event.put("image_path", rs.getString("image_path"));
            myEvents.add(event);
        }
        
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Events | Aayojan</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --dark-bg: #212529;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background-color: #f5f7fb;
        }
        
        .navbar {
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }
        
        .event-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
            height: 100%;
        }
        
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .event-card-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        
        .event-card-body {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            height: calc(100% - 200px);
        }
        
        .event-date {
            display: flex;
            align-items: center;
            gap: 6px;
            color: var(--primary-color);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        
        .event-location {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .section-title {
            font-weight: 700;
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 0.75rem;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            border-radius: 2px;
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 0;
        }
        
        .empty-state-icon {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="bi bi-calendar-event"></i>
            <span>Aayojan</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">
                        <i class="bi bi-house-door me-1"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="events.jsp">
                        <i class="bi bi-calendar3 me-1"></i> Events
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="my_events.jsp">
                        <i class="bi bi-ticket-perforated me-1"></i> My Events
                    </a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle d-flex align-items-center" type="button" 
                            id="profileDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i>
                        <span><%= username %></span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="client_profile.jsp">
                            <i class="bi bi-person me-2"></i> Profile
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="logout.jsp">
                            <i class="bi bi-box-arrow-right me-2"></i> Logout
                        </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Alerts -->
<%
    if (successMsg != null) {
%>
    <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <%= successMsg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        session.removeAttribute("successMsg");
    }
    if (errorMsg != null) {
%>
    <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        <%= errorMsg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        session.removeAttribute("errorMsg");
    }
%>

<!-- Main Content -->
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="section-title">My Registered Events</h1>
        <a href="events.jsp" class="btn btn-outline-primary">
            <i class="bi bi-plus-circle me-1"></i> Register for More Events
        </a>
    </div>
    
    <% if (myEvents.isEmpty()) { %>
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="bi bi-calendar-x"></i>
            </div>
            <h3>No Events Registered Yet</h3>
            <p class="text-muted">You haven't registered for any events yet. Browse our events and register to see them here.</p>
            <a href="events.jsp" class="btn btn-primary mt-3">
                <i class="bi bi-calendar3 me-1"></i> Browse Events
            </a>
        </div>
    <% } else { %>
        <div class="row">
            <% for (Map<String, String> event : myEvents) { %>
                <div class="col-lg-4 col-md-6">
                    <div class="event-card">
                        <img src="<%= request.getContextPath() + "/" + event.get("image_path") %>"
                             class="event-card-img" alt="<%= event.get("event_name") %>">
                        <div class="event-card-body">
                            <div class="event-date">
                                <i class="bi bi-calendar-event"></i>
                                <%= event.get("event_date") %>
                            </div>
                            <h5 class="mb-2"><%= event.get("event_name") %></h5>
                            <p class="text-muted mb-3 flex-grow-1">
                                <%= event.get("event_desc").length() > 100 ? 
                                    event.get("event_desc").substring(0, 100) + "..." : event.get("event_desc") %>
                            </p>
                            <div class="event-location mb-3">
                                <i class="bi bi-geo-alt"></i>
                                <%= event.get("location") %>
                            </div>
                            <div class="d-flex gap-2">
                                <a href="event_details.jsp?id=<%= event.get("id") %>" class="btn btn-outline-primary flex-grow-1">
                                    <i class="bi bi-eye me-1"></i> View Details
                                </a>
                                <form action="CancelRegistrationServlet" method="post" class="flex-grow-1">
                                    <input type="hidden" name="eventId" value="<%= event.get("id") %>">
                                    <button type="submit" class="btn btn-outline-danger w-100" 
                                            onclick="return confirm('Are you sure you want to cancel your registration for this event?');">
                                        <i class="bi bi-x-circle me-1"></i> Cancel
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    <div class="container">
        <p class="mb-0">&copy; 2025 Aayojan Event Management. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>