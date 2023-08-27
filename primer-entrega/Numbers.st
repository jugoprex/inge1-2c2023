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

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:47:16'!
+ unNumero
	^unNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:49:22'!
next
	next ifNotNil: [^next].
	next := self cloneNamed:self name, 'I'.
	next previous: self.
	^next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:49:54'!
restateA: unNumero
	^unNumero previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:50:12'!
x: unNumero
	^unNumero.! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/27/2023 18:01:05'!
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
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:52:10'!
+unNumero
	^(self previous + unNumero next)! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:52:42'!
- unNumero
	^unNumero  restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:53:28'!
next
	next ifNotNil:[^next].
	next := self cloneNamed:self name, 'I'.
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

!II class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:55:14'!
x: unNumero
	^(self previous x: unNumero) + unNumero! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/27/2023 18:01:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numbers'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numbers'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
+unNumero
	^(self previous + unNumero next)! !

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
- unNumero
	^unNumero  restateA: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
next
	next ifNotNil:[^next].
	next := self cloneNamed:self name, 'I'.
	next previous: self.
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
previous: Numero
	previous := Numero! !

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
restateA: unNumero
	^unNumero previous - self previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:57:55'!
x: unNumero
	^(self previous x: unNumero) + unNumero! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/27/2023 18:01:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numbers'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numbers'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
+unNumero
	^(self previous + unNumero next)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
- unNumero
	^unNumero  restateA: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
next
	next ifNotNil:[^next].
	next := self cloneNamed:self name, 'I'.
	next previous: self.
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
previous: Numero
	previous := Numero! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
restateA: unNumero
	^unNumero previous - self previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JG 8/27/2023 17:58:06'!
x: unNumero
	^(self previous x: unNumero) + unNumero! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'JG 8/27/2023 18:01:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!