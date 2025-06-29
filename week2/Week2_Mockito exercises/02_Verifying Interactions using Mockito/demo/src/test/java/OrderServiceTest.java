import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;

public class OrderServiceTest {

    public interface PaymentGateway {
        void processPayment(String accountId, double amount);
    }

    public class OrderService {
        private PaymentGateway gateway;

        public OrderService(PaymentGateway gateway) {
            this.gateway = gateway;
        }

        public void placeOrder(String accountId, double total) {
            gateway.processPayment(accountId, total);
        }
    }

    @Test
    void testProcessPaymentIsCalled() {
        PaymentGateway mockGateway = mock(PaymentGateway.class);
        OrderService service = new OrderService(mockGateway);

        service.placeOrder("ACC123", 500.00);

        verify(mockGateway).processPayment("ACC123", 500.00);
    }
}
