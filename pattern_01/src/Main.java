public class Main {

    public static void main(String[] args) {

        // Current usage
        // BookMetadataFormatter formatter = null;
        // try {
        // formatter =
        // BookMetadataFormatterFactory.getBookMetadataFormatter(BookMetadataFormatterFactory.Format.JSON);
        // formatter.append(TestData.dragonBook);
        // formatter.append(TestData.dinosaurBook);
        // System.out.println(formatter.getMetadataString());
        // formatter.reset();
        // System.out.println("reset");
        // System.out.print(formatter.getMetadataString());
        // } catch (IOException e) {
        // e.printStackTrace();
        // } catch (ParserConfigurationException e) {
        // e.printStackTrace();

        // }

        // Expected usage
        BookMetadataExporter exporter = new XMLBookMetadataExporter();
        exporter.add(TestData.sailboatBook);
        exporter.add(TestData.GoFBook);
        exporter.export(System.out);
    }
}
