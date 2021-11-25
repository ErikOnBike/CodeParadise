Class {
	#name : #CpCssAnimation,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #'instance creation' }
CpCssAnimation class >> new [

	self shouldNotImplement
]

{ #category : #'animation - keyframes' }
CpCssAnimation class >> tadaKeyframes [

	^ {
		{ #transform -> 'scale(1)' } asDictionary.
		{ #transform -> 'scale(0.9) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(0.9) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(-3deg)' } asDictionary.
		{ #transform -> 'scale(1.1) rotate(3deg)' } asDictionary.
		{ #transform -> 'scale(1) rotate(0)' } asDictionary
	}
]
