<?php
use PHPUnit\Framework\TestCase;
use rupeshpoonia\ValidEmail;
use rupeshpoonia\ValidPhoneNumber;

class ValidationRulesTest extends TestCase
{
    public function testValidEmailRule()
    {
        $this->assertTrue(ValidEmail::validate('email', 'test@example.com'));
        $this->assertFalse(ValidEmail::validate('email', 'testexample-email'));
        $this->assertFalse(ValidEmail::validate('email', 'test@example')); 
        $this->assertFalse(ValidEmail::validate('email', 'test@example..com')); 
        $this->assertFalse(ValidEmail::validate('email', 'test.example.com')); 
    }

    public function testValidPhoneNumberRule()
    {
        $this->assertFalse(ValidPhoneNumber::validate('phone', '+1234567890'));
        $this->assertTrue(ValidPhoneNumber::validate('phone', '1234567890'));
        $this->assertFalse(ValidPhoneNumber::validate('phone', '+1-234567890')); 
        $this->assertFalse(ValidPhoneNumber::validate('phone', '+1234')); 
        $this->assertFalse(ValidPhoneNumber::validate('phone', '+12345678901234567890')); 
    }
}
