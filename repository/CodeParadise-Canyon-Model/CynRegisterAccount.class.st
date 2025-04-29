Class {
	#name : #CynRegisterAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#password => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynRegisterAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CynPasswordPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #initialization }
CynRegisterAccount >> initializeProperties [

	super initializeProperties.

	task := #create
]

{ #category : #accessing }
CynRegisterAccount >> password [

	^ password
]
