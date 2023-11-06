!classDefinition: #TestCaja category: 'TiendaDeLibros'!
TestCase subclass: #TestCaja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:35:01'!
createCatalogue
	| catalogue |
	catalogue := Dictionary new.
	catalogue at: 'OurOwnCoolBooks' put: 10.
	^catalogue.! !

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:17:52'!
expiredCard
	|expiration|
	expiration := FixedGregorianDate yesterday .
	^CreditCard withNumber: 000000000000 expirationDate: expiration owner: 'pepe'.
	! !

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:32:50'!
test01CantCheckoutWhenCartIsEmpty
	|cart catalogue card cashier logbook|
	catalogue := self createCatalogue.
	cart := Cart fromCatalogue: catalogue .
	card := self validCard.
	cashier := Cashier new.
	logbook :=OrderedCollection new.
	
	self should: [ cashier checkout: cart withCard: card onRegister: logbook]
	raise: Error
	withExceptionDo: [ :error |
		self assert: error messageText equals: Cashier emptyCart.
		].
	! !

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:33:31'!
test02CantCheckoutWhenCardIsExpired
	|cart catalogue card cashier logbook|
	catalogue := self createCatalogue.
	cart := Cart fromCatalogue: catalogue .
	cart add: 1 copiesOf: 'OurOwnCoolBooks'.
	card := self expiredCard.
	cashier := Cashier new.
	logbook :=OrderedCollection new.
	
	self should: [ cashier checkout: cart withCard: card onRegister: logbook]
	raise: Error	
	withExceptionDo: [ :error |
		self assert: error messageText equals: Cashier expiredCard.
		]
	
	! !

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:34:01'!
test03PurchaseRendersCartEmpty
	|cart catalogue card cashier logbook|
	catalogue := self createCatalogue.
	cart := Cart fromCatalogue: catalogue .
	cart add: 1 copiesOf: 'OurOwnCoolBooks'.
	card := self validCard.
	cashier := Cashier new.
	logbook :=OrderedCollection new.
	
	cashier checkout: cart withCard: card onRegister: logbook.
	self assert: cart isEmpty.
	
	! !

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:36:09'!
test04SaleIsRegistered
	|cart catalogue card cashier logbook sale|
	catalogue := self createCatalogue.
	cart := Cart fromCatalogue: catalogue .
	cart add: 1 copiesOf: 'OurOwnCoolBooks'.
	card := self validCard .
	cashier := Cashier new.
	logbook := OrderedCollection new.
	
	sale := cashier checkout: cart withCard: card onRegister: logbook.
	self assert: logbook size = 1.
	self assert: logbook includes: sale.
	
	! !

!TestCaja methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:17:43'!
validCard
	|expiration|
	expiration := FixedGregorianDate tomorrow .
	^CreditCard withNumber: 000000000000 expirationDate: expiration owner: 'pepe'.
	! !


!classDefinition: #TestCart category: 'TiendaDeLibros'!
TestCase subclass: #TestCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:14:09'!
createCatalogue
	| catalogue |
	catalogue := Dictionary new.
	catalogue at: 'OurOwnCoolBooks' put: 10.
	^catalogue.! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:14:40'!
test01NewCartIsEmpty
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	self assert: (cart isEmpty).! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:15:16'!
test02AddingBookToCartMakesItNoLongerEmpty
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	cart add: 2 copiesOf: 'OurOwnCoolBooks'.
	self deny: (cart isEmpty).! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:16:05'!
test03AddingBookToCartMakesItHoldTheBook
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	cart add: 1 copiesOf: 'OurOwnCoolBooks'.
	self assert: (cart listContents includes: 'OurOwnCoolBooks').! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:16:17'!
test04CannotAddBookFromAnotherEditorial
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	
	self should: [ cart add: 1 copiesOf: 'CoolBookFromAnotherEditorialThatStinks!!'. ]
	raise: Error
	withExceptionDo: [ :error |
		self assert: cart isEmpty .
		self assert: error messageText equals: Cart bookFromAnotherEditorial.
		]
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:16:28'!
test05Adding2CopiesMakesCartHold2Copies
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	cart add: 2 copiesOf: 'OurOwnCoolBooks'.
	self assert: ((cart listContents occurrencesOf: 'OurOwnCoolBooks') = 2).! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:16:56'!
test06CannotAddZeroOrNegativeBooks
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	self should: [ cart add: -22 copiesOf: 'OurOwnCoolBooks'.]
	raise: Error
	withExceptionDo: [ :error |
		self deny: ((cart listContents) includes: 'OurOwnCoolBooks').
		self assert: error messageText equals: Cart InvalidAmount.
		]! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/5/2023 23:18:21'!
test07CartKnowsItsPrice
	| cart catalogue |
	catalogue := self createCatalogue .
	cart := Cart fromCatalogue: catalogue.
	cart add: 2 copiesOf: 'OurOwnCoolBooks'.
	self assert: 20 equals: cart currentPrice.! !


