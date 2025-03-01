!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'consultasSobreStack' stamp: 'JG 9/18/2023 16:09:00'!
this: stack isEqualTo: otherStack 
	|element elementCopy|
	[stack isEmpty not] whileTrue: [
	    element := stack pop.
	    elementCopy := otherStack pop.
	    self assert: element = elementCopy
	    ].! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JG 9/17/2023 19:23:59'!
test01EmptyStackShouldNotHaveMatches

	| stack prefix elementsWithPrefix |
	
	stack := OOStack new.
	prefix := 'hola'.
	elementsWithPrefix := 	SentenceFinderByPrefix new find: prefix in: stack.
	self assert: (elementsWithPrefix isEmpty).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JG 9/18/2023 11:44:19'!
test02MatchingStringsWithSpaceAndMixedCasesPrefixes

	| stack prefix elementsWithPrefix expectedCollection holaCalamardo holaBobEsponja HolaCangreburger|
	holaCalamardo := 'hola calamardo'.
	holaBobEsponja := 'hola bobEsponja'.
	HolaCangreburger :='Hola se roban la cangreburger :('.
	stack := OOStack new.
	prefix := 'hola'.
	stack push: holaCalamardo. 
	stack push: holaBobEsponja.
	stack push: HolaCangreburger. 
	expectedCollection := OrderedCollection new.
	expectedCollection add: holaCalamardo ; add: holaBobEsponja.
	elementsWithPrefix := 	SentenceFinderByPrefix new find: prefix in: stack.
	self assert: expectedCollection = elementsWithPrefix .
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JG 9/18/2023 12:20:44'!
test03StringsWithDifferentCasesShouldNotMatch

	| stack prefix elementsWithPrefix expectedCollection holaCalamardo HolaCangreburger|
	holaCalamardo := 'hola calamardo'.
	HolaCangreburger :='Hola se roban la cangreburger :('.
	
	stack := OOStack new.
	prefix := 'hola'.
	stack push: holaCalamardo. 
	stack push: HolaCangreburger. 
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: holaCalamardo; add: HolaCangreburger .
	elementsWithPrefix := 	SentenceFinderByPrefix new find: prefix in: stack.
	self assert: (expectedCollection = elementsWithPrefix) not.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JG 9/18/2023 16:10:25'!
test04TestDoesNotModifyStack

	| stack prefix elementsWithPrefix expectedCollection holaCalamardo HolaCangreburger stackCopy stackSize |
	holaCalamardo := 'hola calamardo'.
	HolaCangreburger := 'Hola se roban la cangreburger :('.
	
	stack := OOStack new.
	prefix := 'hola'.
	stack push: holaCalamardo. 
	stack push: HolaCangreburger.
	
	stackSize := stack size.
	
	stackCopy := OOStack new.
	stackCopy push: holaCalamardo.
	stackCopy push: HolaCangreburger .
	expectedCollection := OrderedCollection new.
	expectedCollection add: holaCalamardo.
	elementsWithPrefix := 	SentenceFinderByPrefix new find: prefix in: stack.
	self this: stack isEqualTo:stackCopy.
	self assert: (stackSize = (stackCopy size)).
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'JG 9/18/2023 16:46:22'!
test05EmptyPrefixShouldThrowError
	| stack prefix elementsWithPrefix holaCalamardo HolaCangreburger |
	holaCalamardo := 'hola calamardo'.
	HolaCangreburger := 'Hola se roban la cangreburger :('.
	
	stack := OOStack new.
	prefix := ''.
	stack push: holaCalamardo. 
	stack push: HolaCangreburger.
	self 
		should: [		elementsWithPrefix := 	SentenceFinderByPrefix new find: prefix in: stack.
				(elementsWithPrefix find: '') = OrderedCollection new. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 
			SentenceFinderByPrefix prefixCannotBeEmptyError ]
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'JS 9/17/2023 16:06:17'!
initialize
	^BaseDelStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #BaseDelStack category: 'Stack-Exercise'!
OOStack subclass: #BaseDelStack
	instanceVariableNames: 'next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 16:08:25'!
isEmpty
	^next isEmpty! !

!BaseDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 17:37:36'!
size
	^next size.! !


!BaseDelStack methodsFor: 'initialization' stamp: 'JS 9/17/2023 16:10:22'!
initialize
	next := TopeDelStack new.! !


!BaseDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 16:38:45'!
cambiarSiguiente: nuevoSiguiente
	next := nuevoSiguiente.! !

!BaseDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:52:30'!
devolvete
	^OOStack error: 	OOStack stackEmptyErrorDescription ! !

!BaseDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:33:56'!
pop
	^next siSoyElUltimoPopeame: self.! !

!BaseDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:52:03'!
popeate
	^OOStack error: 	OOStack stackEmptyErrorDescription ! !

!BaseDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 16:28:02'!
push: unElemento
	next agrega: unElemento despuesDe: self.
	
	! !

!BaseDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:36:46'!
top
	^next siSoyElUltimoDevolveme: self.! !


!classDefinition: #ElementoDelStack category: 'Stack-Exercise'!
OOStack subclass: #ElementoDelStack
	instanceVariableNames: 'prev next valor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 16:39:52'!
agrega: unElemento despuesDe: esteElemento
	next agrega: unElemento despuesDe: self.! !

!ElementoDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 16:31:18'!
cambiarSiguiente: elSiguienteElemento
	next := elSiguienteElemento .! !

!ElementoDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:50:00'!
devolvete
	^valor.! !

!ElementoDelStack methodsFor: 'operacionesDeElementos' stamp: 'JG 9/17/2023 19:35:27'!
popeate
	prev cambiarSiguiente: next.
	^self devolvete.! !

!ElementoDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:34:42'!
siSoyElUltimoPopeame: anterior.
	^next siSoyElUltimoPopeame: self.! !


!ElementoDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 16:32:25'!
isEmpty
	^false.! !

!ElementoDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 17:36:04'!
siSoyElUltimoDevolveme: anterior.	
	^next siSoyElUltimoDevolveme: self.! !

!ElementoDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 17:37:55'!
size
	^next size + 1.! !


!ElementoDelStack methodsFor: 'initialization' stamp: 'JS 9/17/2023 16:31:46'!
initialize! !

!ElementoDelStack methodsFor: 'initialization' stamp: 'JS 9/17/2023 16:44:10'!
initializeContiene: Elemento antesDe: elSiguiente.
	valor := Elemento.
	next := elSiguiente.! !

!ElementoDelStack methodsFor: 'initialization' stamp: 'JS 9/17/2023 17:25:50'!
initializeContiene: Elemento antesDe: elSiguiente despuesDe: elAnterior.
	valor := Elemento.
	next := elSiguiente.
	prev := elAnterior.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementoDelStack class' category: 'Stack-Exercise'!
ElementoDelStack class
	instanceVariableNames: 'nuevoElemento_CHANGE_ME'!

!ElementoDelStack class methodsFor: 'class initialization' stamp: 'JS 9/17/2023 16:44:56'!
contiene: elemento antesDe: elSiguiente
	^self new initializeContiene: elemento antesDe: elSiguiente .
	! !

!ElementoDelStack class methodsFor: 'class initialization' stamp: 'JS 9/17/2023 17:26:11'!
contiene: elemento antesDe: elSiguiente despuesDe: elAnterior
	^self new initializeContiene: elemento antesDe: elSiguiente despuesDe: elAnterior.
	! !


!classDefinition: #TopeDelStack category: 'Stack-Exercise'!
OOStack subclass: #TopeDelStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!TopeDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 16:09:44'!
isEmpty
	^true! !

!TopeDelStack methodsFor: 'consultasEstadoDelStack' stamp: 'JS 9/17/2023 17:38:04'!
size
	^0.! !


!TopeDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:27:05'!
agrega: nuevoElemento despuesDe: esteElemento
	| StackContenedorDelNuevoElemento |
	StackContenedorDelNuevoElemento  := ElementoDelStack contiene: nuevoElemento antesDe: self despuesDe: esteElemento.
	esteElemento cambiarSiguiente: StackContenedorDelNuevoElemento.! !

!TopeDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:48:50'!
siSoyElUltimoDevolveme: anterior.	
	^anterior devolvete.
	! !

!TopeDelStack methodsFor: 'operacionesDeElementos' stamp: 'JS 9/17/2023 17:47:26'!
siSoyElUltimoPopeame: elementoAnterior.
	^elementoAnterior popeate.
	! !


!TopeDelStack methodsFor: 'initialization' stamp: 'JS 9/17/2023 16:08:58'!
initialize! !


!classDefinition: #OracionPrefijada category: 'Stack-Exercise'!
Object subclass: #OracionPrefijada
	instanceVariableNames: 'oracion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OracionPrefijada methodsFor: 'initialization' stamp: 'FS 9/18/2023 13:56:38'!
