<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = "", date = "", address = "", description = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_management", "root", "");
        PreparedStatement pst = con.prepareStatement("SELECT * FROM upcoming_events WHERE id=?");
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            date = rs.getString("event_date");
            address = rs.getString("address");
            description = rs.getString("description");
        }
        rs.close(); pst.close(); con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Upcoming Event</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Upcoming Event</h2>
    <form action="UpdateUpcomingEventServlet" method="POST">
        <input type="hidden" name="id" value="<%= id %>">
        <div class="mb-3">
            <label>Event Title</label>
            <input type="text" class="form-control" name="title" value="<%= title %>" required>
        </div>
        <div class="mb-3">
            <label>Event Date</label>
            <input type="date" class="form-control" name="date" value="<%= date %>" required>
        </div>
        <div class="mb-3">
            <label>Address</label>
            <input type="text" class="form-control" name="address" value="<%= address %>" required>
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea class="form-control" name="description" rows="4"><%= description %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Update Event</button>
        <a href="organizer_dashboard.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
