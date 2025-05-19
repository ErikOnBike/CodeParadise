Class {
	#name : #CpNodeJSBuiltinModule,
	#superclass : #CpNodeJSModule,
	#category : #'CodeParadise-NodeJS-Support-Core'
}

{ #category : #testing }
CpNodeJSBuiltinModule class >> isAbstractTag [

	"The method is present to indicate the receiver is abstract.
	This method will NOT be evaluated to decide if the receiver is abstract."
]

{ #category : #'instance creation' }
CpNodeJSBuiltinModule class >> moduleName [

	"Builtin modules have a prefix"

	^ 'node:', super moduleName
]
