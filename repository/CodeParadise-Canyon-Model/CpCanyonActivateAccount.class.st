Class {
	#name : #CpCanyonActivateAccount,
	#superclass : #CpCanyonAccount,
	#instVars : [
		'#token => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CpCanyonActivateAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #token addConstraint: CpTokenPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #initialization }
CpCanyonActivateAccount >> initializeProperties [

	super initializeProperties.

	task := #activate
]

{ #category : #accessing }
CpCanyonActivateAccount >> token [

	^ token
]
