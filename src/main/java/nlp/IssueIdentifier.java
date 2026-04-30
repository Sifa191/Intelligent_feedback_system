package nlp;

import java.util.*;

public class IssueIdentifier {

    public static String identify(String text) {

        if (text == null || text.trim().isEmpty()) {
            return "General Feedback";
        }

        text = text.toLowerCase();

        List<String> issues = new ArrayList<>();

        // 🔴 NEGATIVE CONTEXT
        boolean isNegative =
                text.contains("not") ||
                text.contains("no") ||
                text.contains("less") ||
                text.contains("nahi") ||
                text.contains("nhi") ||
                text.contains("ledu") ||
                text.contains("kaadu") ||
                text.contains("kharab") ||
                text.contains("problem") ||
                text.contains("issue") ||
                text.contains("confusing");

        // 🔴 ISSUE RULES

        // Notes
        if ((text.contains("notes") || text.contains("material")) && isNegative) {
            issues.add("Notes Issue");
        }

        // Speed
        if ((text.contains("speed") || text.contains("fast") || text.contains("slow") || text.contains("ekkuva")) && isNegative) {
            issues.add("Teaching Speed Issue");
        }

        // Syllabus
        if ((text.contains("syllabus") || text.contains("portion")) && isNegative) {
            issues.add("Syllabus Coverage Issue");
        }

        // Understanding
        if ((text.contains("understand") || text.contains("confusing") || text.contains("clarity")) && isNegative) {
            issues.add("Understanding Issue");
        }

        // Doubts
        if ((text.contains("doubt") || text.contains("question")) && isNegative) {
            issues.add("Doubt Clarification Issue");
        }

        // Lab
        if ((text.contains("lab") || text.contains("practical")) && isNegative) {
            issues.add("Lab Issue");
        }

        // Assignment
        if ((text.contains("assignment") || text.contains("homework")) && isNegative) {
            issues.add("Assignment Issue");
        }

        // 🔥 FINAL OUTPUT
        if (!issues.isEmpty()) {
            return String.join(", ", issues);
        }

        if (isNegative) {
            return "General Negative Feedback";
        }

        return "No Issue (Positive Feedback)";
    }
}