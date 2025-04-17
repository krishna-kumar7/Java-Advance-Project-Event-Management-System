<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("signin.jsp");
        return;
    }

    String eventIdParam = request.getParameter("event_id");
    if (eventIdParam == null) {
        out.println("<h3 style='color:red;'>Event ID not found in URL!</h3>");
        return;
    }

    int eventId = Integer.parseInt(eventIdParam);
    String name = (String) session.getAttribute("user");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register for Event</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f4f8;
        }

        .register-container {
            max-width: 550px;
            margin: auto;
            margin-top: 70px;
            background-color: white;
            padding: 30px 35px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .form-label {
            font-weight: 600;
        }

        .btn-primary {
            width: 100%;
            border-radius: 30px;
            padding: 10px;
            font-weight: 600;
        }

        .alert {
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="register-container">

        <h3 class="text-center mb-4 text-primary">Register for the Event</h3>

        <% 
            String successMsg = (String) session.getAttribute("successMsg");
            String errorMsg = (String) session.getAttribute("errorMsg");
            if (successMsg != null) {
        %>
            <div class="alert alert-success"><%= successMsg %></div>
        <% 
                session.removeAttribute("successMsg");
            } else if (errorMsg != null) {
        %>
            <div class="alert alert-danger"><%= errorMsg %></div>
        <%
                session.removeAttribute("errorMsg");
            }
        %>

        <form action="EventRegisterServlet" method="post">
            <input type="hidden" name="event_id" value="<%= eventId %>">

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" value="<%= name != null ? name : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" value="<%= email != null ? email : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phone" class="form-control" value="<%= phone != null ? phone : "" %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Register Now</button>
        </form>

    </div>
</div>

</body>
</html>
