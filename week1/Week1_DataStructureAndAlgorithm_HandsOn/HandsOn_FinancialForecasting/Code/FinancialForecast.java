package Cognizant_DeepSkilling.Week1_DataStructureAndAlgorithm_HandsOn.HandsOn_FinancialForecasting.Code;
public class FinancialForecast {
    public static double futureValueRecursive(double presentValue, double rate, int years) {
        if (years == 0) {
            return presentValue;
        }
        return futureValueRecursive(presentValue * (1 + rate), rate, years - 1);
    }
    public static double futureValueMemo(double presentValue, double rate, int years, double[] memo) {
        if (years == 0) return presentValue;
        if (memo[years] != 0) return memo[years];
        memo[years] = futureValueMemo(presentValue * (1 + rate), rate, years - 1, memo);
        return memo[years];
    }
}
