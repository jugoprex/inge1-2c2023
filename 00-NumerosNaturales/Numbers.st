!classDefinition: #I category: 'Numbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numbers'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'FS 8/30/2023 19:43:13'!
* unNumero
	^unNumero.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:47:16'!
+ unNumero
	^unNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 18:15:08'!
- unNumero
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 18:19:19'!
/ unNumero
	(unNumero mayor: self)
	ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^ unNumero! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 18:19:30'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 18:15:30'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FS 8/30/2023 19:29:58'!
mayor: unNumero
	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:49:22'!
next
	next ifNotNil: [^next].
	next := self cloneNamed:self name, 'I'.
	next previous: self.
	^next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:49:54'!
restateA: unNumero
	^unNumero previous! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Numbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numbers'!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/30/2023 19:43:45'!
* unNumero
	^(self previous * unNumero) + unNumero! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:52:10'!
+unNumero
	^(self previous + unNumero next)! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:52:42'!
- unNumero
	^unNumero  restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 18:18:04'!
/ unNumero
	(unNumero mayor: self)
	ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	(self = unNumero)
	ifTrue: [^I].
	(unNumero mayor: self - unNumero)
	ifTrue: [^I].
	^((self - unNumero) / (unNumero)) next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 18:18:14'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/31/2023 17:29:31'!
mayor: unNumero
	unNumero = I
	ifTrue: [self = I ifFalse: [^true]	. ^false	].
	^(self - I mayor: unNumero - I)! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/29/2023 20:32:33'!
next
	next ifNotNil:[^next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:53:45'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:54:00'!
previous: Numero
	previous := Numero! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:54:53'!
restateA: unNumero
	^unNumero previous - self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !


!classDefinition: #III category: 'Numbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IIII.! !


!classDefinition: #IIII category: 'Numbers'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numbers'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := IIIII.! !


!classDefinition: #IIIII category: 'Numbers'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numbers'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIII.
	next := IIIIII.! !


!classDefinition: #IIIIII category: 'Numbers'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numbers'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIII.
	next := IIIIIII.! !


!classDefinition: #IIIIIII category: 'Numbers'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numbers'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIII.
	next := IIIIIIII.! !


!classDefinition: #IIIIIIII category: 'Numbers'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numbers'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIII.
	next := IIIIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numbers'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIII.
	next := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'Numbers'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIII.
	next := IIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'Numbers'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIII.
	next := IIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'Numbers'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIII.
	next := IIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: 'Numbers'!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIII.
	next := IIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: 'Numbers'!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIII.
	next := IIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: 'Numbers'!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIII class' category: 'Numbers'!
IIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/31/2023 18:20:25'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIII.
	next := nil.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIII initializeAfterFileIn!