initializeOracion: unaOracion
	self subclassResponsibility .! !


!OracionPrefijada methodsFor: 'operacionesSobreColecciones' stamp: 'FS 9/18/2023 13:54:31'!
siEstasPrefijadaAgregateA: unaColeccion.
	self subclassResponsibility .
	"unaColeccion addFirst: self."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OracionPrefijada class' category: 'Stack-Exercise'!
OracionPrefijada class
	instanceVariableNames: ''!

!OracionPrefijada class methodsFor: 'instance creation' stamp: 'FS 9/18/2023 14:03:58'!
oracion: oracion conPrefijo: prefijo
	((oracion findString: prefijo) = 1) ifTrue: [ ^OracionPrefijadaValida new initializeOracion: oracion.].
	((oracion findString: prefijo) = 1) ifFalse: [ ^OracionPrefijadaNoValida new]! !


!classDefinition: #OracionPrefijadaNoValida category: 'Stack-Exercise'!
OracionPrefijada subclass: #OracionPrefijadaNoValida
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OracionPrefijadaNoValida methodsFor: 'informacionSobreLaOracion' stamp: 'FS 9/18/2023 14:09:23'!
estaPrefijada
	^false.! !


!OracionPrefijadaNoValida methodsFor: 'operacionesSobreColecciones' stamp: 'FS 9/18/2023 13:57:23'!
siEstasPrefijadaAgregateA: unaColeccion.
	! !


!OracionPrefijadaNoValida methodsFor: 'initialization' stamp: 'FS 9/18/2023 14:10:17'!
initializeOracion: unaOracion
	oracion := unaOracion.! !


!classDefinition: #OracionPrefijadaValida category: 'Stack-Exercise'!
OracionPrefijada subclass: #OracionPrefijadaValida
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OracionPrefijadaValida methodsFor: 'initialization' stamp: 'FS 9/18/2023 13:56:23'!
initializeOracion: unaOracion
	oracion := unaOracion.! !


!OracionPrefijadaValida methodsFor: 'operacionesSobreColecciones' stamp: 'FS 9/18/2023 14:05:06'!
siEstasPrefijadaAgregateA: unaColeccion.
	unaColeccion addFirst: oracion.! !


!OracionPrefijadaValida methodsFor: 'informacionSobreLaOracion' stamp: 'FS 9/18/2023 14:09:40'!
estaPrefijada
	^true.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'ConsultasSobreStacks' stamp: 'JG 9/18/2023 16:57:07'!
find: Prefix in: Stack
	|element elementosConPrefijoPrefix oracionesYaAnalizadas |
	self checkNotEmpty: Prefix.
	
	elementosConPrefijoPrefix := OrderedCollection new.
	oracionesYaAnalizadas := OOStack new.
	[Stack isEmpty not] whileTrue: [
		element := Stack pop.
		(OracionPrefijada oracion: element conPrefijo: Prefix) siEstasPrefijadaAgregateA: elementosConPrefijoPrefix .
		oracionesYaAnalizadas push: element.
		].
	self reverseStack: oracionesYaAnalizadas.
	^elementosConPrefijoPrefix ! !


!SentenceFinderByPrefix methodsFor: 'OperacionesSobreStacks' stamp: 'JG 9/18/2023 12:18:39'!
reverseStack: Stack
	|element reverseOrderStack|
	reverseOrderStack := OOStack new.
	[Stack size > 0] whileTrue: [
		element := Stack pop.
		reverseOrderStack push: element.
	].
	^reverseOrderStack ! !


!SentenceFinderByPrefix methodsFor: 'ConsultasSobreElementos' stamp: 'JG 9/18/2023 16:48:47'!
checkNotEmpty: Prefix
	^Prefix isEmpty ifTrue:[self error: self class prefixCannotBeEmptyError]
				
	! !

!SentenceFinderByPrefix methodsFor: 'ConsultasSobreElementos' stamp: 'JG 9/17/2023 19:10:06'!
esPrefijo: Prefix de:element
		^(element findString: Prefix) = 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'JG 9/18/2023 16:25:37'!
prefixCannotBeEmptyError
	^'Prefix cannot be empty!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'JG 9/18/2023 16:51:28'!
prefixCannotHaveSpacesError
	^'Prefix cannot have spaces!!!!'! !
