Class {
	#name : #IonItemSliding,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonItemSliding >> close [

	"Close the sliding item. Items can also be closed from the [List](./list).
	
	Type: Promise<void>"

	^ self apply: #close resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonItemSliding >> closeOpened [

	"Close all of the sliding items in the list. Items can also be closed from the [List](./list).
	
	Type: Promise<boolean>"

	^ self apply: #closeOpened resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonItemSliding >> disabled [

	"If 'true', the user cannot interact with the sliding item.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonItemSliding >> disabled: aBoolean [

	"If 'true', the user cannot interact with the sliding item.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonItemSliding >> getOpenAmount [

	"Get the amount the item is open in pixels.
	
	Type: Promise<number>"

	^ self apply: #getOpenAmount resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonItemSliding >> getSlidingRatio [

	"Get the ratio of the open amount of the item compared to the width of the options. If the number returned is positive, then the options on the right side are open. If the number returned is negative, then the options on the left side are open. If the absolute value of the number is greater than 1, the item is open more than the width of the options.
	
	Type: Promise<number>"

	^ self apply: #getSlidingRatio resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonItemSliding >> open: side [

	"Open the sliding item.
	@param side The side of the options to open. If a side is not provided, it will open the first set of options it finds within the item.
	
	Type: (side: Side | undefined) => Promise<void>"

	^ self apply: #open withArguments: { side } resultAs: CpJavaScriptPromise
]
