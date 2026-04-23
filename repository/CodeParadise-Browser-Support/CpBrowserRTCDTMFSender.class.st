Class {
	#name : #CpBrowserRTCDTMFSender,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #'instance creation' }
CpBrowserRTCDTMFSender class >> newInstanceWithArguments: anArray resultAs: aClass [

	self error: 'This class should not be instantiated manually'
]

{ #category : #accessing }
CpBrowserRTCDTMFSender >> canInsertDTMF [

	"A boolean value which is true if the RTCDTMFSender is capable of sending DTMF tones, or false if it is not."

	^ self propertyAt: #canInsertDTMF
]

{ #category : #operations }
CpBrowserRTCDTMFSender >> insertDTMF: aString [

	"Given a string describing a set of DTMF codes and, optionally, the duration of and inter-tone gap between the tones, insertDTMF() starts sending the specified tones. Calling insertDTMF() replaces any already-pending tones from the toneBuffer. You can abort sending queued tones by specifying an empty string ('') as the set of tones to play."

	self apply: #insertDTMF withArguments: { aString }
]

{ #category : #operations }
CpBrowserRTCDTMFSender >> insertDTMF: aString duration: anInteger [

	"Given a string describing a set of DTMF codes and, optionally, the duration of and inter-tone gap between the tones, insertDTMF() starts sending the specified tones. Calling insertDTMF() replaces any already-pending tones from the toneBuffer. You can abort sending queued tones by specifying an empty string ('') as the set of tones to play."

	self apply: #insertDTMF withArguments: { aString . anInteger }
]

{ #category : #operations }
CpBrowserRTCDTMFSender >> insertDTMF: aString duration: durationInteger interToneGap: gapInteger [

	"Given a string describing a set of DTMF codes and, optionally, the duration of and inter-tone gap between the tones, insertDTMF() starts sending the specified tones. Calling insertDTMF() replaces any already-pending tones from the toneBuffer. You can abort sending queued tones by specifying an empty string ('') as the set of tones to play."

	self apply: #insertDTMF withArguments: { aString . durationInteger . gapInteger }
]

{ #category : #accessing }
CpBrowserRTCDTMFSender >> toneBuffer [

	"A string which contains the list of DTMF tones currently in the queue to be transmitted (tones which have already been played are no longer included in the string). See toneBuffer for details on the format of the tone buffer."

	^ self propertyAt: #toneBuffer
]
