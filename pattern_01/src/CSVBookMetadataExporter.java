public class CSVBookMetadataExporter extends BookMetadataExporter {

    @Override
    public BookMetadataFormatter export_() {
        try {
            return new CSVBookMetadataFormatter();
        } catch (Exception e) {
            return null;
        }
    }

}
