import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class BankAccountTest {

    BankAccount account;

    @BeforeEach
    void setUp() {
        account = new BankAccount(); // Arrange
    }

    @Test
    void testDeposit() {
        account.deposit(1000);       // Act
        assertEquals(1000, account.getBalance()); // Assert
    }

    @Test
    void testWithdraw() {
        account.deposit(500);
        account.withdraw(200);
        assertEquals(300, account.getBalance());
    }

    @AfterEach
    void tearDown() {
        System.out.println("Test completed.");
    }
}
