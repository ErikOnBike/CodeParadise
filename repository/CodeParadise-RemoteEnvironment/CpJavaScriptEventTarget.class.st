"
I represent both the Browser EventTarget and the Node.js EventTarget/EventEmitter.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpJavaScriptEventTarget,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #operations }
CpJavaScriptEventTarget >> addEventListener: aSymbol handler: aBlock [

	"Add the specified Block as an event handler for the specified event
	for the receiver's proxied JavaScript object (i.e. an EventTarget).
	Answer the added handler (wrapped as Function) which is needed as
	the handler to remove the event listener."

	| function |

	"Create function from the Block"
	function := CpJavaScriptFunction wrap: aBlock.

	"Add event listener"
	self apply: #addEventListener withArguments: { aSymbol . function }.

	^ function
]

{ #category : #operations }
CpJavaScriptEventTarget >> removeEventListener: aSymbol handler: aFunction [

	"Remove the specified funcion (a wrapped Block, answered by #addEventListener:handler:)
	for the specified event from the receiver's proxied JavaScript object (i.e. an EventTarget)."

	self apply: #removeEventListener withArguments: { aSymbol . aFunction }
]
