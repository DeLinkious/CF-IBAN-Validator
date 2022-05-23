/**
 * validates a to the function given IBAN in standard ISO 7064.
 * testValue: DE08700901001234567890
 * reference: https://www.hettwer-beratung.de/sepa-spezialwissen/sepa-kontoverbindungsdaten/iban-pr%C3%BCfziffer-berechnung/
 * @iban
 * @returntype boolean
 */
function validateIBAN(required String iban) {
	var isValid			= false;
	var checkSum		= 0; // has to be 1 for valid IBAN
	var ibanStripped	= uCase(reReplace(iban, "[^a-zA-Z0-9]", '', "all")); // keep numbers and uppercase letters only
	var ibanModulo 		= createobject("java","java.math.BigInteger").init("97"); // modulo value -> Modulo 97-10 | init as BigInteger, because CF only can calculate with integers not big integers
	// checks for correct IBAN format
	if(reFind("^([A-Z]{2}[]?[0-9]{2})(?=(?:[]?[A-Z0-9]){9,30}$)((?:[]?[A-Z0-9]{3,5}){2,7})([]?[A-Z0-9]{1,3})?$", ibanStripped)){
		var ibanLetters = reMatch("[A-Z]", ibanStripped);
		var replacedLetters = [];
		// turn letters into numbers for calculation
		var letter = "";
		for(letter in ibanLetters){
			arrayAppend(replacedLetters, charsetDecode(letter, "utf-8")[1]-55); // substract 55 to get valid number for calculation
		};
		// change letters to numbers in IBAN
		var i = 0;
		for(i=1; i <= arrayLen(replacedLetters);i++){
			ibanStripped = reReplace(ibanStripped, "#ibanLetters[i]#", replacedLetters[i]);
		}
		// deform iban for calculation, move checksum and numberized letters to the right
		ibanStripped = right(ibanStripped, len(ibanStripped)-6) & left(ibanStripped, 6);
		// change type of iban for calculation |  init as BigInteger, because CF only can calculate with integers not big integers
		ibanStripped = createobject("java","java.math.BigInteger").init(ibanStripped);
		// calculate checksum
		checkSum = ibanStripped.mod(ibanModulo).toString();
		if(checkSum == 1){
			isValid = true;
		}
	}
	return isValid;
}
