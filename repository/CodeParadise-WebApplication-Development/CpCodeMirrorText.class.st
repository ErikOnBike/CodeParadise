Class {
	#name : #CpCodeMirrorText,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-WebApplication-Development-View'
}

{ #category : #accessing }
CpCodeMirrorText >> toString [

	"Return the document as a string, using newline characters to separate lines."

	^ self apply: #toString
]
