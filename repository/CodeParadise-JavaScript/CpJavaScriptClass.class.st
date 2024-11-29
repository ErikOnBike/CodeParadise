"
I represent JavaScript classes.
See the comment in CpJavaScriptProxy.

Although logically not the same, JavaScript namespaces (sometimes also called
more generically interfaces) are also handled by me. The JavaScript Math
namespace (for example) is not a class from which instances are created.
It can however be used by me to invoke the static methods (or more
appropriately, namespace methods).

"
Class {
	#name : #CpJavaScriptClass,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #'instance creation' }
CpJavaScriptClass class >> forName: aString [

	"Answer an instance of the receiver for the specified JavaScript class (name).

	Assumes the class name is public (can be retrieved from the global scope)."

	^ CpJavaScriptObject global
		getClassRefFrom: aString resultAs: self
]

{ #category : #accessing }
CpJavaScriptClass >> name [

	"Answer the actual (non Smalltalk) name of the receiver"

	^ self propertyAt: #name
]

{ #category : #'instance creation' }
CpJavaScriptClass >> newInstance [

	"For better performance use #newInstanceResultAs: if the result Class is known."

	^ self newInstanceWithArguments: nil resultAs: nil
]

{ #category : #'instance creation' }
CpJavaScriptClass >> newInstanceResultAs: aProxyClass [

	^ self newInstanceWithArguments: nil resultAs: aProxyClass
]

{ #category : #'instance creation' }
CpJavaScriptClass >> newInstanceWithArguments: anArray [

	"For better performance use #newInstanceWithArguments:resultAs: if the result Class is known."

	^ self newInstanceWithArguments: anArray resultAs: nil
]

{ #category : #'instance creation' }
CpJavaScriptClass >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	"Answer a new instance of the receiver's proxied JavaScript object (i.e. not an
	instance of the receiver itself) using the specified (optional) arguments
	when calling the constructor.
	If a Proxy Class is specified, it is used to instantiate the result. Otherwise
	the default Proxy Class is used.

	Implementation:
	Convert Smalltalk Blocks to JavaScript functions if necessary.
	See also CpJavaScriptFunction class >> #wrap:"

	| arguments |

	arguments := anArray ifNotNil: [
		anArray
			detect: [ :each | each isBlock ]
			ifFound: [
				anArray collect: [ :each |
					each isBlock
						ifTrue: [ CpJavaScriptFunction wrap: each ]
						ifFalse: [ each ] ] ]
			ifNone: [ anArray ] ].

	^ self primNewInstanceWithArguments: arguments resultAs: aProxyClass
]

{ #category : #'apply primitives' }
CpJavaScriptClass >> primNewInstanceWithArguments: anArray resultAs: aProxyClass [

	"Answer a new instance of the receiver's proxied JavaScript object (i.e. not an
	instance of the receiver itself) using the specified (optional) arguments
	when calling the constructor.
	If a Proxy Class is specified, it is used to instantiate the result. Otherwise
	the default Proxy Class is used."

	<primitive: 'primitiveJavaScriptClassNewInstanceWithArguments:resultAs:' module: 'CpSystemPlugin'>
	self primitiveFailed
]
