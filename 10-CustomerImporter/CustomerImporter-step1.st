!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputTXTFile validStringStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'FS 11/14/2023 14:26:47'!
assertAddress: address named: streetName numbered: streetNumber locatedIn: aCity zipCode: aZipCode provinceOf: aProvince addressOf: customer

	self assert: address streetName equals: streetName.
self assert: address streetNumber equals: streetNumber.
self assert: address town equals: aCity.
self assert: address zipCode equals: aZipCode.
self assert: address province equals: aProvince.
self assert: ((customer addresses) includes: address)! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'FS 11/14/2023 14:20:55'!
assertCustomer: customer named: aName surnamed: aSurname hasIdType: anIdType numbered: anIdNumber

	self assert: customer identificationType equals: anIdType.
self assert: customer identificationNumber equals: anIdNumber.
self assert: customer firstName equals: aName.
self assert: customer lastName equals: aSurname.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'FS 11/14/2023 14:33:37'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	inputTXTFile := UniFileStream new open: 'input.txt' forWrite: false.
	validStringStream := ReadStream on: 'C,Fran,Sandalinas,D,48789636
A,No les voy a decir,1111,calleFalsa,123,BsAs'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'FS 11/14/2023 14:16:29'!
tearDown

	session commit.
	session close.
	inputTXTFile close.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'FS 11/14/2023 14:29:06'!
test01Import

	| numberOfCustomer customer address numberOfAddress  |
	
	(Importer withSession: session inputStream: inputTXTFile) import.
	
	numberOfCustomer  := (session selectAllOfType: Customer) size.
	numberOfAddress := (session selectAllOfType: Address ) size.
	
	
	self assert: numberOfCustomer equals: 2.
	self assert: numberOfAddress equals: 3.
	
customer := (session select: [:c | c identificationType = 'D' and: [c identificationNumber = '22333444']] ofType: Customer) asOrderedCollection at: 1.
self assertCustomer: customer named: 'Pepe' surnamed: 'Sanchez' hasIdType: 'D' numbered: '22333444'.
address := (session select: [:c | c streetName = 'San Martin' and: [c streetNumber = 3322]] ofType: Address) asOrderedCollection at: 1.
self assertAddress: address named: 'San Martin' numbered: 3322 locatedIn: 'Olivos' zipCode: 1636 provinceOf: 'BsAs' addressOf: customer.
address := (session select: [:c | c streetName = 'Maipu' and: [c streetNumber = 888]] ofType: Address) asOrderedCollection at: 1.
self assertAddress: address named: 'Maipu' numbered: 888 locatedIn: 'Florida' zipCode: 1122 provinceOf: 'Buenos Aires' addressOf: customer.
customer := (session select: [:c | c identificationType = 'C' and: [c identificationNumber = '23-25666777-9']] ofType: Customer) asOrderedCollection at: 1.
self assertCustomer: customer named: 'Juan' surnamed: 'Perez' hasIdType: 'C' numbered: '23-25666777-9'.
address := (session select: [:c | c streetName = 'Alem' and: [c streetNumber = 1122]] ofType: Address) asOrderedCollection at: 1.
self assertAddress: address named: 'Alem' numbered: 1122 locatedIn: 'CABA' zipCode: 1001 provinceOf: 'CABA' addressOf: customer.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'FS 11/14/2023 14:34:41'!
test02ImportString

	| numberOfCustomer customer address numberOfAddress  |
	
	(Importer withSession: session inputStream: validStringStream ) import.
	
	numberOfCustomer  := (session selectAllOfType: Customer) size.
	numberOfAddress := (session selectAllOfType: Address ) size.
	
	
	self assert: numberOfCustomer equals: 1.
	self assert: numberOfAddress equals: 1.
customer := (session select: [:c | c identificationType = 'D' and: [c identificationNumber = '48789636']] ofType: Customer) asOrderedCollection at: 1.
self assertCustomer: customer named: 'Fran' surnamed: 'Sandalinas' hasIdType: 'D' numbered: '48789636'.
address := (session select: [:c | c streetName = 'No les voy a decir' and: [c streetNumber = 1111]] ofType: Address) asOrderedCollection at: 1.
self assertAddress: address named: 'No les voy a decir' numbered: 1111 locatedIn: 'calleFalsa' zipCode: 123 provinceOf: 'BsAs' addressOf: customer.! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Importer category: 'CustomerImporter'!
Object subclass: #Importer
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Importer methodsFor: 'initialization' stamp: 'FS 11/14/2023 14:12:23'!
initializeWithSession: aSession inputStream: anInputStream
	session := aSession.
	inputStream := anInputStream.! !


!Importer methodsFor: 'evaluating' stamp: 'FS 11/14/2023 14:12:23'!
import

	| newCustomer line |
	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth .
			session persist: newAddress ].

		line := inputStream nextLine. ].
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Importer class' category: 'CustomerImporter'!
Importer class
	instanceVariableNames: ''!

!Importer class methodsFor: 'instance creation' stamp: 'FS 11/14/2023 14:12:23'!
withSession: aSession inputStream: anInputStream
	^self new initializeWithSession: aSession inputStream: anInputStream! !
