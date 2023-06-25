<?php

namespace rupeshpoonia;

class ValidEmail
{
    public static function validate($attribute, $value)
    {
        return filter_var($value, FILTER_VALIDATE_EMAIL) !== false;
    }
}
