"
Tests for ClientEnvironment
"
Class {
	#name : #CpClientEnvironmentTest,
	#superclass : #TestCase,
	#category : #'RemoteEnvironment-Tests'
}

{ #category : #tests }
CpClientEnvironmentTest >> testInstallClass [

	| clientEnvironment someClass |

	clientEnvironment := CpClientEnvironment current.
	self
		assert: (Smalltalk at: #CpTestClassToBeRemoved ifAbsent: [ nil ]) isNil
		description: 'Class not already present'.

	someClass := Object subclass: #CpTestClassToBeRemoved
		instanceVariableNames: 'instVar1 instVar2 instVar3'
		classVariableNames: 'classVar1 classVar2'
		package: self class category.

	[
		clientEnvironment handleMessageReceived: (MessageSend
			receiver: nil
			selector: #installClass:
			arguments: { someClass }) cpEncoded.

		self
			assert: (Smalltalk at: #CpTestClassToBeRemoved ifAbsent: [ nil ]) notNil
			description: 'Class is installed'.
		self
			assertCollection: (Smalltalk classNamed: #CpTestClassToBeRemoved) instVarNames
			equals: { #instVar1. #instVar2. #instVar3 }.
		self
			assertCollection: (Smalltalk classNamed: #CpTestClassToBeRemoved) classVarNames
			equals: {  #classVar1. #classVar2 } 
	] ensure: [ Smalltalk removeClassNamed: #CpTestClassToBeRemoved ]

]

{ #category : #tests }
CpClientEnvironmentTest >> testInstallMethod [

	| clientEnvironment someMethod |

	clientEnvironment := CpClientEnvironment current.
	self
		assert: (self class methodDict includesKey: #temporaryMethod) not
		description: 'Method not already present'.

	[
		"Compile new method for class, test it did not get installed"
		someMethod := self class compiler
			source: 'temporaryMethod ^ 42' ;
			requestor: nil ;
			failBlock: [ ^ nil ];
			compile.
		self assert: someMethod notNil description: 'Temporary method compiled'.
		self
			assert: (self class methodDict includesKey: #temporaryMethod) not
			description: 'Method not present after compilation'.

		clientEnvironment handleMessageReceived: (MessageSend
			receiver: nil
			selector: #installMethod:
			arguments: { someMethod }) cpEncoded.
		self assert: (self perform: #temporaryMethod) = 42 description: 'Compiled method answers correct value'
	] ensure: [ self class removeSelector: #temporaryMethod ]

]

{ #category : #tests }
CpClientEnvironmentTest >> testInstallMethodWithClassVarAccess [

	| clientEnvironment someMethod |

	clientEnvironment := CpClientEnvironment current.
	self
		assert: (CpClientEnvironmentTestObject classSide methodDict includesKey: #temporaryMethod) not
		description: 'Method not already present'.

	[
		"Compile new class method for class, test it did not get installed"
		someMethod := CpClientEnvironmentTestObject classSide compiler
			source: 'temporaryMethod SomeClassVar := #test' ;
			requestor: nil ;
			failBlock: [ ^ nil ];
			compile.
		self assert: someMethod notNil description: 'Temporary method compiled'.
		self
			assert: (CpClientEnvironmentTestObject classSide methodDict includesKey: #temporaryMethod) not
			description: 'Method not present after compilation'.

		clientEnvironment handleMessageReceived: (MessageSend
			receiver: nil
			selector: #installMethod:
			arguments: { someMethod }) cpEncoded.

		CpClientEnvironmentTestObject perform: #temporaryMethod.
		self
			assert: CpClientEnvironmentTestObject someClassVar = #test
			description: 'Compiled method answers correct value'
	] ensure: [ CpClientEnvironmentTestObject classSide removeSelector: #temporaryMethod ]

]

{ #category : #tests }
CpClientEnvironmentTest >> testInstallMethodWithInstVarAccess [

	| clientEnvironment someMethod instance |

	clientEnvironment := CpClientEnvironment current.
	self
		assert: (CpClientEnvironmentTestObject instanceSide methodDict includesKey: #temporaryMethod) not
		description: 'Method not already present'.

	[
		"Compile new instance method for class, test it did not get installed"
		someMethod := CpClientEnvironmentTestObject instanceSide compiler
			source: 'temporaryMethod someInstVar := 123. otherInstVar := self' ;
			requestor: nil ;
			failBlock: [ ^ nil ];
			compile.
		self assert: someMethod notNil description: 'Temporary method compiled'.
		self
			assert: (CpClientEnvironmentTestObject instanceSide methodDict includesKey: #temporaryMethod) not
			description: 'Method not present after compilation'.

		clientEnvironment handleMessageReceived: (MessageSend
			receiver: nil
			selector: #installMethod:
			arguments: { someMethod }) cpEncoded.

		instance := CpClientEnvironmentTestObject new.
		instance perform: #temporaryMethod.
		self
			assert: instance someInstVar = 123
			description: 'Compiled method answers correct value'.
		self
			assert: instance otherInstVar = instance
			description: 'Compiled method answers correct reference to self'
	] ensure: [ CpClientEnvironmentTestObject instanceSide removeSelector: #temporaryMethod ]

]
