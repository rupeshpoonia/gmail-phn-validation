

```
# Gmail & Phone Number Validation Package

This package provides functionality for validating Gmail addresses and Indian phone numbers using the libphonenumber-for-php library and the Illuminate validation component.

## Features

- Email validation: Validates if an email address is in a valid format according to the FILTER_VALIDATE_EMAIL filter.
- Phone number validation: Validates if a phone number is a valid Indian number by utilizing the libphonenumber-for-php library.

## Requirements

- PHP 7.4 or higher
- giggsey/libphonenumber-for-php library
- illuminate/validation component

## Installation

You can install this package using Composer. Run the following command:

```bash
composer require rupeshpoonia/gmail-phn-validation
```

## Usage

### Email Validation

To validate an email address, use the `ValidEmail` class:

```php
use rupeshpoonia\ValidEmail;

$email = 'test@example.com';
if (ValidEmail::validate('email', $email)) {
    echo 'Valid email address.';
} else {
    echo 'Invalid email address.';
} 
```

### Phone Number Validation

To validate a phone number, use the `ValidPhoneNumber` class:

```php
use rupeshpoonia\ValidPhoneNumber;

$phoneNumber = '+911234567890';
if (ValidPhoneNumber::validate('phone', $phoneNumber)) {
    echo 'Valid phone number.';
} else {
    echo 'Invalid phone number.';
}
```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This package is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.
```

You can customize and modify this README file to provide additional details or instructions specific to your package. Include information about installation, usage examples, contributing guidelines, and license details.

Remember to include any necessary links, such as the repository link, license file, and relevant documentation.

Feel free to adjust the README file as needed to accurately represent your package and provide useful information to potential users and contributors.

Let me know if you need further assistance or have any other questions!
