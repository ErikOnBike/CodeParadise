Class {
	#name : #CpBrowserSpeechSynthesisVoice,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Speech'
}

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> default [

	"A boolean value indicating whether the voice is the default voice for the current app language (true), or not (false)."

	^ self apply: #default
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> lang [

	"Returns a BCP 47 language tag indicating the language of the voice. (aka IETF language tag)"

	^ self apply: #lang
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> localService [

	"A boolean value indicating whether the voice is supplied by a local speech synthesizer service (true), or a remote speech synthesizer service (false)."

	^ self apply: #localService
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> name [

	"Returns a human-readable name that represents the voice."

	^ self apply: #name
]

{ #category : #accessing }
CpBrowserSpeechSynthesisVoice >> voiceURI [

	"Returns the type of URI and location of the speech synthesis service for this voice."

	^ self apply: #voiceURI
]
