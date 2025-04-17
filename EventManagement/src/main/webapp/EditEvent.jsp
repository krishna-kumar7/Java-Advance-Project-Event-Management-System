<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String id = request.getParameter("id");
    String eventName = "", eventDesc = "", eventDate = "", location = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM events WHERE id = ?");
        pst.setString(1, id);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            eventName = rs.getString("event_name");
            eventDesc = rs.getString("event_desc");
            eventDate = rs.getString("event_date");
            location = rs.getString("location");
        }
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Event</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Event</h2>
    <form action="UpdateEventServlet" method="POST">
        <input type="hidden" name="id" value="<%= id %>">

        <div class="mb-3">
            <label for="eventName" class="form-label">Event Name</label>
            <input type="text" class="form-control" id="eventName" name="eventName" value="<%= eventName %>" required>
        </div>

        <div class="mb-3">
            <label for="eventDesc" class="form-label">Description</label>
            <textarea class="form-control" id="eventDesc" name="eventDesc" rows="3" required><%= eventDesc %></textarea>
        </div>

        <div class="mb-3">
            <label for="eventDate" class="form-label">Date</label>
            <input type="date" class="form-control" id="eventDate" name="eventDate" value="<%= eventDate %>" required>
        </div>

        <div class="mb-3">
            <label for="location" class="form-label">Location</label>
            <input type="text" class="form-control" id="location" name="location" value="<%= location %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Event</button>
    </form>
</div>
</body>
</html>
