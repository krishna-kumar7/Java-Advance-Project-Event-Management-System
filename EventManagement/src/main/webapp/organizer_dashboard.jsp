<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionProfile = request.getSession(false);
    if (sessionProfile == null || sessionProfile.getAttribute("user") == null) {
        response.sendRedirect("signin.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventHub | Organizer Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-bg: #f8f9fa;
            --dark-bg: #212529;
            --success-color: #4bb543;
            --danger-color: #ff3333;
            --warning-color: #ffc107;
        }
        
        body {
            background-color: #f5f7fb;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }
        
        .navbar-brand {
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .navbar-brand i {
            color: var(--accent-color);
        }
        
        .dashboard-container {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .welcome-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(67, 97, 238, 0.15);
        }
        
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            background-color: white;
            margin-bottom: 1.5rem;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background-color: transparent;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-weight: 600;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .card-header i {
            font-size: 1.25rem;
            color: var(--primary-color);
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(76, 201, 240, 0.25);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }
        
        .btn-success {
            background-color: var(--success-color);
            border: none;
        }
        
        .btn-danger {
            background-color: var(--danger-color);
            border: none;
        }
        
        .btn-warning {
            background-color: var(--warning-color);
            border: none;
            color: #212529;
        }
        
        .list-group-item {
            border-radius: 8px !important;
            margin-bottom: 0.75rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease;
        }
        
        .list-group-item:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
        
        .event-date {
            font-size: 0.85rem;
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        
        .event-actions {
            display: flex;
            gap: 8px;
        }
        
        .action-btn {
            width: 80px;
        }
        
        .table {
            border-radius: 12px;
            overflow: hidden;
        }
        
        .table thead th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
            padding: 1rem;
        }
        
        .table tbody tr {
            transition: background-color 0.2s ease;
        }
        
        .table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
        }
        
        .badge {
            padding: 0.5rem 0.75rem;
            font-weight: 500;
            border-radius: 8px;
        }
        
        .section-title {
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--dark-bg);
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: var(--accent-color);
            border-radius: 3px;
        }
        
        .stats-card {
            text-align: center;
            padding: 1.5rem;
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .stats-label {
            font-size: 0.9rem;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .alert {
            border-radius: 8px;
            padding: 1rem 1.5rem;
        }
    </style>
</head>
<body>

<%-- Success & Error Alert --%>
<%
    String success = (String) session.getAttribute("successMsg");
    String error = (String) session.getAttribute("errorMsg");
    if (success != null) {
%>
    <div class="alert alert-success alert-dismissible fade show mt-3 mx-3" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>
        <%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        session.removeAttribute("successMsg");
    } else if (error != null) {
%>
    <div class="alert alert-danger alert-dismissible fade show mt-3 mx-3" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        session.removeAttribute("errorMsg");
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="#">
            <i class="bi bi-calendar-event"></i>
            <span>EventHub Dashboard</span>
        </a>
        <div class="d-flex align-items-center">
            <span class="text-light me-3 d-none d-md-block">
                <i class="bi bi-person-circle me-1"></i>
                <%= sessionProfile.getAttribute("user") %>
            </span>
            <a class="btn btn-outline-light" href="AdminLogoutServlet">
                <i class="bi bi-box-arrow-right me-1"></i>
                Logout
            </a>
        </div>
    </div>
</nav>

<div class="dashboard-container">
    <div class="welcome-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-2">Welcome, Organizer!</h2>
                <p class="mb-0">Manage your events and users from this dashboard</p>
            </div>
            <div class="d-none d-md-block">
                <span class="badge bg-light text-dark">
                    <i class="bi bi-calendar-check me-1"></i>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM events");
                            if (rs.next()) {
                                out.print(rs.getInt("total") + " Events");
                            }
                            con.close();
                        } catch (Exception e) {
                            out.print("Error");
                        }
                    %>
                </span>
            </div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card stats-card">
                <div class="stats-number">
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM events");
                            if (rs.next()) {
                                out.print(rs.getInt("total"));
                            }
                            con.close();
                        } catch (Exception e) {
                            out.print("0");
                        }
                    %>
                </div>
                <div class="stats-label">Total Events</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stats-card">
                <div class="stats-number">
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM upcoming_events");
                            if (rs.next()) {
                                out.print(rs.getInt("total"));
                            }
                            con.close();
                        } catch (Exception e) {
                            out.print("0");
                        }
                    %>
                </div>
                <div class="stats-label">Upcoming Events</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stats-card">
                <div class="stats-number">
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM users");
                            if (rs.next()) {
                                out.print(rs.getInt("total"));
                            }
                            con.close();
                        } catch (Exception e) {
                            out.print("0");
                        }
                    %>
                </div>
                <div class="stats-label">Registered Users</div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Add New Event -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <span><i class="bi bi-plus-circle"></i> Add New Event</span>
                </div>
                <div class="card-body">
                    <form action="AddEventServlet" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="eventName" class="form-label">Event Name</label>
                            <input type="text" class="form-control" id="eventName" name="eventName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="eventDesc" rows="3" required></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Event Date</label>
                                <input type="date" class="form-control" name="eventDate" required>
                            </div> 
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Location</label>
                                <input type="text" class="form-control" name="location" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Event Image</label>
                            <input type="file" class="form-control" name="image" accept="image/*">
                            <small class="text-muted">Recommended size: 800x450 pixels</small>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mt-2">
                            <i class="bi bi-calendar-plus me-1"></i> Add Event
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Add Upcoming Event -->
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header">
                    <span><i class="bi bi-megaphone"></i> Add Upcoming Event</span>
                </div>
                <div class="card-body">
                    <form action="AddUpcomingEventServlet" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" name="address" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Promotional Image</label>
                            <input type="file" class="form-control" name="image" accept="image/*">
                            <small class="text-muted">Recommended size: 1200x630 pixels</small>
                        </div>
                        <button type="submit" class="btn btn-success w-100 mt-2">
                            <i class="bi bi-megaphone-fill me-1"></i> Add Upcoming Event
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <!-- Existing Events -->
        <div class="col-lg-6">
            <h3 class="section-title">All Events</h3>
            <div class="card">
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                    <%
                        Connection con = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            String query = "SELECT * FROM events ORDER BY event_date DESC";
                            pst = con.prepareStatement(query);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                    %>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1"><%= rs.getString("event_name") %></h5>
                                    <div class="event-date">
                                        <i class="bi bi-calendar-event"></i>
                                        <%= rs.getString("event_date") %>
                                        <span class="mx-2">•</span>
                                        <i class="bi bi-geo-alt"></i>
                                        <%= rs.getString("location") %>
                                    </div>
                                </div>
                                <div class="event-actions">
                                    <a href="EditEvent.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning action-btn">
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>
                                    <a href="DeleteEventServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger action-btn" onclick="return confirm('Delete this event?');">
                                        <i class="bi bi-trash"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<div class='alert alert-danger m-3'>Error fetching events: " + e.getMessage() + "</div>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        }
                    %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Upcoming Events -->
        <div class="col-lg-6">
            <h3 class="section-title">Upcoming Events</h3>
            <div class="card">
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            String query = "SELECT * FROM upcoming_events ORDER BY event_date DESC";
                            pst = con.prepareStatement(query);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                    %>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1"><%= rs.getString("title") %></h5>
                                    <div class="event-date">
                                        <i class="bi bi-calendar-event"></i>
                                        <%= rs.getString("event_date") %>
                                    </div>
                                    <small class="text-muted">
                                        <i class="bi bi-geo-alt"></i>
                                        <%= rs.getString("address") %>
                                    </small>
                                </div>
                                <div class="event-actions">
                                    <a href="EditUpcomingEvent.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning action-btn">
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>
                                    <a href="DeleteUpcomingEventServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger action-btn" onclick="return confirm('Delete this upcoming event?');">
                                        <i class="bi bi-trash"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<div class='alert alert-danger m-3'>Error fetching upcoming events: " + e.getMessage() + "</div>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        }
                    %>
                    </div>
                </div>
            </div>
        </div>
    </div>

   <!-- Users Table -->
