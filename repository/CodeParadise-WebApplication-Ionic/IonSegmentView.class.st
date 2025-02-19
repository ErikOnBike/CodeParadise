Class {
	#name : #IonSegmentView,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonSegmentView >> disabled [

	"If 'true', the segment view cannot be interacted with.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonSegmentView >> disabled: aBoolean [

	"If 'true', the segment view cannot be interacted with.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonSegmentView >> setContent: id [

	"@param id : The id of the segment content to display.
	@param smoothScroll : Whether to animate the scroll transition.
	
	Type: (id: string, smoothScroll?: boolean) => Promise<void>"

	^ self apply: #setContent withArguments: { id } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonSegmentView >> setContent: id smoothScroll: smoothScroll [

	"@param id : The id of the segment content to display.
	@param smoothScroll : Whether to animate the scroll transition.
	
	Type: (id: string, smoothScroll?: boolean) => Promise<void>"

	^ self apply: #setContent withArguments: { id . smoothScroll } resultAs: CpJavaScriptPromise
]
