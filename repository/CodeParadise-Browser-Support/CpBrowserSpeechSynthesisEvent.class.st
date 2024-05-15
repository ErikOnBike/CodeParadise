Class {
	#name : 'CpBrowserSpeechSynthesisEvent',
	#superclass : 'CpJavaScriptEvent',
	#category : 'CodeParadise-Browser-Support-Speech',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'Speech'
}

{ #category : 'accessing' }
CpBrowserSpeechSynthesisEvent >> charIndex [

	"Returns the index position of the character in the SpeechSynthesisUtterance.text that was being spoken when the event was triggered."

	^ self propertyAt: #charIndex
]

{ #category : 'accessing' }
CpBrowserSpeechSynthesisEvent >> charLength [

	"Returns the number of characters left to be spoken after the charIndex position, if the speaking engine supports it. Returns 0 if the speaking engine can't provide the information."

	^ self propertyAt: #charLength
]

{ #category : 'accessing' }
CpBrowserSpeechSynthesisEvent >> elapsedTime [

	"Returns the elapsed time in seconds after the SpeechSynthesisUtterance.text started being spoken that the event was triggered at."

	^ self propertyAt: #elapsedTime
]

{ #category : 'accessing' }
CpBrowserSpeechSynthesisEvent >> name [

	"Returns the name associated with certain types of events occurring as the SpeechSynthesisUtterance.text is being spoken: the name of the SSML marker reached in the case of a mark event, or the type of boundary reached in the case of a boundary event."

	^ self propertyAt: #name
]

{ #category : 'accessing' }
CpBrowserSpeechSynthesisEvent >> utterance [

	"Returns the SpeechSynthesisUtterance instance that the event was triggered on."

	^ self propertyAt: #utterance
]
