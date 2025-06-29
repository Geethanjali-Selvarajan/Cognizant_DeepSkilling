package Cognizant_DeepSkilling.Week1_DesignPrinciplesAndPatterns_HandsOn.HandsOn_FactoryMethodPattern.Code;
public class PdfDocumentFactory extends DocumentFactory {
    public Document createDocument() {
        return new PdfDocument();
    }
}