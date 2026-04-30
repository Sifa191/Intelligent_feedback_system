<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Register</title>

<style>
body {
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    font-family: 'Segoe UI', sans-serif;

    background: linear-gradient(-45deg, #f7971e, #ffd200, #43cea2, #185a9d);
    background-size: 400% 400%;
    animation: gradientBG 8s ease infinite;
}

@keyframes gradientBG {
    0% { background-position:0% 50%; }
    50% { background-position:100% 50%; }
    100% { background-position:0% 50%; }
}

.container {
    background: rgba(255,255,255,0.2);
    backdrop-filter: blur(15px);
    padding:30px;
    border-radius:20px;
    width:330px;
    text-align:center;
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
}

input {
    width:90%;
    padding:12px;
    margin:10px;
    border-radius:10px;
    border:none;
}

button {
    width:95%;
    padding:12px;
    border:none;
    border-radius:10px;
    background:#11998e;
    color:white;
    font-weight:bold;
    cursor:pointer;
}

button:hover {
    background:#38ef7d;
}
</style>

</head>

<body>

<div class="container">
    <h2>Create Admin Account</h2>

    <form action="Register" method="post">

        <!-- IMPORTANT -->
        <input type="hidden" name="role" value="admin">

       
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Register</button>
    </form>

    <p><a href="login.jsp">Already have account? Login</a></p>
</div>

</body>
</html>