package Cognizant_DeepSkilling.Week1_DataStructureAndAlgorithm_HandsOn.HandsOn_FinancialForecasting.Code;
public class main {
    public static void main(String[] args) {
        double presentValue = 1000.0;
        double growthRate = 0.05;
        int years = 10;

        double result = FinancialForecast.futureValueRecursive(presentValue, growthRate, years);
        System.out.printf("Recursive Method\n");
        System.out.printf(" Future Value after %d years: %.2f\n", years, result);
        
        double[] memo = new double[years + 1];
        System.out.printf("Memoized\n");
        double resultMemo = FinancialForecast.futureValueMemo(presentValue, growthRate, years, memo);
        System.out.printf(" Future Value after %d years: %.2f\n", years, resultMemo);
    }
}

