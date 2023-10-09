!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:31'!
test01marsRoverSiRecibeMensajeVacíoNoSeMueve
	|marsRover ubicaciónInicial direcciónInicial |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: ''.
	"feature envy: es mejor preguntar 'estas aca' que decir 'dame tu ubicación y la comparo'"
	self assert: (marsRover estasEn: ubicaciónInicial conDireccion: direcciónInicial).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:26'!
test02marsRoverSeMueve1ParaAdelante
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	ubicaciónFinal := ubicaciónInicial + (1@0).

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'f'.
	self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónInicial).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:21'!
test03marsRoverSeMueve1ParaAtras
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	ubicaciónFinal := ubicaciónInicial - (1@0).

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'b'.
	self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónInicial).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:13'!
test04marsRoverGiraALaDerecha
	|marsRover ubicaciónInicial direcciónInicial direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	direcciónFinal := #este.

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'r'.
	self assert: (marsRover estasEn: ubicaciónInicial conDireccion: direcciónFinal).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:10'!
test05marsRoverGiraALaIzquierda
	|marsRover ubicaciónInicial direcciónInicial direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	direcciónFinal := #oeste.

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'l'.
	self assert: (marsRover estasEn: ubicaciónInicial conDireccion: direcciónFinal).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:42'!
test06marsRoverGiraALaIzquierdaDosVeces
	|marsRover ubicaciónInicial direcciónInicial direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	direcciónFinal := #sur.

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'l'.
	marsRover recibeMensaje: 'l'.
	self assert: (marsRover estasEn: ubicaciónInicial conDireccion: direcciónFinal).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:09:51'!
test07marsRoverGiraALaDerechaDosVeces
	|marsRover ubicaciónInicial direcciónInicial direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	direcciónFinal := #sur.

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'r'.
	marsRover recibeMensaje: 'r'.
	self assert: (marsRover estasEn: ubicaciónInicial conDireccion: direcciónFinal).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:10:00'!
test08marsRoverGiraALaDerechaTresVeces
	|marsRover ubicaciónInicial direcciónInicial direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	direcciónInicial := #norte.
	direcciónFinal := #oeste.

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'r'.
	marsRover recibeMensaje: 'r'.
	marsRover recibeMensaje: 'r'.
	self assert: (marsRover estasEn: ubicaciónInicial conDireccion: direcciónFinal).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:10:07'!
test09marsRoverSeMueve2ParaAdelante
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal|
	ubicaciónInicial := 1 @ 1.
	ubicaciónFinal := 3 @ 1.
	direcciónInicial := #norte.
	

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'f'.
	marsRover recibeMensaje: 'f'.
	self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónInicial ).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:10:18'!
test10marsRoverSeMueve2ParaAdelanteEnMismoMensaje
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal|
	ubicaciónInicial := 1 @ 1.
	ubicaciónFinal := 3 @ 1.
	direcciónInicial := #norte.
	

	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'ff'.
	self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónInicial ).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:10:25'!
test11marsRoverSeMueveParaLaDerechaYParaAdelante
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	ubicaciónFinal := 1 @ 2.
	direcciónInicial := #norte.
	direcciónFinal := #este.
	
	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	
	marsRover recibeMensaje: 'rf'.
	self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónFinal ).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:10:30'!
test12marsRoverSeMueveHastaQueLlegaUnCaracterInválido
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	ubicaciónFinal := 1 @ 3.
	direcciónInicial := #norte.
	direcciónFinal := #este.
	
	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	self 
		should: [marsRover recibeMensaje: 'frfflbra'.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: MarsRover errorCaracterInválido equals: error messageText.
			self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónFinal ).]! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JG 10/9/2023 15:10:35'!
