Class {
	#name : #CpBrowserWorkerGlobalScope,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-Worker'
}

{ #category : #'class initialization' }
CpBrowserWorkerGlobalScope class >> postInstall [

	"Since I'm probably installed to be the new global scope, reset the existing globalThis
	since it might have been used already"

	super postInstall.

	CpGlobalThis reset
]

{ #category : #accessing }
CpBrowserWorkerGlobalScope >> location [

	"Returns the WorkerLocation associated with the worker. It is a specific location object, mostly a subset of the Location for browsing scopes, but adapted to workers."

	^ self propertyAt: #location
]

{ #category : #accessing }
CpBrowserWorkerGlobalScope >> navigator [

	"Returns the WorkerNavigator associated with the worker. It is a specific navigator object, mostly a subset of the Navigator for browsing scopes, but adapted to workers."

	^ self propertyAt: #navigator
]

{ #category : #accessing }
CpBrowserWorkerGlobalScope >> origin [

	"Returns the global object's origin, serialized as a string."

	^ self propertyAt: #origin
]
