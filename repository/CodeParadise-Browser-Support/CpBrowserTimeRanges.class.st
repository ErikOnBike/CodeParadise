Class {
	#name : #CpBrowserTimeRanges,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #operations }
CpBrowserTimeRanges >> end: anInteger [

	"Returns the time for the end of the specified range."

	^ self apply: #end withArguments: { anInteger }
]

{ #category : #accessing }
CpBrowserTimeRanges >> length [

	"Returns an unsigned long representing the number of time ranges represented by the time range object."

	^ self propertyAt: #length
]

{ #category : #operations }
CpBrowserTimeRanges >> start: anInteger [

	"Returns the time for the start of the range with the specified index."

	^ self apply: #start withArguments: { anInteger }
]
