Class {
	#name : #CpCanyonAccount,
	#superclass : #CpPropertyEntity,
	#instVars : [
		'#task => CpPropertySlot',
		'#email => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CpCanyonAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #email addConstraint: CpEmailPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #accessing }
CpCanyonAccount >> email [

	^ email
]

{ #category : #accessing }
CpCanyonAccount >> email: aString [

	email := aString
]
