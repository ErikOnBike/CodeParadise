Class {
	#name : #CpNodeJSEventEmitter,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Support-Core'
}

{ #category : #operations }
CpNodeJSEventEmitter >> addListener: aSymbol handler: aBlock [

	"Adds the listener function to the end of the listeners array for the event named eventName. No checks are made to see if the listener has already been added. Multiple calls passing the same combination of eventName and listener will result in the listener being added, and called, multiple times.

	eventName <string> | <symbol> The name of the event.
	listener <Function> The callback function"

	| function |

	"Create function from the Block and specify the event name (to allow later removal)"
	function := CpJavaScriptFunction wrap: aBlock.
	function propertyAt: #eventName put: aSymbol.

	"Add event listener"
	self apply: #addListener withArguments: { aSymbol . function }.

	^ function
]

{ #category : #operations }
CpNodeJSEventEmitter >> removeListener: aFunction [

	"Removes the specified listener from the listener array for the event named eventName."

	self apply: #removeListener withArguments: { aFunction propertyAt: #eventName . aFunction }
]
