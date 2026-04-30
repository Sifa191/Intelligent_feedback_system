package servlet;
import util.TextPreprocessor;
import db.DBConnection;
import nlp.IssueIdentifier;
import nlp.SentimentAnalyzer;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {
	private static final long serialVersionUID=1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String feedbackText = request.getParameter("feedback_text");
        String cleanedFeedback=TextPreprocessor.process(feedbackText);
        System.out.println("Original: "+feedbackText);
        System.out.println("Cleaned: "+cleanedFeedback);
        
        String sentiment=SentimentAnalyzer.analyze(cleanedFeedback);
        String issue=IssueIdentifier.identify(cleanedFeedback);
        
        System.out.println("Sentiment: "+sentiment);
        System.out.println("Issue: "+issue);
        
        String faculty=request.getParameter("faculty");
        String subject=request.getParameter("subject");
        HttpSession session = request.getSession();
        Integer studentIdObj=(Integer)session.getAttribute("student_id");
        if(studentIdObj==null) {
        	response.sendRedirect("login.jsp");
        	return;
        }
        int studentId=studentIdObj;

        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO feedback (student_id,faculty,subject,feedback_text,sentiment,issue,date) VALUES (?,?,?,?,?,?, NOW())";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, studentId);
            ps.setString(2, faculty);
            ps.setString(3, subject);
            ps.setString(4, cleanedFeedback);
            ps.setString(5, sentiment);
            ps.setString(6,  issue);

            ps.executeUpdate();

            // ✅ SUCCESS MESSAGE REDIRECT
            response.sendRedirect("home.jsp?msg=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}