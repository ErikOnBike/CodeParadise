Class {
	#name : #CynPasswordResetAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#token => CynPropertySlot',
		'#password => CynPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynPasswordResetAccount class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id task email token password)
]

{ #category : #accessing }
CynPasswordResetAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CynPasswordPropertyConstraint default to: constraints.
	self for: #token addConstraint: CynTokenPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #'accessing - generated' }
CynPasswordResetAccount class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id task email token password)
]

{ #category : #initialization }
CynPasswordResetAccount >> initializeProperties [

	super initializeProperties.

	task := #passwordReset
]

{ #category : #accessing }
CynPasswordResetAccount >> password [

	^ password
]

{ #category : #accessing }
CynPasswordResetAccount >> token [

	^ token
]
