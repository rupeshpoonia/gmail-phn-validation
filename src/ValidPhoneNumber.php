<?php
namespace rupeshpoonia;

use libphonenumber\PhoneNumberUtil;
use libphonenumber\PhoneNumberFormat;
use libphonenumber\NumberParseException;

class ValidPhoneNumber
{
    public static function validate($attribute, $value)
    {
        $phoneUtil = PhoneNumberUtil::getInstance();

        try {
            if (substr($value, 0, 1) !== '+' && strlen($value) === 10) {
                $value = '+91' . $value;
                return $phoneUtil->isValidNumber($phoneUtil->parse($value, 'IN'));
            } else {
                return false;
            }
        } catch (NumberParseException $e) {
            return false;
        }
    }
}
