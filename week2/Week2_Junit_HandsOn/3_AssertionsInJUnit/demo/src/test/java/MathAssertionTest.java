import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class MathAssertionTest {

    @Test
    void testNumberPositive() {
        int num = 10;
        assertTrue(num > 0);
    }

    @Test
    void testNotEqual() {
        assertNotEquals(10, 20);
    }
}
