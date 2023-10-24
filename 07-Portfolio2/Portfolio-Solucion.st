!classDefinition: #AccountTransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransferTest methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 19:18:20'!
test01MoneyIsTransferredFromAccountToAnother

	| account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer amount: 100 from: account1  to: account2.

	self assert: account1 balance equals: -100.
	self assert: account2 balance equals: 100! !

!AccountTransferTest methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 19:22:22'!
test02CannotSendMoneyToYourself

	| account1 |
	
	account1 := ReceptiveAccount new.
	self 
		should: [ Transfer amount: 100 from: account1  to: account1.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Transfer cannotSelfTransfer equals: anError messageText.]
! !

!AccountTransferTest methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 19:22:26'!
test03TransferAmountMustBePositive

	| account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	self 
		should: [ Transfer amount: 0 from: account1  to: account2.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferInvalidAmounts equals: anError messageText.]
! !

!AccountTransferTest methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 20:16:29'!
test04TransactionRegisteredNoDuplicateInformation

	| account1 account2 transfer|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transfer := Transfer amount: 100 from: account1  to: account2.

	self assert: (account1 hasRegistered: (transfer outwardTransfer)) equals: true.
	self assert: (account1 hasRegistered: (transfer inboundTransfer)) equals: false.
	self assert: (account2 hasRegistered: (transfer outwardTransfer)) equals: false.
	self assert: (account2 hasRegistered: (transfer inboundTransfer)) equals: true.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JG 10/24/2023 20:55:49'!
test01reportOfEmptyAccountIsEmpty
	self assert: ((Report from: (ReceptiveAccount new)) toString) = (OrderedCollection with: 'Balance = 0.').! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JG 10/24/2023 19:28:08'!
test02reportOfNonEmptyAccountPrintsTransactionsCorrectly
	|account report finalReport|
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on:account.
	report := Report from: account.
	finalReport := OrderedCollection new.
	finalReport addLast: 'Depósito por 100.'.
	finalReport addLast: 'Extracción por 50.'.
	finalReport addLast: 'Balance = 50.'.
	
	
	self assert: (report toString = finalReport)! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'JG 10/24/2023 19:30:36'!
test03reportOfNonEmptyAccountPrintsTransfersCorrectly
	|account1 account2 report1 finalReport1 report2 finalReport2|
	account1 := ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Transfer amount: 100 from:account1  to: account2.
	report1 := Report from: account1.
	report2 := Report from: account2.
	finalReport1 := OrderedCollection new.
	finalReport1 addLast: 'Salida por transferencia de 100.' .
	finalReport1 addLast: 'Balance = -100.'.
	finalReport2 := OrderedCollection new.
	finalReport2 addLast: 'Entrada por transferencia de 100.' .
	finalReport2 addLast: 'Balance = 100.'.
	
	self assert: (report1 toString = finalReport1 ).
	self assert: (report2 toString = finalReport2).
	
	
	
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'errors' stamp: 'JG 10/19/2023 21:28:12'!
cannotSelfTransfer
	^'Cannot make transfers to oneself'! !

!Account class methodsFor: 'errors' stamp: 'JG 10/21/2023 19:06:22'!
cannotTransferInvalidAmounts
	^'Cannot make transfers of invalid amounts'! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'testing' stamp: 'JG 10/23/2023 21:11:27'!
report
	"^accounts do: [:account | account report]"! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'JG 10/24/2023 20:54:41'!
report
	| cummulative | 
	cummulative := OrderedCollection new.
	"high risk transaction"
	transactions do: [ :hrt | cummulative addLast: (hrt report) ].
	cummulative addLast: ('Balance = ', (self balance) asString, '.').
	^cummulative.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'JG 10/21/2023 19:09:10'!
transfer: anAmount to: anAccount
	self = anAccount ifTrue: [^self error: Account cannotSelfTransfer ].
	anAmount <= 0 ifTrue: [^self error: Account cannotTransferInvalidAmounts ].
	Withdraw register: anAmount on: self.
	Deposit register: anAmount on: anAccount .! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'JG 10/23/2023 21:17:12'!
printTransaction
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'printing' stamp: 'JG 10/24/2023 18:53:58'!
report
	^'Depósito por ' , value asString, '.'.! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:36:36'!
for: aValue
	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'printing' stamp: 'JG 10/24/2023 18:56:17'!
report
	^'Extracción por ' , value asString, '.'.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTransfer category: 'Portfolio-Solucion'!
Object subclass: #AccountTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransfer methodsFor: 'value' stamp: 'JG 10/21/2023 19:41:16'!
value 

	self subclassResponsibility ! !


!AccountTransfer methodsFor: 'balance' stamp: 'JG 10/21/2023 19:41:16'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransfer class' category: 'Portfolio-Solucion'!
AccountTransfer class
	instanceVariableNames: ''!

!AccountTransfer class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:52:20'!
outgoing: aValue by: sender registeredOn: transferRegister

	| transaction |
	
	transaction := self for: aValue registeredOn: transferRegister.
	sender register: transaction.
		
	^ transaction! !

