Class {
	#name : #CpBrowserSpeechSynthesis,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-Browser-Support-Speech'
}

{ #category : #accessing }
CpBrowserSpeechSynthesis class >> current [

	"Answer an instance of the receiver"

	^ CpBrowserWindow current
		apply: #speechSynthesis resultAs: self
]

{ #category : #'instance creation' }
CpBrowserSpeechSynthesis class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: #current
]

{ #category : #operations }
CpBrowserSpeechSynthesis >> cancel [

	"Removes all utterances from the utterance queue."

	self apply: #cancel
]

{ #category : #accessing }
CpBrowserSpeechSynthesis >> getVoices [

	"Returns a list of SpeechSynthesisVoice objects representing all the available voices on the current device."

	^ self apply: #getVoices
]

{ #category : #'event handling' }
CpBrowserSpeechSynthesis >> onVoicesChangedDo: aBlock [

	"Fired when the list of SpeechSynthesisVoice objects that would be returned by the SpeechSynthesis.getVoices() method has changed."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #voiceschanged handler: aBlock
]

{ #category : #operations }
CpBrowserSpeechSynthesis >> pause [

	"Puts the SpeechSynthesis object into a paused state."

	self apply: #pause
]

{ #category : #accessing }
CpBrowserSpeechSynthesis >> paused [

	"A boolean value that returns true if the SpeechSynthesis object is in a paused state."

	^ self propertyAt: #paused
]

{ #category : #accessing }
CpBrowserSpeechSynthesis >> pending [

	"A boolean value that returns true if the utterance queue contains as-yet-unspoken utterances."

	^ self propertyAt: #pending
]

{ #category : #operations }
CpBrowserSpeechSynthesis >> resume [

	"Puts the SpeechSynthesis object into a non-paused state: resumes it if it was already paused."

	self apply: #resume
]

{ #category : #operations }
CpBrowserSpeechSynthesis >> speak: anUtterance [

	"Adds an utterance to the utterance queue; it will be spoken when any other utterances queued before it have been spoken."

	self apply: #speak withArguments: { anUtterance }
]

{ #category : #accessing }
CpBrowserSpeechSynthesis >> speaking [

	"A boolean value that returns true if an utterance is currently in the process of being spoken — even if SpeechSynthesis is in a paused state."

	^ self propertyAt: #speaking
]
