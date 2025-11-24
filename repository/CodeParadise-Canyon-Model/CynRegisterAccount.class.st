Class {
	#name : #CynRegisterAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#password => CynPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynRegisterAccount class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id email password)
]

{ #category : #accessing }
CynRegisterAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CynPasswordPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #'accessing - generated' }
CynRegisterAccount class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id email password)
]

{ #category : #accessing }
CynRegisterAccount >> password [

	^ password
]