<div class="mt-5">
    <h3 class="section-title">
        <a href="javascript:void(0)" onclick="toggleSection('registeredUsersSection')" class="text-decoration-none">
            Registered Users <i class="bi bi-chevron-down" id="registeredUsersIcon"></i>
        </a>
    </h3>
    <div class="card" id="registeredUsersSection">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            String userQuery = "SELECT id, name, email FROM users ORDER BY id DESC";
                            pst = con.prepareStatement(userQuery);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td>
                                <a href="DeleteUserServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?');">
                                    <i class="bi bi-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4' class='text-center py-4 text-danger'>Error fetching users: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<!-- Upcoming Events Registered Users Table -->
<div class="mt-5">
    <h3 class="section-title">
        <a href="javascript:void(0)" onclick="toggleSection('upcomingEventsUsersSection')" class="text-decoration-none">
            Upcoming Events Registered Users <i class="bi bi-chevron-down" id="upcomingEventsUsersIcon"></i>
        </a>
    </h3>
    <div class="card" id="upcomingEventsUsersSection">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Event ID</th>
                            <th>Email</th>
                            <th>Registration Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            String userQuery = "SELECT id, event_id, email, registration_time FROM upcoming_event_registrations ORDER BY id DESC";
                            pst = con.prepareStatement(userQuery);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("event_id") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("registration_time") %></td>
                            <td>
                                <a href="DeleteUpcomingRegistrationServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?');">
                                    <i class="bi bi-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4' class='text-center py-4 text-danger'>Error fetching users: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Upcoming Events Registered Users Table -->
