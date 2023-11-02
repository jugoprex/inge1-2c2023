!classDefinition: #TestCart category: 'TiendaDeLibros'!
TestCase subclass: #TestCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 20:04:29'!
test01NewCartIsEmpty
	| cart Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: 'OurOwnCoolBooks').
	cart := Cart fromEditorial: Billiken.
	self assert: (cart isEmpty).! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 20:16:49'!
test02AddingBookToCartMakesItNoLongerEmpty
	| cart Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: 'SuperCoolISBN').
	cart := Cart fromEditorial: Billiken.
	cart add: 2 copiesOf: 'SuperCoolISBN'.
	self deny: (cart isEmpty).! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 20:16:57'!
test03AddingBookToCartMakesItHoldTheBook
	| cart Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: 'ISBNCool').
	cart := Cart fromEditorial: Billiken.
	cart add: 1 copiesOf: 'ISBNCool'.
	self assert: (cart listContents includes: 'ISBNCool').! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/2/2023 14:45:31'!
test04CannotAddBookFromAnotherEditorial
	| cart Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: 'OurOwnCoolBooks').
	cart := Cart fromEditorial: Billiken.
	
	self should: [ cart add: 1 copiesOf: 'CoolBookFromAnotherEditorialThatStinks!!'. ]
	raise: Error
	withExceptionDo: [ :error |
		self deny: ((cart listContents) includes: 'CoolBookFromAnotherEditorialThatStinks!!').
		self assert: error messageText equals: Editorial NotMyBookNotMyMonkeys.
		]
	! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/2/2023 14:45:21'!
test05Adding2CopiesMakesCartHold2Copies
	| cart Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: 'OurOwnCoolBooks').
	cart := Cart fromEditorial: Billiken.
	cart add: 2 copiesOf: 'OurOwnCoolBooks'.
	self assert: ((cart listContents occurrencesOf: 'OurOwnCoolBooks') = 2).! !

!TestCart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/2/2023 14:45:13'!
test06CannotAddZeroOrNegativeBooks
	| cart Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: 'OurOwnCoolBooks').
	cart := Cart fromEditorial: Billiken.
	self should: [ cart add: -1 copiesOf: 'OurOwnCoolBooks'. ]
	raise: Error
	withExceptionDo: [ :error |
		self deny: ((cart listContents) includes: 'OurOwnCoolBooks').
		self assert: error messageText equals: Cart InvalidAmount.
		]! !


!classDefinition: #TestEditorial category: 'TiendaDeLibros'!
TestCase subclass: #TestEditorial
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!TestEditorial methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 19:48:49'!
test01CreateEditorialWithOneBook
	| Billiken |
	Billiken := Editorial createWith: (OrderedCollection with: '01001010101092093').
	self assert: (Billiken hasBook: '01001010101092093').
	! !

!TestEditorial methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 19:50:35'!
test02CreateEditorialWithMoreThanOneBook
	| Billiken bookList |
	bookList := OrderedCollection with: '01001010101092093' with: '10101' with: '23450'.
	Billiken := Editorial createWith: (bookList ).
	self assert: (Billiken hasBook: '01001010101092093').
	self assert: (Billiken hasBook: '10101').
	self assert: (Billiken hasBook: '23450').
	! !


!classDefinition: #Cart category: 'TiendaDeLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents editorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/2/2023 14:42:19'!
add: aQuantity copiesOf: aBookISBN
	((editorial hasBook: aBookISBN) and: (self amountIsStrictlyPositive: aQuantity)) 
	ifTrue:
		[ contents add: aBookISBN withOccurrences: aQuantity]
		ifFalse:
		[^self error: Editorial NotMyBookNotMyMonkeys]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 20:05:39'!
addBook: aBookISBN
	(editorial hasBook: aBookISBN ) ifTrue: [ contents add: aBookISBN.].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JGFS 11/2/2023 14:43:19'!
amountIsStrictlyPositive: aQuantity
	aQuantity > 0 ifTrue: [^true]
				ifFalse:[^self error: Cart InvalidAmount]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JGFS 10/30/2023 19:55:57'!
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

!Cart class methodsFor: 'instance creation' stamp: 'JGFS 10/30/2023 20:02:20'!
fromEditorial: anEditorial
	^self new with: anEditorial .! !


!classDefinition: #Editorial category: 'TiendaDeLibros'!
Object subclass: #Editorial
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TiendaDeLibros'!

!Editorial methodsFor: 'inspecting' stamp: 'JGFS 10/30/2023 19:46:16'!
hasBook: aBookISBN
	^collection includes: aBookISBN.! !


!Editorial methodsFor: 'initialization' stamp: 'JGFS 10/30/2023 19:44:23'!
with: aBookCollection
	collection := aBookCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Editorial class' category: 'TiendaDeLibros'!
Editorial class
	instanceVariableNames: ''!

!Editorial class methodsFor: 'error handling' stamp: 'JGFS 10/30/2023 20:27:08'!
NotMyBookNotMyMonkeys
	^'Not my book'.! !


!Editorial class methodsFor: 'instance creation' stamp: 'JGFS 10/30/2023 19:44:38'!
createWith: aBookCollection
	^self new with: aBookCollection.! !
