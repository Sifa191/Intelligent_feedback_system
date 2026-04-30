<%@ page contentType="text/html; 
charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

// 🔐 Security check
if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="5">
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body {
    font-family: Arial;
    background: #f4f7fb;
    margin: 0;
}

.header {
    background: #2c3e50;
    color: white;
    padding: 15px;
    text-align: center;
    position: relative;
}

.logout {
    position: absolute;
    right: 20px;
    top: 15px;
}

.container {
    padding: 20px;
}

.cards {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.card {
    flex: 1;
    background: white;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
.card.total{
	border-left:6px solid #3498db;
}
.card.positive{
	border-left:6px solid #00bcd4;
}
.card.negative{
	border-left:6px solid #f44336;
}
.card.neutral{
	border-left:6px solid #ff9800;
}

.card h2 {
    margin: 0;
}

.btn {
    padding: 10px 15px;
    background: #3498db;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.logout-btn {
    background: red;
}
</style>

</head>

<body>

<div class="header">
    <h1>Admin Dashboard</h1>

    <!-- 🔴 Logout -->
    <div class="logout">
        <a href="logout">
            <button class="btn logout-btn">Logout</button>
        </a>
    </div>
</div>

<div class="container">

<%
int total = 0, positive = 0, negative = 0, neutral = 0;

try {
    Connection con = DBConnection.getConnection();

    ResultSet rs1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM feedback");
    if(rs1.next()) total = rs1.getInt(1);

    ResultSet rs2 = con.createStatement().executeQuery("SELECT COUNT(*) FROM feedback WHERE sentiment='Positive'");
    if(rs2.next()) positive = rs2.getInt(1);

    ResultSet rs3 = con.createStatement().executeQuery("SELECT COUNT(*) FROM feedback WHERE sentiment='Negative'");
    if(rs3.next()) negative = rs3.getInt(1);

    ResultSet rs4 = con.createStatement().executeQuery("SELECT COUNT(*) FROM feedback WHERE sentiment='Neutral'");
    if(rs4.next()) neutral = rs4.getInt(1);

} catch(Exception e) {
    out.println(e);
}
%>

<!-- 🔷 CARDS -->
<div class="cards">

    <div class="card total">
        <h2><%= total %></h2>
        <p>Total Feedback 📊</p>
    </div>

    <div class="card positive">
        <h2><%= positive %></h2>
        <p>Positive 😊</p>
    </div>

    <div class="card negative">
        <h2><%= negative %></h2>
        <p>Negative 😞</p>
    </div>

    <div class="card neutral">
        <h2><%= neutral %></h2>
        <p>Neutral 😐</p>
    </div>

</div>

<!-- 🔷 CHART -->
<div style="width:400px; height:400px; margin:auto;">
    <canvas id="chart"></canvas>
</div>

<script>
window.onload= function(){}
const ctx=document.getElementById("chart").getContext("2d");

new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Positive', 'Negative', 'Neutral'],
        datasets: [{
            data: [<%=positive%>, <%=negative%>, <%=neutral%>],
        backgroundColor:[
        	'#00bcd4',
        	'#f44336',
        	'#ff9800'
        ]
        }]
    },
    options:{
    	responsive: true,
    	maintainAspectRatio: false,
    	
    	animation:{
    			animateScale:true,
    			animateRotate:true
    	},
    	plugins:{
    		tooltip:{
    			callbacks:{
    				label:
    					function(context){
    					let total=<%=total%>;
    					let value=context.raw;
    					let percent=((value/total)*100).toFixed(1);
    					return value+"("+percent+"%)";
    				}
    			}
    		},
    		title:{
    			display: true,
    			text: 'Feedback Sentiment Analysis'
    		}
    	}
    }
});
</script>

<br><br>

<!-- 🔷 BUTTON -->
<a href="viewFeedback.jsp">
    <button class="btn">View Detailed Report</button>
</a>

</div>

</body>
</html>