package com.example.dockerize.springbootapp;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class SpringBootAppApplicationTests {

    @Test
    public void testAddMethod() {
        SpringBootAppApplication app = new SpringBootAppApplication();
        int result = app.add(2, 3);
        assertEquals(5, result);
    }

}
