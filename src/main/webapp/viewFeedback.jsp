<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>View Feedback</title>

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #f4f6f9;
}

/* Navbar */
.navbar {
    background: #2c3e50;
    color: white;
    padding: 15px;
    display: flex;
    justify-content: space-between;
}

.navbar a {
    color: white;
    text-decoration: none;
}

/* Cards */
.cards {
    display: flex;
    gap: 20px;
    padding: 20px;
}

.card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    flex: 1;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* Table */
.table-container {
    padding: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
}

th {
    background: #3498db;
    color: white;
    padding: 10px;
}

td {
    padding: 10px;
    border: 1px solid #ddd;
}

/* Search */
.search-box {
    margin-bottom: 15px;
}

input {
    padding: 10px;
    width: 300px;
}
</style>

<script>
function searchTable() {
    let input = document.getElementById("search").value.toLowerCase();
    let rows = document.querySelectorAll("tbody tr");

    rows.forEach(row => {
        let text = row.innerText.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
    });
}
</script>

</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>View Feedback</h2>
    <a href="adminDashboard.jsp">Back</a>
</div>

<!-- TABLE -->
<div class="table-container">

    <div class="search-box">
        <input type="text" id="search" onkeyup="searchTable()" placeholder="Search feedback...">
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Student ID</th>
                <th>Faculty</th>
                <th>Subject</th>
                <th>Feedback</th>
                <th>Date</th>
            </tr>
        </thead>

        <tbody>
        <%
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            st = con.createStatement();

            rs = st.executeQuery("SELECT * FROM feedback ORDER BY feedback_id DESC");

            while(rs.next()){
        %>

            <tr>
                <td><%= rs.getInt("feedback_id") %></td>
                <td><%= rs.getInt("student_id") %></td>
                <td><%= rs.getString("faculty") %></td>
                <td><%= rs.getString("subject") %></td>
                <td><%= rs.getString("feedback_text") %></td>
                <td><%= rs.getString("date") %></td>
            </tr>

        <%
            }
        } catch(Exception e){
            out.println("Error: " + e);
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e){}
            try { if(st != null) st.close(); } catch(Exception e){}
            try { if(con != null) con.close(); } catch(Exception e){}
        }
        %>

        </tbody>
    </table>

</div>

</body>
</html>