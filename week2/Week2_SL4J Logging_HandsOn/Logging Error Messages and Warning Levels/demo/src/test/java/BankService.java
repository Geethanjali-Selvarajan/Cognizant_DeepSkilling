import java.util.logging.Logger;
public class BankService {

    private static final Logger logger = Logger.getLogger(BankService.class.getName());

    public void transferFunds(String fromAccount, String toAccount, double amount) {
        if (amount <= 0) {
            logger.warning("Transfer amount must be positive!");
            return;
        }

        
        logger.info("Transferring $" + amount + " from " + fromAccount + " to " + toAccount);
    }

    public static void main(String[] args) {
        BankService service = new BankService();
        service.transferFunds("ACC001", "ACC002", 1000);
        service.transferFunds("ACC003", "ACC004", -50); 
    }
}
