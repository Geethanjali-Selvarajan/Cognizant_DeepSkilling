import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    public interface Calculator {
        int add(int a, int b);
    }

    @Test
    void testCalculatorMocking() {
        Calculator mockCalc = mock(Calculator.class);

        when(mockCalc.add(10, 20)).thenReturn(30);
        when(mockCalc.add(5, 5)).thenReturn(10);

        assertEquals(30, mockCalc.add(10, 20));
        assertEquals(10, mockCalc.add(5, 5));
        assertEquals(0, mockCalc.add(2, 3)); 
    }
}
