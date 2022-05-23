# CF-IBAN-Validator

validates a to the function given IBAN according to ISO 7064; written in ColdFusion.
- returns true or false
- cuts anything that's not alphanumeric
- should work on IBANs from every country

## Usage

```ColdFusion
validateIBAN(stringIBAN);
```

## Testing Values

- ```DE89 3704 0044 0532 0130 00 // ok```
- ```AT61 1904 3002 3457 3201 // ok```
- ```FR14 2004 1010 0505 0001 3 // wrong checksum ```
- ```GB82-WEST-1234-5698-7654-32 // ok```
