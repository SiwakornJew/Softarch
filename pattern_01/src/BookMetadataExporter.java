
import java.io.PrintStream;

public abstract class BookMetadataExporter extends BookCollection {

    public void export(PrintStream stream) {
        BookMetadataFormatter formatter = export_();
        for (Book book : books) {
            formatter.append(book);
        }
        stream.println(formatter.getMetadataString());
    }

    public abstract BookMetadataFormatter export_();
}
