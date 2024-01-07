Class {
	#name : 'CpDemoExecutableCodeContent',
	#superclass : 'CpDemoCodeContent',
	#category : 'CodeParadise-WebApplication-Presentation-Examples',
	#package : 'CodeParadise-WebApplication-Presentation',
	#tag : 'Examples'
}

{ #category : 'do-its' }
CpDemoExecutableCodeContent >> doIt [

	| result |

	"Create an array of result values"
	result := self class compiler evaluate: '{ ', self code, ' }'.

	"With recent version of Pharo the code does not evaluate to the class, but to a ClassBuilder.
	Build and install the actual class if this happens."
	result do: [:each |
		each class name == #ShiftClassBuilder
			ifTrue: [ each install ] ]
]
