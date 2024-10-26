Class {
	#name : #CpJavaScriptAbortSignal,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpJavaScriptAbortSignal class >> abort [

	"Returns an AbortSignal instance that is already set as aborted."

	^ self apply: #abort resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptAbortSignal class >> abort: reasonObject [

	"Returns an AbortSignal instance that is already set as aborted."

	^ self apply: #abort withArguments: { reasonObject } resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptAbortSignal class >> any: aCollection [

	"Returns an AbortSignal that aborts when any of the given abort signals abort."

	^ self apply: #any withArguments: { aCollection } resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptAbortSignal class >> timeout: anInteger [

	"Returns an AbortSignal instance that will automatically abort after a specified time (in ms)."

	^ self apply: #timeout withArguments: { anInteger } resultAs: self
]

{ #category : #accessing }
CpJavaScriptAbortSignal >> aborted [

	"A Boolean that indicates whether the request(s) the signal is communicating with is/are aborted (true) or not (false)."

	^ self propertyAt: #aborted
]

{ #category : #accessing }
CpJavaScriptAbortSignal >> reason [

	"A JavaScript value providing the abort reason, once the signal has aborted."

	^ self propertyAt: #reason
]

{ #category : #accessing }
CpJavaScriptAbortSignal >> throwIfAborted [

	"Throws the signal's abort reason if the signal has been aborted; otherwise it does nothing."

	self apply: #throwIfAborted
]
