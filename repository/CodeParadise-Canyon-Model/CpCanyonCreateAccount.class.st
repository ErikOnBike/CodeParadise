Class {
	#name : #CpCanyonCreateAccount,
	#superclass : #CpCanyonAccount,
	#instVars : [
		'#password => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CpCanyonCreateAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CpPasswordPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #initialization }
CpCanyonCreateAccount >> initializeProperties [

	super initializeProperties.

	task := #create
]

{ #category : #accessing }
CpCanyonCreateAccount >> password [

	^ password
]
