import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class StringTest {

    @Test
    void testStringEquality() {
        String expected = "OpenAI";
        String actual = "OpenAI";
        assertEquals(expected, actual);
    }

    @Test
    void testStringIgnoreCase() {
        String name = "arshad";
        assertTrue(name.equalsIgnoreCase("ARSHAD"));
    }
}
