"
I am a PropertyConstraint with a default implementation.
My behavior is not influenced by some parameters.
"
Class {
	#name : #CpDefaultPropertyConstraint,
	#superclass : #CpPropertyConstraint,
	#classVars : [
		'Defaults'
	],
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CpDefaultPropertyConstraint class >> default [

	^ (Defaults ifNil: [ Defaults := Dictionary new ])
		at: self ifAbsentPut: [ self basicNew initialize ; yourself ]
]

{ #category : #'instance creation' }
CpDefaultPropertyConstraint class >> new [

	self errorNewReplacedBy: #default
]

{ #category : #initialization }
CpDefaultPropertyConstraint class >> reset [

	<script>

	Defaults := nil
]
