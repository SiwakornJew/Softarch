public class JSONBookMetadataExporter extends BookMetadataExporter {

    @Override
    public BookMetadataFormatter export_() {
        try {
            return new JSONBookMetadataFormatter();
        } catch (Exception e) {
            return null;
        }
    }

}
