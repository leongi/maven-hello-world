package com.myapp;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * Unit test for simple App.
 */
public class AppTest 
{
    @Test
    public void messageContainsName()
    {
        assertTrue( App.MESSAGE.contains( "Leon" ) );
    }
}
