package Cognizant_DeepSkilling.Week1_DataStructureAndAlgorithm_HandsOn.HandsOn_EcommercePlatformSearchFunction.Code;
public class main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "T-Shirt", "Apparel"),
            new Product(103, "Mobile", "Electronics"),
            new Product(104, "Shoes", "Footwear"),
            new Product(105, "Headphones", "Electronics")
        };

        String searchItem = "Mobile";

        System.out.println("Linear Search:");
        Product foundLinear = ProductSearch.linearSearch(products, searchItem);
        System.out.println(foundLinear != null ? foundLinear : "Product not found");

        ProductSearch.sortByName(products);
        System.out.println("\nBinary Search:");
        Product foundBinary = ProductSearch.binarySearch(products, searchItem);
        System.out.println(foundBinary != null ? foundBinary : "Product not found");
    }
}
