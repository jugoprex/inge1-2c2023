!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'JG 10/27/2023 16:38:05'!
initializeAt: aPosition heading: aHeadingType

	position := Publisher from: aPosition.
	head := Publisher from: (aHeadingType for: self)! !


!MarsRover methodsFor: 'heading' stamp: 'JG 10/27/2023 16:38:34'!
headEast
	
	head change: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JG 10/27/2023 16:38:45'!
headNorth
	
	head change: (MarsRoverHeadingNorth for: self ).! !

!MarsRover methodsFor: 'heading' stamp: 'JG 10/27/2023 16:38:57'!
headSouth
	
	head change: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'JG 10/27/2023 16:39:06'!
headWest
	
	head change: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'JG 10/30/2023 16:56:21'!
moveEast
	
	position change: (position + (1@0))! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'JG 10/30/2023 15:38:46'!
moveNorth	
	position change: (position + (0@1))! !

!MarsRover methodsFor: 'moving' stamp: 'JG 10/30/2023 16:55:58'!
moveSouth
	
	position change: (position + (0@-1))! !

!MarsRover methodsFor: 'moving' stamp: 'JG 10/30/2023 16:56:07'!
moveWest
	
	position change: (position + (-1@0))! !

!MarsRover methodsFor: 'moving' stamp: 'JG 10/30/2023 12:42:09'!
updateAndLogPosition: newPosition
	
	position change: position + newPosition.! !


!MarsRover methodsFor: 'command processing' stamp: 'JG 10/30/2023 16:08:43'!
addHeadSubscriber: aSubscriber
	head addSubscriber: aSubscriber.! !

!MarsRover methodsFor: 'command processing' stamp: 'JG 10/30/2023 11:54:04'!
addPositionSubscriber: aSubscriber
	position addSubscriber: aSubscriber.! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'JG 10/30/2023 16:18:37'!
toString

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'JG 10/30/2023 16:19:02'!
toString
	^'Este'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'JG 10/30/2023 16:19:23'!
toString
	^'Norte'! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'JG 10/30/2023 16:20:13'!
toString
	^'Sur'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'JG 10/30/2023 16:20:06'!
toString
	^'Oeste'! !


!classDefinition: #Publisher category: 'MarsRover-WithHeading'!
Object subclass: #Publisher
	instanceVariableNames: 'data subscribers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Publisher methodsFor: 'binding' stamp: 'JG 10/30/2023 11:55:45'!
addSubscriber: aSubscriber 
	subscribers add: aSubscriber.! !

!Publisher methodsFor: 'binding' stamp: 'JG 10/27/2023 16:36:00'!
change: someNewData
	data := someNewData.
	self notify.! !

!Publisher methodsFor: 'binding' stamp: 'JG 10/30/2023 12:55:05'!
doesNotUnderstand: aMessage 
	^aMessage sendTo: data! !

!Publisher methodsFor: 'binding' stamp: 'JG 10/30/2023 15:43:02'!
notify
	subscribers  do: [ :s | s value: data]! !

!Publisher methodsFor: 'binding' stamp: 'JG 10/27/2023 16:35:13'!
subscribe: Subscriber
	subscribers addLast: Subscriber.! !

!Publisher methodsFor: 'binding' stamp: 'JG 10/27/2023 16:57:49'!
value
	^data! !


!Publisher methodsFor: 'initialization' stamp: 'JG 10/27/2023 16:34:36'!
from: someData
	data := someData.
	subscribers := OrderedCollection  new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Publisher class' category: 'MarsRover-WithHeading'!
Publisher class
	instanceVariableNames: ''!

!Publisher class methodsFor: 'as yet unclassified' stamp: 'JG 10/27/2023 16:31:28'!
from: data
	^self new from: data! !
!classDefinition: #MarsRoverTest category: 'MarsRover-Testing'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Testing'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !
!classDefinition: #MarsRoverLogTest category: 'MarsRover-Logger'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logger'!

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 15:49:14'!
test01DoesNotLogWhenNoCommand
	|marsRover logger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToPositionOn: marsRover .
	
	marsRover process: ''.
	
	self assert: (OrderedCollection new) equals: logger printLogs.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 16:31:41'!
test02LogsCommandsOnPosition
	|marsRover logger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToPositionOn: marsRover .
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 0@1) equals: logger printLogs.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 16:03:59'!
test03LogsMultiplePositionCommandsOnPosition
	|marsRover logger logs|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToPositionOn: marsRover .
	logs := OrderedCollection new.
	logs addLast: 0@1.
	logs addLast: 0@2.
	marsRover process: 'ff'.
	
	self assert: (logs) equals: logger printLogs.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 16:09:41'!
test04DoesntLogForwardCommandOnHead
	|marsRover logger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToHeadOn: marsRover .
	
	marsRover process: 'ff'.
	
	self assert: (OrderedCollection new) equals: logger printLogs.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 16:22:21'!
test05LogsCommandsOnHead
	|marsRover logger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToHeadOn: marsRover .
	
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with:'Apuntando al Oeste') equals: logger printLogs.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 16:27:58'!
test06LogsMultipleCommandsOnHead
	|marsRover logger logs|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToHeadOn: marsRover .
	logs := OrderedCollection new.
	logs addLast: 'Apuntando al Oeste'.
	logs addLast: 'Apuntando al Sur'.
	marsRover process: 'lffl'.
	
	self assert: (logs) equals: logger printLogs.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'JG 10/30/2023 16:57:07'!
test07LogsCommandsOnHeadAndPosition
	|marsRover logger logs|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger subscribeToHeadAndPositionOn: marsRover .
	logs := OrderedCollection new.
	logs addLast: 'Apuntando al Este'.
	logs addLast: 1@0.
	logs addLast: 2@0.
	logs addLast: 'Apuntando al Sur'.
	marsRover process: 'rffr'.
	
	self assert: (logs) equals: logger printLogs.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-Logger'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Logger'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'JG 10/30/2023 16:48:46'!
initializeSubscribeToHeadAndPositionOn: aMarsRover
	logs := OrderedCollection new.
	aMarsRover addPositionSubscriber: [ :val | logs addLast: val].
	aMarsRover addHeadSubscriber: [ :val | logs addLast: 'Apuntando al ', (val toString)]! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'JG 10/30/2023 16:18:07'!
initializeSubscribeToHeadOn: aMarsRover
	logs := OrderedCollection new.
	aMarsRover addHeadSubscriber: [ :val | logs addLast: 'Apuntando al ', (val toString)]! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'JG 10/30/2023 15:48:40'!
initializeSubscribeToPositionOn: aMarsRover
	logs := OrderedCollection new.
	aMarsRover addPositionSubscriber: [ :val | logs addLast: val]! !


!MarsRoverLogger methodsFor: 'printing' stamp: 'JG 10/30/2023 13:08:00'!
changeInHeadingTo: Head
	logs addLast: 'wawawa'! !

!MarsRoverLogger methodsFor: 'printing' stamp: 'JG 10/30/2023 15:46:18'!
printLogs
	^logs! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-Logger'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'JG 10/30/2023 16:46:01'!
subscribeToHeadAndPositionOn: marsRover 
	^self new initializeSubscribeToHeadAndPositionOn: marsRover ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'JG 10/30/2023 16:02:43'!
subscribeToHeadOn: marsRover 
	^self new initializeSubscribeToHeadOn: marsRover ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'JG 10/30/2023 11:43:36'!
subscribeToPositionOn: marsRover 
	^self new initializeSubscribeToPositionOn: marsRover ! !
