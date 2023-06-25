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
    }

    public function testValidPhoneNumberRule()
    {
        $this->assertTrue(ValidPhoneNumber::validate('phone', '1234567890'));
        $this->assertFalse(ValidPhoneNumber::validate('phone', '+1234567890'));
    }
}
