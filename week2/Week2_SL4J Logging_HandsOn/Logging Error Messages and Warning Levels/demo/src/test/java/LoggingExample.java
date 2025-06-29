import java.util.logging.Level;
import java.util.logging.Logger;

public class LoggingExample {

    private static final Logger logger = Logger.getLogger(LoggingExample.class.getName());

    public static void main(String[] args) {
        logger.info("App started");

        try {
            int result = 10 / 0; 
        } catch (ArithmeticException ex) {
            logger.log(Level.SEVERE, "Error occurred: Division by zero", ex);
        }

        logger.warning("This is a warning message");
        logger.info("App ended");
    }
}