test13marsRoverSeMueveHastaQueLlegaUnCaracterInválidoYElRestoLoIgnora
	|marsRover ubicaciónInicial direcciónInicial ubicaciónFinal direcciónFinal |
	ubicaciónInicial := 1 @ 1.
	ubicaciónFinal := 1 @ 3.
	direcciónInicial := #norte.
	direcciónFinal := #norte.
	
	marsRover := MarsRover aterrizaEn: ubicaciónInicial conDireccion: direcciónInicial.
	self 
		should: [marsRover recibeMensaje: 'frfflbarrlrlrlrlr'.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: MarsRover errorCaracterInválido equals: error messageText.
			self assert: (marsRover estasEn: ubicaciónFinal conDireccion: direcciónFinal ).]
	! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'ubicacion direccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'JG 10/5/2023 20:42:57'!
aterrizaEn: ubicacionInicial conDireccion: unPuntoCardinal 
	ubicacion :=  ubicacionInicial.
	direccion := unPuntoCardinal .
	! !


!MarsRover methodsFor: 'comunicacion' stamp: 'JG 10/9/2023 14:50:52'!
recibeMensaje: mensaje
	mensaje size = 1 ifTrue:[
			(mensaje = 'f' or: mensaje = 'b') ifTrue: [self actualizoMiPosicion: mensaje] 
									ifFalse:[
			(mensaje = 'r' or: mensaje = 'l')  ifTrue: [self actualizoMiDireccion: mensaje]
								ifFalse: [^self error: MarsRover errorCaracterInválido ]]]
				ifFalse:[
			mensaje do: [:char | self recibeMensaje: char asString]]! !


!MarsRover methodsFor: 'preguntas' stamp: 'JG 10/9/2023 14:24:12'!
actualizoMiDireccion: Direccion 
		     direccion = #norte ifTrue: [
			Direccion = 'l' ifTrue: [				direccion := #oeste			].
			Direccion = 'r' ifTrue: [direccion := #este].
			]
	ifFalse: [	direccion = #oeste ifTrue: [
			Direccion = 'l' ifTrue: [				direccion := #sur			].
			Direccion = 'r' ifTrue: [direccion := #norte].
			]
	ifFalse: [direccion = #este ifTrue:[
			Direccion = 'l' ifTrue: [				direccion := #norte			].
			Direccion = 'r' ifTrue: [direccion := #sur].
			]
	ifFalse: [direccion = #sur ifTrue:[
			Direccion = 'l' ifTrue: [				direccion := #este			].
			Direccion = 'r' ifTrue: [direccion := #oeste].
			]
								]]]! !

!MarsRover methodsFor: 'preguntas' stamp: 'JG 10/9/2023 14:23:56'!
actualizoMiPosicion: Movimiento
direccion = #norte ifTrue: [
			Movimiento = 'f' ifTrue: [				ubicacion := ubicacion + (1@0)		].
			Movimiento = 'b' ifTrue: [				ubicacion := ubicacion - (1@0)].
			]
	ifFalse: [	direccion = #oeste ifTrue: [
			Movimiento = 'f' ifTrue: [				ubicacion := ubicacion - (0@1	)	].
			Movimiento = 'b' ifTrue: [				ubicacion := ubicacion + (0@1	)		].
			]
	ifFalse: [direccion = #este ifTrue:[
			Movimiento = 'f' ifTrue: [				ubicacion := ubicacion + (0@1	)		].
			Movimiento = 'b' ifTrue: [				ubicacion := ubicacion - (0@1	)	].
			]
	ifFalse: [direccion = #sur ifTrue:[
			Movimiento = 'f' ifTrue: [				ubicacion := ubicacion - (1@0)		].
			Movimiento = 'b' ifTrue: [				ubicacion := ubicacion + (1@0)	].
			]
								]]]
	! !

!MarsRover methodsFor: 'preguntas' stamp: 'JG 10/5/2023 21:05:44'!
estasEn: ubicaciónInicial conDireccion: direcciónInicial 
	^((ubicacion = ubicaciónInicial)  and: (direccion = direcciónInicial ))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JG 10/5/2023 20:43:09'!
aterrizaEn: ubicacionInicial conDireccion: unPuntoCardinal 
	^self new aterrizaEn: ubicacionInicial  conDireccion: unPuntoCardinal.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'JG 10/9/2023 14:38:21'!
errorCaracterInválido
	^'El caracter enviado es inválido'.! !
