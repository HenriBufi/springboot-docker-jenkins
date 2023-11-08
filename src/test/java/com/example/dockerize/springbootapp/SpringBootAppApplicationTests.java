package com.example.dockerize.springbootapp;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class SpringBootAppApplicationTests {

    @Test
    public void testGetGreeting() {
        SpringBootAppApplication app = new SpringBootAppApplication();
        String greeting = app.getGreeting();
        assertEquals("Hello spring boot application", greeting);
    }
}
