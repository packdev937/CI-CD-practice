package com.example.cicdpractice;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;


class BasicControllerTest {

    @Test
    void test() {
        int sum = 5;
        sum += 5;
        assertEquals(10, sum);
    }
}