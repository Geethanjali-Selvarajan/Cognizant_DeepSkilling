package Cognizant_DeepSkilling.Week1_DesignPrinciplesAndPatterns_HandsOn.HandsOn_FactoryMethodPattern.Code;
public class WordDocumentFactory extends DocumentFactory {
    public Document createDocument() {
        return new WordDocument();
    }
}
