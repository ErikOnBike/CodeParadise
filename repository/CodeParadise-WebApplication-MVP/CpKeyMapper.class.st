"
I am a simple KeyMapper. I map one key onto another. I can be used to map KeyEvents.
"
Class {
	#name : 'CpKeyMapper',
	#superclass : 'Object',
	#instVars : [
		'mapping'
	],
	#category : 'CodeParadise-WebApplication-MVP-Core',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Core'
}

{ #category : 'adding' }
CpKeyMapper >> addMappingFrom: fromKey to: toKey [

	"Add a mapping between both keys (both String)"

	self mapping at: fromKey put: toKey
]

{ #category : 'initialization' }
CpKeyMapper >> initialize [

	super initialize.

	mapping := Dictionary new
]

{ #category : 'accessing' }
CpKeyMapper >> map: fromKey [

	^ self mapping at: fromKey ifAbsent: [ fromKey ]
]

{ #category : 'accessing' }
CpKeyMapper >> mapping [

	^ mapping
]

{ #category : 'initialization' }
CpKeyMapper >> release [

	mapping := nil.

	super release
]
