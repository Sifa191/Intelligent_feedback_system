package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {
            

            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/feedback_system";
            String user = "root";
            String password = "Password@2606";

            con = DriverManager.getConnection(url, user, password);

            //System.out.println("✅ Database Connected Successfully");

        } catch (Exception e) {
            //System.out.println("❌ DB CONNECTION ERROR:");
            e.printStackTrace();   // VERY IMPORTANT
        }

        return con;
    }
}