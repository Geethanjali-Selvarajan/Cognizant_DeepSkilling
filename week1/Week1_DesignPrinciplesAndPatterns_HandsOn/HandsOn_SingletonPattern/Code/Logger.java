package Cognizant_DeepSkilling.Week1_DesignPrinciplesAndPatterns_HandsOn.HandsOn_SingletonPattern.Code;
public class Logger {
    private static Logger instance = new Logger();
    private Logger() {
        System.out.println("Logger instance created.");
    }
    public static Logger getInstance() {
        return instance;
    }
    public void log(String message) {
        System.out.println("Log: " + message);
    }
}
