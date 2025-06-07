Class {
	#name : #CynActivateAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#token => CynPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynActivateAccount class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id task email token)
]

{ #category : #accessing }
CynActivateAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #token addConstraint: CynTokenPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #'accessing - generated' }
CynActivateAccount class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id task email token)
]

{ #category : #initialization }
CynActivateAccount >> initializeProperties [

	super initializeProperties.

	task := #activate
]

{ #category : #accessing }
CynActivateAccount >> token [

	^ token
]
