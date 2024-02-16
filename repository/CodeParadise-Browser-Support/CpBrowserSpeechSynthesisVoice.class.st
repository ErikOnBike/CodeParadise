Class {
	#name : #CpBrowserSpeechSynthesisVoice,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Speech'
}

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> default [

	"A boolean value indicating whether the voice is the default voice for the current app language (true), or not (false)."

	^ self propertyAt: #default
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> lang [

	"Returns a BCP 47 language tag indicating the language of the voice. (aka IETF language tag)"

	^ self propertyAt: #lang
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> localService [

	"A boolean value indicating whether the voice is supplied by a local speech synthesizer service (true), or a remote speech synthesizer service (false)."

	^ self propertyAt: #localService
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> name [

	"Returns a human-readable name that represents the voice."

	^ self propertyAt: #name
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> voiceURI [

	"Returns the type of URI and location of the speech synthesis service for this voice."

	^ self propertyAt: #voiceURI
]
