Extension { #name : #IonDatetime }

{ #category : #'*CodeParadise-Canyon-App' }
IonDatetime >> errorText: aString [

	"The receiver does not have an errorText, ignore it"
]

{ #category : #'*CodeParadise-Canyon-App' }
IonDatetime >> label: aString [

	"The receiver does not have a label, ignore it"
]

{ #category : #'*CodeParadise-Canyon-App' }
IonDatetime >> valueForModel [

	"Convenience method used in binding Elements to a Model"

	| isDateType presentation value |

	"Retrieve type of date value being used (or assume String if not known yet)"
	isDateType := (self propertyAt: #canyonIsDateType)
		ifNil: [ false ].

	presentation:= self presentation ifNil: [ #'date-time' ].

	value := isDateType
		ifTrue: [
			presentation = #date
				ifTrue: [ CpJavaScriptDate fromString: self value ]
				ifFalse: [
					presentation = #time
						ifTrue: [
							"Construct a Date instance for the current date and the receiver's time"
							CpJavaScriptDate fromString: (String streamContents: [ :stream |
								stream
									nextPutAll: CpJavaScriptDate today dateString ;
									nextPut: $T ;
									nextPutAll: self value ]) ]
						ifFalse: [ CpJavaScriptDate fromString: self value ] ] ]
		ifFalse: [ self value ].

	^ value
]

{ #category : #'*CodeParadise-Canyon-App' }
IonDatetime >> valueFromModel: anObject [

	"Value can be set using CpJavaScriptDate or String,
	keep track of the type used so the getter will respond
	with the same type."

	| isDateType presentation newValue |

	"Keep track of type of date value being used"
	isDateType := anObject class == CpJavaScriptDate.
	self propertyAt: #canyonIsDateType put: isDateType.

	presentation:= self presentation ifNil: [ #'date-time' ].

	"Decide new value based on type"
	newValue := isDateType
		ifTrue: [
			presentation = #date
				ifTrue: [ anObject dateString ]
				ifFalse: [
					presentation = #time
						ifTrue: [ anObject shortTimeString ]
						ifFalse: [ anObject toISOString ] ] ]
		ifFalse: [ anObject ].

	"Only update if changed (to prevent ping-pong between Element and Model)"
	self valueForModel = newValue
		ifFalse: [ self value: newValue ]
]

{ #category : #'*CodeParadise-Canyon-App' }
IonDatetime >> whenChangedDo: aBlock for: anObject [

	^ self when: IonChangeEvent do: aBlock for: anObject
]