!AccountTransfer class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:46:48'!
outgoing: aValue on: sender towards: recipient

	| transaction |
	
	"transaction := self for: aValue towards: ."
	sender register: transaction.
		
	^ transaction! !

!AccountTransfer class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:41:16'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferInto category: 'Portfolio-Solucion'!
AccountTransfer subclass: #TransferInto
	instanceVariableNames: 'value sender transferRegistry'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferInto methodsFor: 'initialization' stamp: 'JG 10/21/2023 19:39:51'!
initializeFor: aValue
	value := aValue ! !

!TransferInto methodsFor: 'initialization' stamp: 'JG 10/21/2023 19:53:47'!
initializeFor: aValue on: transferRegister
	transferRegistry := transferRegister.
	value := aValue ! !


!TransferInto methodsFor: 'value' stamp: 'JG 10/21/2023 19:38:44'!
value

	^ value! !


!TransferInto methodsFor: 'printing' stamp: 'JG 10/24/2023 19:22:29'!
report
	^'Entrada por transferencia de ' , value asString, '.'.! !

!TransferInto methodsFor: 'printing' stamp: 'JG 10/23/2023 21:48:34'!
report: Reporter
	Reporter inboundTransaction: self.! !


!TransferInto methodsFor: 'balance' stamp: 'JG 10/21/2023 19:38:44'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferInto class' category: 'Portfolio-Solucion'!
TransferInto class
	instanceVariableNames: 'transferRegistry'!

!TransferInto class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:38:44'!
for: aValue
	^ self new initializeFor: aValue ! !

!TransferInto class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:53:32'!
for: aValue registeredOn: transferRegister
	
	^ self new initializeFor: aValue on: transferRegister.! !


!classDefinition: #TransferOut category: 'Portfolio-Solucion'!
AccountTransfer subclass: #TransferOut
	instanceVariableNames: 'value reciever transferRegistry'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferOut methodsFor: 'initialization' stamp: 'JG 10/21/2023 19:38:59'!
initializeFor: aValue

	value := aValue ! !

!TransferOut methodsFor: 'initialization' stamp: 'JG 10/21/2023 19:55:18'!
initializeFor: aValue on: transferRegister
	transferRegistry := transferRegister.
	value := aValue ! !


!TransferOut methodsFor: 'value' stamp: 'JG 10/21/2023 19:38:59'!
value

	^ value! !


!TransferOut methodsFor: 'printing' stamp: 'JG 10/24/2023 19:20:14'!
report
	^'Salida por transferencia de ' , value asString, '.'.! !


!TransferOut methodsFor: 'balance' stamp: 'JG 10/21/2023 19:38:59'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOut class' category: 'Portfolio-Solucion'!
TransferOut class
	instanceVariableNames: ''!

!TransferOut class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:38:59'!
for: aValue

	^ self new initializeFor: aValue ! !

!TransferOut class methodsFor: 'instance creation' stamp: 'JG 10/21/2023 19:54:32'!
for: aValue registeredOn: transferRegister

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'accountToReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'JG 10/23/2023 21:37:54'!
initializeFrom: anAccount 
	accountToReport := anAccount.! !


!Report methodsFor: 'printing' stamp: 'JG 10/23/2023 21:51:19'!
Deposit: transaction
	^ 'Deposito por ' ,transaction value asString,'.'! !

!Report methodsFor: 'printing' stamp: 'JG 10/23/2023 21:43:10'!
Withdraw: transaction! !

!Report methodsFor: 'printing' stamp: 'JG 10/23/2023 21:43:25'!
inboundTransaction: transaction! !

!Report methodsFor: 'printing' stamp: 'JG 10/23/2023 21:43:29'!
outwardTransaction: transaction! !


!Report methodsFor: 'inspecting' stamp: 'JG 10/24/2023 18:49:51'!
toString
	 ^accountToReport  report
	"AHH okay mira le pasas al objeto el ReportGenerator y ellos te devuelven los mensajes :)"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'JG 10/23/2023 21:34:20'!
from: account 
	^self new initializeFrom: account! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 20:08:05'!
amount: money from: sender to: recipient
	sender = recipient ifTrue: [^self error: Account cannotSelfTransfer ].
	money <= 0 ifTrue: [^self error: Account cannotTransferInvalidAmounts ].
	to := TransferInto register: money on: recipient.
	from := TransferOut register: money on: sender.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 20:07:52'!
inboundTransfer
	^to
! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'JG 10/21/2023 20:07:41'!
outwardTransfer
	^from
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'JG 10/21/2023 19:14:59'!
amount: money  from: senderAccount to: recipientAccount
	^ self new amount: money from: senderAccount  to: recipientAccount ! !


!Transfer class methodsFor: 'errors' stamp: 'JG 10/21/2023 19:21:58'!
cannotSelfTransfer
	^'Cannot make transfers to oneself'! !

!Transfer class methodsFor: 'errors' stamp: 'JG 10/21/2023 19:22:02'!
cannotTransferInvalidAmounts
	^'Cannot make transfers of invalid amounts'! !
