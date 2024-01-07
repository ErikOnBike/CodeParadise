Class {
	#name : #CpDemoExecutableCodeContent,
	#superclass : #CpDemoCodeContent,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'do-its' }
CpDemoExecutableCodeContent >> doIt [

	self class evaluate: self code
]
