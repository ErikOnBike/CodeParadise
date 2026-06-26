Class {
	#name : #SlCarousel,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlCarousel >> activeSlide [

	"Answer the index of the active slide"

	^ self propertyAt: #activeSlide
]

{ #category : #accessing }
SlCarousel >> autoplay [

	"When set, the slides will scroll automatically when the user is not interacting with them."

	^ self propertyAt: #autoplay
]

{ #category : #accessing }
SlCarousel >> autoplay: aBoolean [

	"When set, the slides will scroll automatically when the user is not interacting with them."

	self propertyAt: #autoplay put: aBoolean
]

{ #category : #accessing }
SlCarousel >> autoplayInterval [

	"Specifies the amount of time, in milliseconds, between each automatic scroll."

	^ self propertyAt: #autoplayInterval
]

{ #category : #accessing }
SlCarousel >> autoplayInterval: anInteger [

	"Specifies the amount of time, in milliseconds, between each automatic scroll."

	self propertyAt: #autoplayInterval put: anInteger
]

{ #category : #actions }
SlCarousel >> goToSlide: anInteger [

	"Scrolls the carousel to the slide specified by index."

	self apply: #goToSlide withArguments: { anInteger }
]

{ #category : #accessing }
SlCarousel >> loop [

	"When set, allows the user to navigate the carousel in the same direction indefinitely."

	^ self propertyAt: #loop
]

{ #category : #accessing }
SlCarousel >> loop: aBoolean [

	"When set, allows the user to navigate the carousel in the same direction indefinitely."

	self propertyAt: #loop put: aBoolean
]

{ #category : #accessing }
SlCarousel >> mouseDragging [

	"When set, it is possible to scroll through the slides by dragging them with the mouse."

	^ self propertyAt: #mouseDragging
]

{ #category : #accessing }
SlCarousel >> mouseDragging: aBoolean [

	"When set, it is possible to scroll through the slides by dragging them with the mouse."

	self propertyAt: #mouseDragging put: aBoolean
]

{ #category : #accessing }
SlCarousel >> navigation [

	"When set, show the carousel’s navigation."

	^ self propertyAt: #navigation
]

{ #category : #accessing }
SlCarousel >> navigation: aBoolean [

	"When set, show the carousel’s navigation."

	self propertyAt: #navigation put: aBoolean
]

{ #category : #actions }
SlCarousel >> next [

	self apply: #next
]

{ #category : #actions }
SlCarousel >> next: aString [

	"Argument is scroll behavior: auto | smooth | instant"

	self apply: #next withArguments: { aString }
]

{ #category : #accessing }
SlCarousel >> orientation [

	"Specifies the orientation in which the carousel will lay out."

	^ self propertyAt: #orientation
]

{ #category : #accessing }
SlCarousel >> orientation: aString [

	"Specifies the orientation in which the carousel will lay out."

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
SlCarousel >> pagination [

	"When set, show the carousel’s pagination indicators."

	^ self propertyAt: #pagination
]

{ #category : #accessing }
SlCarousel >> pagination: aBoolean [

	"When set, show the carousel’s pagination indicators."

	self propertyAt: #pagination put: aBoolean
]

{ #category : #actions }
SlCarousel >> previous [

	self apply: #previous
]

{ #category : #actions }
SlCarousel >> previous: aString [

	"Argument is scroll behavior: auto | smooth | instant"

	self apply: #previous withArguments: { aString }
]

{ #category : #accessing }
SlCarousel >> slidesPerMove [

	"Specifies the number of slides the carousel will advance when scrolling, useful when specifying a slides-per-page greater than one. It can’t be higher than slides-per-page."

	^ self propertyAt: #slidesPerMove
]

{ #category : #accessing }
SlCarousel >> slidesPerMove: anInteger [

	"Specifies the number of slides the carousel will advance when scrolling, useful when specifying a slides-per-page greater than one. It can’t be higher than slides-per-page."

	self propertyAt: #slidesPerMove put: anInteger
]

{ #category : #accessing }
SlCarousel >> slidesPerPage [

	"Specifies how many slides should be shown at a given time."

	^ self propertyAt: #slidesPerPage
]

{ #category : #accessing }
SlCarousel >> slidesPerPage: anInteger [

	"Specifies how many slides should be shown at a given time."

	self propertyAt: #slidesPerPage put: anInteger
]

{ #category : #accessing }
SlCarousel >> updateComplete [

	"A read-only promise that resolves when the component has finished updating."

	^ self propertyAt: #updateComplete
]
