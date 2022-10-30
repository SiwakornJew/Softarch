public class XMLBookMetadataExporter extends BookMetadataExporter {

    @Override
    public BookMetadataFormatter export_() {
        try {
            return new XMLBookMetadataFormatter();
        } catch (Exception e) {
            return null;
        }
    }

}
