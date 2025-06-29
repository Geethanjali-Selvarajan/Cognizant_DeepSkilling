package Cognizant_DeepSkilling.Week1_DataStructureAndAlgorithm_HandsOn.HandsOn_EcommercePlatformSearchFunction.Code;
public class ProductSearch {
    public static Product linearSearch(Product[] products, String targetName) {
        for (Product product : products) {
            if (product.productName.equalsIgnoreCase(targetName)) {
                return product;
            }
        }
        return null;
    }
    public static Product binarySearch(Product[] products, String targetName) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int result = targetName.compareToIgnoreCase(products[mid].productName);

            if (result == 0) {
                return products[mid];
            } else if (result < 0) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return null;
    }
    public static void sortByName(Product[] products) {
    int n = products.length;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (products[j].productName.compareToIgnoreCase(products[j + 1].productName) > 0) {
                Product temp = products[j];
                products[j] = products[j + 1];
                products[j + 1] = temp;
            }
        }
    }
}

}
