Class {
	#name : #CynActivateAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#token => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynActivateAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #token addConstraint: CynTokenPropertyConstraint default to: constraints.

	^ constraints
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
