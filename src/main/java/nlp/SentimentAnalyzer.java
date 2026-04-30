package nlp;

import java.util.*;

public class SentimentAnalyzer {

    static Set<String> positiveWords = new HashSet<>(Arrays.asList(
        // English
        "good", "great", "excellent", "nice", "well", "best",

        // Telugu (typed)
        "bagundi", "bagundhi", "baagundi", "manchi",

        // Hindi (typed)
        "acha", "achha", "badhiya"
    ));

    static Set<String> negativeWords = new HashSet<>(Arrays.asList(
        // English
        "bad", "poor", "worst", "slow", "problem", "issue",
        "difficult", "confusing",

        // Hindi
        "kharab", "bekar", "nahi", "nhi",

        // Telugu
        "ledu", "kaadu", "kastam"
    ));

    public static String analyze(String text) {

        if (text == null || text.isEmpty()) {
            return "Neutral";
        }

        text = text.toLowerCase();

        int positive = 0;
        int negative = 0;

        // 🔴 PHRASE DETECTION (VERY IMPORTANT)
        if (text.contains("not good") || text.contains("not satisfied")) {
            negative += 3;
        }

        if (text.contains("not provided") || text.contains("no notes")) {
            negative += 3;
        }

        // 🔴 WORD LEVEL
        for (String word : text.split(" ")) {

            if (positiveWords.contains(word)) {
                positive++;
            }

            if (negativeWords.contains(word)) {
                negative += 2; // higher weight
            }
        }

        // 🔥 FINAL DECISION
        if (negative > positive) return "Negative";
        if (positive > negative) return "Positive";

        return "Neutral";
    }
}