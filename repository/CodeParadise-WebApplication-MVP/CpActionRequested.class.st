"
I am a generic announcement for Actions being requested in the View.
I can have parameters to further specify the action requested.

Parameters are either id based or positional. Positional based parameters start
with index 1.

To specify id based parameters, create an instance using a Dictionary as follows:
	CpActionRequested id: #someAction parameters: { #one -> 1. #two -> 2 } asDictionary.

To specify positional parameters, create an instance using an Array (or other SequencableCollection )as follows:
	CpActionRequested id: #otherAction parameters: #(#one #two #three).

To retrieve an id based parameter use:
	actionRequested parameterAt: #one

To retrieve a positional parameter use (or one of the three convenience methods):
	actionRequested parameterAt: 1

	actionRequested firstParameter
	actionRequested secondParameter
	actionRequested thirdParameter

See some examples in the class comment for CpBasicEvent.

"
Class {
	#name : #CpActionRequested,
	#superclass : #CpBasicEvent,
	#instVars : [
		'parameters'
	],
	#category : #'CodeParadise-WebApplication-MVP-Support'
}

{ #category : #'instance creation' }
CpActionRequested class >> id: aSymbol [

	"Answer an instance of the receiver with no specific parameters.
	This allows announcements to be parameterized
	(see also CpActionRequested >> #handlesAnnouncement:).

	Implementation:
	Use the UndefinedObject class to indicate 'no parameters'.
	This value will normally not be used as parameter. Any class
	would probably do as alternative as well. Because currently class
	variables are not supported this approach is taken."

	^ self id: aSymbol parameters: UndefinedObject
]

{ #category : #'instance creation' }
CpActionRequested class >> id: aSymbol parameter: anObject [

	"Answer a new instance of the receiver with the specified field and parameter.
	The parameter value can be accessed from the instance through #firstParameter."

	^ self id: aSymbol parameters: anObject asParameterDictionary
]

{ #category : #'instance creation' }
CpActionRequested class >> id: aSymbol parameterKeys: anArray [

	"Answer a new instance of the receiver with the specified field and value-less parameters.
	This instance can be used to validate the presence of certain parameters in an
	actual announcement. It would be used in a #when:send:to: message.
	The specified array should contain the parameter keys which are required for the
	announcement to 'match' an actual announcement.
	See also (CpActionRequested >> #handlesAnnouncement:)"

	^ self id: aSymbol parameters: (self parametersFromKeys: anArray)
]

{ #category : #'instance creation' }
CpActionRequested class >> id: aSymbol parameters: anArrayOrDictionary [

	^ self basicNew
		initializeWithId: aSymbol parameters: anArrayOrDictionary asParameterDictionary ;
		yourself
]

{ #category : #support }
CpActionRequested class >> parametersFromKeys: anArray [

	"Answer a parameters dictionary containing the specified keys,
	but having no explicit value set"

	| parameters |

	parameters := Dictionary new: anArray size.

	anArray do: [ :each | parameters at: each put: UndefinedObject ].

	^ parameters
]

{ #category : #accessing }
CpActionRequested >> firstParameter [

	^ self parameterAt: 1
]

{ #category : #testing }
CpActionRequested >> handlesAnnouncement: anAnnouncement [

	"Answer whether the receiver handles the specified announcement.
	This is normally a class side method, but it is used as an instance
	variant to allow a action id and optionally parameters to be specified.
	This makes it possible to define a 'parameterized' announcement.
	See class comment for further explanation and examples."

	^ (super handlesAnnouncement: anAnnouncement)
		and: [ self matchesParametersIn: anAnnouncement ]
]

{ #category : #testing }
CpActionRequested >> hasParameterWithValueAt: aSymbol [

	"Answer whether the receiver has an actual value for the specified parameter.
	This value can be nil (but not the class UndefinedObject which is used internally
	to distinguish beteen nil and 'no value')."

	^ parameters
		ifNotNil: [ (parameters includesKey: aSymbol) and: [ (parameters at: aSymbol) ~~ UndefinedObject ] ]
		ifNil: [ false ]
]

{ #category : #testing }
CpActionRequested >> hasParameters [

	"Answer whether the receiver has an explicit value.
	The value UndefinedObject is used as placeholder to indicate no parameters are set."

	^ parameters ~~ UndefinedObject
]

{ #category : #initialization }
CpActionRequested >> initializeWithId: aSymbol parameters: aDictionary [

	self initializeWithId: aSymbol.

	parameters := aDictionary
]

{ #category : #testing }
CpActionRequested >> matchesParametersIn: anAnnouncement [

	"Answer whether the receiver's parameters match those in the specified
	announcement. Assume the announcement has the same interface as the
	receiver (same class or same protocol supported).

	Implementation:
	Every parameter present in the receiver is checked. For every parameter
	with a given value, this value is checked in the other announcement.
	For every parameter without a specific value the other announcement
	simply has to have that same parameter (disgarding its actual value)."

	"If the receiver has no parameters, ignore the parameters of the other announcement"
	self hasParameters
		ifFalse: [ ^ true ].

	"If the specified announcement does not have parameters, there is no match"
	anAnnouncement hasParameters
		ifFalse: [ ^ false ].

	parameters keysAndValuesDo: [ :key :paramValue |
			paramValue == UndefinedObject
				ifTrue: [
					(anAnnouncement hasParameterWithValueAt: key)
						ifFalse: [ ^ false ] ]
				ifFalse: [
					paramValue = (anAnnouncement parameterAt: key)
						ifFalse: [ ^ false ] ] ].

	^ true
]

{ #category : #accessing }
CpActionRequested >> parameterAt: aSymbol [

	^ parameters ifNotNil: [ parameters at: aSymbol ifAbsent: [ nil ] ]
]

{ #category : #accessing }
CpActionRequested >> parameterKeys [

	^ parameters
		ifNotNil: [ parameters keys ]
		ifNil: [ #() ]
]

{ #category : #printing }
CpActionRequested >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', parameters: ' ;
		print: parameters
]

{ #category : #accessing }
CpActionRequested >> secondParameter [

	^ self parameterAt: 2
]

{ #category : #accessing }
CpActionRequested >> thirdParameter [

	^ self parameterAt: 3
]
