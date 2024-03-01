Class {
	#name : #CpNodeJSBuiltinModule,
	#superclass : #CpNodeJSModule,
	#category : #'CodeParadise-NodeJS-Support-Core'
}

{ #category : #'instance creation' }
CpNodeJSBuiltinModule class >> moduleName [

	"Builtin modules have a prefix"

	^ 'node:', super moduleName
]
