Class {
	#name : #WaCarousel,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaCarousel >> autoplay [

	"When set, the slides will scroll automatically when the user is not interacting with them.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #autoplay
]

{ #category : #accessing }
WaCarousel >> autoplay: aBoolean [

	"When set, the slides will scroll automatically when the user is not interacting with them.
	
	Type: Boolean
	Default: false"

	self propertyAt: #autoplay put: aBoolean
]

{ #category : #accessing }
WaCarousel >> autoplayInterval [

	"Specifies the amount of time, in milliseconds, between each automatic scroll.
	
	Type: Number
	Default: 3000"

	^ self propertyAt: #autoplayInterval
]

{ #category : #accessing }
WaCarousel >> autoplayInterval: aNumber [

	"Specifies the amount of time, in milliseconds, between each automatic scroll.
	
	Type: Number
	Default: 3000"

	self propertyAt: #autoplayInterval put: aNumber
]

{ #category : #'accessing - convenience' }
WaCarousel >> beAutoplay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autoplay: true
]

{ #category : #'accessing - convenience' }
WaCarousel >> beLoop [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self loop: true
]

{ #category : #'accessing - convenience' }
WaCarousel >> beMouseDragging [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self mouseDragging: true
]

{ #category : #'accessing - convenience' }
WaCarousel >> beNavigation [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self navigation: true
]

{ #category : #'accessing - convenience' }
WaCarousel >> beNotAutoplay [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self autoplay: false
]

{ #category : #'accessing - convenience' }
WaCarousel >> beNotLoop [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self loop: false
]

{ #category : #'accessing - convenience' }
WaCarousel >> beNotMouseDragging [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self mouseDragging: false
]

{ #category : #'accessing - convenience' }
WaCarousel >> beNotNavigation [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self navigation: false
]

{ #category : #'accessing - convenience' }
WaCarousel >> beNotPagination [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pagination: false
]

{ #category : #'accessing - convenience' }
WaCarousel >> bePagination [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self pagination: true
]

{ #category : #actions }
WaCarousel >> goToSlide: aNumber [

	"Scrolls the carousel to the slide specified by `index`.
	
	Parameter: index (number)"

	^ self apply: #goToSlide withArguments: { aNumber }
]

{ #category : #actions }
WaCarousel >> goToSlide: aNumber behavior: aString [

	"Scrolls the carousel to the slide specified by `index`.
	
	Parameter: index (number)
	Parameter: behavior (string)"

	^ self apply: #goToSlide withArguments: { aNumber . aString }
]

{ #category : #accessing }
WaCarousel >> loop [

	"When set, allows the user to navigate the carousel in the same direction indefinitely.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #loop
]

{ #category : #accessing }
WaCarousel >> loop: aBoolean [

	"When set, allows the user to navigate the carousel in the same direction indefinitely.
	
	Type: Boolean
	Default: false"

	self propertyAt: #loop put: aBoolean
]

{ #category : #accessing }
WaCarousel >> mouseDragging [

	"When set, it is possible to scroll through the slides by dragging them with the mouse.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #mouseDragging
]

{ #category : #accessing }
WaCarousel >> mouseDragging: aBoolean [

	"When set, it is possible to scroll through the slides by dragging them with the mouse.
	
	Type: Boolean
	Default: false"

	self propertyAt: #mouseDragging put: aBoolean
]

{ #category : #accessing }
WaCarousel >> navigation [

	"When set, show the carousel's navigation.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #navigation
]

{ #category : #accessing }
WaCarousel >> navigation: aBoolean [

	"When set, show the carousel's navigation.
	
	Type: Boolean
	Default: false"

	self propertyAt: #navigation put: aBoolean
]

{ #category : #actions }
WaCarousel >> next [

	"Move the carousel forward by `slides-per-move` slides."

	^ self apply: #next
]

{ #category : #actions }
WaCarousel >> next: aString [

	"Move the carousel forward by `slides-per-move` slides.
	
	Parameter: behavior (string)"

	^ self apply: #next withArguments: { aString }
]

{ #category : #'accessing - slots' }
WaCarousel >> nextIconElement [

	"Optional next icon to use instead of the default. Works best with `<wa-icon>`."

	^ self firstChildAtSlotNamed: #'next-icon'
]

{ #category : #'accessing - slots' }
WaCarousel >> nextIconElement: anElement [

	"Optional next icon to use instead of the default. Works best with `<wa-icon>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'next-icon'
]

{ #category : #accessing }
WaCarousel >> orientation [

	"Specifies the orientation in which the carousel will lay out.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaCarousel >> orientation: aString [

	"Specifies the orientation in which the carousel will lay out.
	
	Type: String
	Default: 'horizontal'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaCarousel >> pagination [

	"When set, show the carousel's pagination indicators.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #pagination
]

{ #category : #accessing }
WaCarousel >> pagination: aBoolean [

	"When set, show the carousel's pagination indicators.
	
	Type: Boolean
	Default: false"

	self propertyAt: #pagination put: aBoolean
]

{ #category : #actions }
WaCarousel >> previous [

	"Move the carousel backward by `slides-per-move` slides."

	^ self apply: #previous
]

{ #category : #actions }
WaCarousel >> previous: aString [

	"Move the carousel backward by `slides-per-move` slides.
	
	Parameter: behavior (string)"

	^ self apply: #previous withArguments: { aString }
]

{ #category : #'accessing - slots' }
WaCarousel >> previousIconElement [

	"Optional previous icon to use instead of the default. Works best with `<wa-icon>`."

	^ self firstChildAtSlotNamed: #'previous-icon'
]

{ #category : #'accessing - slots' }
WaCarousel >> previousIconElement: anElement [

	"Optional previous icon to use instead of the default. Works best with `<wa-icon>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'previous-icon'
]

{ #category : #accessing }
WaCarousel >> slidesPerMove [

	"Specifies the number of slides the carousel will advance when scrolling, useful when specifying a `slides-per-page`
	greater than one. It can't be higher than `slides-per-page`.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #slidesPerMove
]

{ #category : #accessing }
WaCarousel >> slidesPerMove: aNumber [

	"Specifies the number of slides the carousel will advance when scrolling, useful when specifying a `slides-per-page`
	greater than one. It can't be higher than `slides-per-page`.
	
	Type: Number
	Default: 1"

	self propertyAt: #slidesPerMove put: aNumber
]

{ #category : #accessing }
WaCarousel >> slidesPerPage [

	"Specifies how many slides should be shown at a given time.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #slidesPerPage
]

{ #category : #accessing }
WaCarousel >> slidesPerPage: aNumber [

	"Specifies how many slides should be shown at a given time.
	
	Type: Number
	Default: 1"

	self propertyAt: #slidesPerPage put: aNumber
]
