import java.io.IOException;

import java.util.HashMap;

import org.json.simple.JSONArray;

import com.google.gson.Gson;

public class JSONBookMetadataFormatter implements BookMetadataFormatter {
    Gson gson = new Gson();
    JSONArray obj = new JSONArray();

    public JSONBookMetadataFormatter() throws IOException {
        reset();
    }

    @Override
    public BookMetadataFormatter reset() {
        // Please implement this method. You may create additional methods as you see
        // fit.
        obj = new JSONArray();
        return this;
    }

    @Override
    public BookMetadataFormatter append(Book b) {
        HashMap<String, Object> book = new HashMap<String, Object>();
        book.put(Book.Metadata.ISBN.value, b.getISBN());
        book.put(Book.Metadata.TITLE.value, b.getTitle());
        book.put(Book.Metadata.PUBLISHER.value, b.getPublisher());
        JSONArray authors = new JSONArray();
        for (String x : b.getAuthors()) {
            authors.add(x);
        }
        book.put(Book.Metadata.AUTHORS.value, authors);
        obj.add(book);
        return this;
    }

    @Override
    public String getMetadataString() {
        // Please implement this method. You may create additional methods as you see
        // fit.
        return obj.toString();
    }
}
