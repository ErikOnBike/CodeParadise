"
I represent both the Browser AbortSignal and the Node.js AbortSignal.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserAbortSignal,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> abort [

	"Returns an AbortSignal instance that is already set as aborted."

	^ self apply: #abort resultAs: self
]

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> abort: reasonObject [

	"Returns an AbortSignal instance that is already set as aborted."

	^ self apply: #abort withArguments: { reasonObject } resultAs: self
]

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> any: aCollection [

	"Returns an AbortSignal that aborts when any of the given abort signals abort."

	^ self apply: #any withArguments: { aCollection } resultAs: self
]

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: (' or ' join: { #abort . #abort: . #any: . #timeout: })
]

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> timeout: anInteger [

	"Returns an AbortSignal instance that will automatically abort after a specified time (in ms)."

	^ self apply: #timeout withArguments: { anInteger } resultAs: self
]

{ #category : #accessing }
CpBrowserAbortSignal >> aborted [

	"A Boolean that indicates whether the request(s) the signal is communicating with is/are aborted (true) or not (false)."

	^ self propertyAt: #aborted
]

{ #category : #accessing }
CpBrowserAbortSignal >> reason [

	"A JavaScript value providing the abort reason, once the signal has aborted."

	^ self propertyAt: #reason
]

{ #category : #accessing }
CpBrowserAbortSignal >> throwIfAborted [

	"Throws the signal's abort reason if the signal has been aborted; otherwise it does nothing."

	self apply: #throwIfAborted
]
