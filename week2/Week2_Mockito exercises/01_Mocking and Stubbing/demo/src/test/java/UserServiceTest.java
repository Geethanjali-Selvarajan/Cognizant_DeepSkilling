import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class UserServiceTest {

    public interface UserService {
        String getUserName(int userId);
    }

    @Test
    void testMockingUserService() {
        UserService mockService = mock(UserService.class);

        when(mockService.getUserName(1)).thenReturn("ABC");

        assertEquals("Arshad", mockService.getUserName(1));
        assertNull(mockService.getUserName(2)); 
    }
}