!classDefinition: #Cart category: 'TiendaDeLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!Cart methodsFor: 'events-registering' stamp: 'JGFS 11/5/2023 23:12:23'!
add: aQuantity copiesOf: aBookISBN
	((editorial includesKey: aBookISBN) and: (self amountIsStrictlyPositive: aQuantity)) 
	ifTrue:
		[ contents add: aBookISBN withOccurrences: aQuantity]
		ifFalse:
		[^self error: Cart bookFromAnotherEditorial]! !

!Cart methodsFor: 'events-registering' stamp: 'JGFS 11/2/2023 19:28:10'!
emptySelf
	contents := Bag new.! !


!Cart methodsFor: 'inspecting' stamp: 'JGFS 11/2/2023 14:43:19'!
amountIsStrictlyPositive: aQuantity
	aQuantity > 0 ifTrue: [^true]
				ifFalse:[^self error: Cart InvalidAmount]! !

!Cart methodsFor: 'inspecting' stamp: 'JGFS 11/5/2023 23:19:31'!
currentPrice
	^contents inject: 0 into: [:totalPrice :item | totalPrice + (editorial at: item)]! !

!Cart methodsFor: 'inspecting' stamp: 'JGFS 10/30/2023 19:55:57'!
isEmpty
	^contents isEmpty ! !

!Cart methodsFor: 'inspecting' stamp: 'JGFS 10/30/2023 19:57:49'!
listContents
	^contents ! !


!Cart methodsFor: 'initialization' stamp: 'JGFS 10/30/2023 20:16:18'!
with: anEditorial
	contents := Bag new.
	editorial := anEditorial.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TiendaDeLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'JGFS 11/2/2023 14:41:35'!
InvalidAmount
	^'The amount must be greater than 0'.! !

!Cart class methodsFor: 'instance creation' stamp: 'JGFS 11/2/2023 19:36:46'!
bookFromAnotherEditorial
	^'Book from another editorial'.! !

!Cart class methodsFor: 'instance creation' stamp: 'JGFS 11/5/2023 23:10:44'!
fromCatalogue: anEditorial
	^self new with: anEditorial .! !


!classDefinition: #Cashier category: 'TiendaDeLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'clientCart bankcard logbook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!Cashier methodsFor: 'assertions' stamp: 'JGFS 11/5/2023 23:42:48'!
assertCardIsValid.
	(bankcard isExpired) ifTrue: [^self error: Cashier expiredCard ].! !

!Cashier methodsFor: 'assertions' stamp: 'JGFS 11/5/2023 23:36:30'!
assertCartIsNotEmpty
	(clientCart isEmpty) ifTrue: [^self error: Cashier emptyCart ].
! !


!Cashier methodsFor: 'purchasing' stamp: 'JGFS 11/6/2023 10:56:37'!
checkout: cart withCard: card onRegister: logBook.
	clientCart := cart.
	bankcard := card.
	logbook := logBook.
	self assertCartIsNotEmpty.
	self assertCardIsValid.
	^self purchaseSuccessful.! !

!Cashier methodsFor: 'purchasing' stamp: 'JGFS 11/6/2023 10:56:30'!
purchaseSuccessful
	"self chargeCard."
	^self registerSale.
	! !

!Cashier methodsFor: 'purchasing' stamp: 'JGFS 11/6/2023 10:57:16'!
registerSale
	|sale|
	sale :=Sale ofTotal: clientCart currentPrice.
	logbook add: (sale).
	clientCart emptySelf.
	^sale! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TiendaDeLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'class initialization' stamp: 'JGFS 11/2/2023 18:58:51'!
emptyCart
	^'The cart is empty'.! !

!Cashier class methodsFor: 'class initialization' stamp: 'JGFS 11/2/2023 19:14:53'!
expiredCard
	^'The card is expired'.! !


!classDefinition: #CreditCard category: 'TiendaDeLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration validOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JGFS 11/5/2023 23:33:10'!
initializeWithNumber: Number expirationDate: Expiration owner: ValidOwner 
	number := Number.
	expiration := Expiration.
	validOwner := ValidOwner.! !

!CreditCard methodsFor: 'initialization' stamp: 'JGFS 11/6/2023 10:17:32'!
isExpired
	^(expiration < FixedGregorianDate today)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TiendaDeLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JGFS 11/5/2023 23:32:47'!
withNumber: Number expirationDate: Expiration owner: ValidOwner 
	^self new initializeWithNumber: Number expirationDate: Expiration owner: ValidOwner! !


!classDefinition: #Sale category: 'TiendaDeLibros'!
Object subclass: #Sale
	instanceVariableNames: 'price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:53:55'!
with: totalCost.
	price := totalCost .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TiendaDeLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'JGFS 11/6/2023 10:54:01'!
ofTotal: totalCost.
	self new with: totalCost.
	! !
