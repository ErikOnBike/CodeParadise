Class {
	#name : #CynActivateAccountToken,
	#superclass : #CynTaskToken,
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynActivateAccountToken class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id token)
]

{ #category : #accessing }
CynActivateAccountToken class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #token addConstraint: CynTokenPropertyConstraint default to: constraints.

	^ constraints
]

{ #category : #'accessing - generated' }
CynActivateAccountToken class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id token)
]
