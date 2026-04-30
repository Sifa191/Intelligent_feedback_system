<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>

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
    width:320px;
    text-align:center;
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
    background:#6a11cb;
    color:white;
    font-weight:bold;
}
</style>
</head>

<body>

<div class="container">
    <h2>Feedback System</h2>

    <form action="<%= request.getContextPath()%>/login" method="post">
    	<select name="role" required>
    		<option value="student">Student</option>
    		<option value="admin">Admin</option>
    	</select>
        <input type="email" name="email" placeholder="Enter Email" required>
        <input type="password" name="password" placeholder="Enter Password" required>

        <button type="submit">Login</button>
    </form>

    <p>Don't have account?</p>
    <button type="button" onclick="goRegister()">Register</button>
    
    <p style="color:red;">
        <%= request.getParameter("error") != null ? "Invalid Login!" : "" %>
    </p>

    <p style="color:green;">
        <%= request.getParameter("success") != null ? "Registered Successfully!" : "" %>
    </p>
</div>
<script>
	function goRegister(){
		let role=document.querySelector('[name="role"]').value;
		if(role==="admin"){
			window.location="adminRegister.jsp";
		}else{
			window.location="register.jsp";
		}
	}
</script>

</body>
</html>