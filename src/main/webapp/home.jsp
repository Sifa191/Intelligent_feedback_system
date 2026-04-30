<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
Integer student=(Integer)session.getAttribute("student_id");
if(student == null){
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Feedback Page</title>

<style>
body {
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    font-family:'Segoe UI', sans-serif;

    background: linear-gradient(-45deg, #f7971e, #ffd200, #43cea2, #185a9d);
    background-size:400% 400%;
    animation: gradientBG 8s ease infinite;
}

@keyframes gradientBG {
    0% {background-position:0% 50%;}
    50% {background-position:100% 50%;}
    100% {background-position:0% 50%;}
}

.container {
    background: rgba(255,255,255,0.2);
    backdrop-filter: blur(15px);
    padding:30px;
    border-radius:20px;
    width:350px;
    text-align:center;
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
}

input, textarea {
    width:90%;
    padding:12px;
    margin:10px;
    border-radius:10px;
    border:none;
}

textarea {
    height:80px;
}

button {
    width:95%;
    padding:12px;
    border:none;
    border-radius:10px;
    background:#ff7e5f;
    color:white;
    font-weight:bold;
    cursor:pointer;
}

.success {
    background:#d4edda;
    color:#155724;
    padding:10px;
    border-radius:8px;
    margin-bottom:10px;
}
</style>

</head>

<body>

<!-- LOGOUT BUTTON -->
<div style="position:absolute; top:20px; right:20px;">
<a href="logout" style="background:#ff4d4d;color:white;padding:8p 15px;
border-radius:8px;text-decoration:none;">
Logout
</a>
</div>

<div class="container">

    <h2>Submit Feedback</h2>

    <!-- ✅ SUCCESS MESSAGE -->
    <%
    String msg = request.getParameter("msg");
    if("success".equals(msg)){
    %>
        <div class="success">
            ✔ Feedback Submitted Successfully!
        </div>
    <%
    }
    %>

    <!-- ✅ FEEDBACK FORM -->
    <form action="submitFeedback" method="post">

        <input type="text" name="faculty" placeholder="Faculty Name" required>

        <input type="text" name="subject" placeholder="Subject" required>

        <textarea name="feedback_text" placeholder="Enter Feedback" required></textarea>

        <button type="submit">Submit Feedback</button>

    </form>

</div>

</body>
</html>