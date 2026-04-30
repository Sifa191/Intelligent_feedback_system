package util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class TextPreprocessor {

    static Set<String> stopWords = new HashSet<>(Arrays.asList(
        "is", "the", "and", "a", "an", "was", "were", "to", "of", "in", "on"
    ));

    public static String process(String text) {

        text = text.toLowerCase(); // lowercase

        text = text.replaceAll("[^a-zA-Z ]", ""); // remove symbols

        StringBuilder cleaned = new StringBuilder();

        for (String word : text.split(" ")) {
            if (!stopWords.contains(word) && !word.isEmpty()) {
                cleaned.append(word).append(" ");
            }
        }

        return cleaned.toString().trim();
    }
}