<div class="mt-5">
    <h3 class="section-title">
        <a href="javascript:void(0)" onclick="toggleSection('upcomingEventsUsersSection')" class="text-decoration-none">
            Events Registered Users <i class="bi bi-chevron-down" id="upcomingEventsUsersIcon"></i>
        </a>
    </h3>
    <div class="card" id="upcomingEventsUsersSection">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Event ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Registration Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
                            String userQuery = "SELECT id, event_id, name,email,phone, registration_time FROM event_registrations ORDER BY id DESC";
                            pst = con.prepareStatement(userQuery);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("event_id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone") %></td>
                            <td><%= rs.getString("registration_time") %></td>
                            <td>
                                <a href="DeleteEventRegistrationServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this user?');">
                                    <i class="bi bi-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4' class='text-center py-4 text-danger'>Error fetching users: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>



<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5><i class="bi bi-calendar-event me-2"></i> EventHub</h5>
                <p class="text-muted">Professional event management system for organizers</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="mb-0">&copy; 2023 EventHub. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>


<!-- Add this JavaScript at the bottom of your page, before </body> -->
<script>
    // Function to toggle section visibility
    function toggleSection(sectionId) {
        const section = document.getElementById(sectionId);
        const icon = document.getElementById(sectionId + 'Icon');
        
        if (section.style.display === 'none') {
            section.style.display = 'block';
            icon.classList.remove('bi-chevron-right');
            icon.classList.add('bi-chevron-down');
        } else {
            section.style.display = 'none';
            icon.classList.remove('bi-chevron-down');
            icon.classList.add('bi-chevron-right');
        }
    }

    // Initialize sections to be collapsed by default
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('registeredUsersSection').style.display = 'none';
        document.getElementById('upcomingEventsUsersSection').style.display = 'none';
        document.getElementById('registeredUsersIcon').classList.remove('bi-chevron-down');
        document.getElementById('registeredUsersIcon').classList.add('bi-chevron-right');
        document.getElementById('upcomingEventsUsersIcon').classList.remove('bi-chevron-down');
        document.getElementById('upcomingEventsUsersIcon').classList.add('bi-chevron-right');
    });
</script>

</body>
</html>