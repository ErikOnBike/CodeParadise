Class {
	#name : #CynChangePasswordToken,
	#superclass : #CynTaskToken,
	#instVars : [
		'#password => CynPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynChangePasswordToken class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id token password)
]

{ #category : #accessing }
CynChangePasswordToken class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CynPasswordPropertyConstraint default to: constraints.
	self for: #token addConstraint: CynTokenPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #'accessing - generated' }
CynChangePasswordToken class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id token password)
]

{ #category : #accessing }
CynChangePasswordToken >> password [

	^ password
]
