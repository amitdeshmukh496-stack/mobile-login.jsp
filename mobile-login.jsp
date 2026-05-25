<%@ page language="java" %>
<%
    String sessionId = request.getParameter("session_id");
    if (sessionId == null || !sessionId.startsWith("sess_")) {
        response.sendRedirect("error.jsp?msg=Invalid QR Code");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mobile Login - FactoTime</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 20px; }
        .loader { border: 5px solid #f3f3f3; border-top: 5px solid #3498db; border-radius: 50%; width: 50px; height: 50px; animation: spin 1s linear infinite; margin: 20px auto; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    </style>
</head>
<body>
    <h2>FactoTime Mobile Login</h2>
    <div class="loader"></div>
    <p>Processing login...</p>
    
    <script>
        window.onload = function() {
            // Simulate user verification (replace with real logic)
            setTimeout(() => {
                // Send verification back to your Eclipse server
                fetch(`http://localhost:8080/Handdy/QRLoginServlet?session_id=<%= sessionId %>&action=verify`, {
                    method: 'GET'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert("Login successful!");
                        window.location.href = 'http://localhost:8080/Handdy/attendance.jsp';
                    } else {
                        alert("Verification failed.");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("Network error. Please try again.");
                });
            }, 2000);
        };
    </script>
</body>
</html>