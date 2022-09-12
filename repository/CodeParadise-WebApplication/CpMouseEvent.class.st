Class {
	#name : #CpMouseEvent,
	#superclass : #CpUserInterfaceEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #accessing }
CpMouseEvent >> button [

	"Answer an Integer specifying the button pressed.
	The following number is answered:
		0: main button (usually the left button or the un-initialized state)
		1: auxiliary button (usually the wheel button or the middle button)
		2: secondary button (usually the right button or pen button)
		3: fourth button (typically the Browser Back button)
		4: fifth button (typically the Browser Forward button)
		5: eraser button (on pens, not sure about browser support)"

	^ self propertyAt: #button
]

{ #category : #accessing }
CpMouseEvent >> buttonCount [

	^ self buttons bitCount
]

{ #category : #accessing }
CpMouseEvent >> buttons [

	"Answer an Integer specifying the different buttons pressed.
	Combine the following individual numbers:
		1 - primary button (like left button)
		2 - secondary button (like right button or pen button)
		4 - third (auxiliary) button (like wheel mouse or middle button)
		8 - fourth button (sometimes 'back' button)
		16 - fifth button (sometimes 'forward' button)
		32 - sixth button (sometimes pen eraser button)

	If no buttons are down the value 0 is answered.
	On some hardware, browsers and OS combinations the value might be
	derived (like a single mouse button emulating right click by using
	combination with key modifier or a customized setup swapping left
	and right buttons on a mouse.)"

	^ self propertyAt: #buttons
]

{ #category : #accessing }
CpMouseEvent >> clientX [

	^ self propertyAt: #clientX
]

{ #category : #accessing }
CpMouseEvent >> clientY [

	^ self propertyAt: #clientY
]

{ #category : #testing }
CpMouseEvent >> isFifthButtonPressed [

	^ self buttons anyMask: 16
]

{ #category : #testing }
CpMouseEvent >> isFourthButtonPressed [

	^ self buttons anyMask: 8
]

{ #category : #testing }
CpMouseEvent >> isNoButtonPressed [

	^ self buttons = 0
]

{ #category : #testing }
CpMouseEvent >> isOnlyPrimaryButtonPressed [

	^ self buttons = 1
]

{ #category : #testing }
CpMouseEvent >> isOnlySecondaryButtonPressed [

	^ self buttons = 2
]

{ #category : #testing }
CpMouseEvent >> isPrimaryButtonPressed [

	^ self buttons anyMask: 1
]

{ #category : #testing }
CpMouseEvent >> isSecondaryButtonPressed [

	^ self buttons anyMask: 2
]

{ #category : #testing }
CpMouseEvent >> isThirdButtonPressed [

	^ self buttons anyMask: 4
]

{ #category : #accessing }
CpMouseEvent >> modifierCount [

	^ self modifiers bitCount
]

{ #category : #accessing }
CpMouseEvent >> movementX [

	^ self propertyAt: #movementX
]

{ #category : #accessing }
CpMouseEvent >> movementY [

	^ self propertyAt: #movementY
]

{ #category : #accessing }
CpMouseEvent >> offset [

	^ self offsetX @ self offsetY
]

{ #category : #accessing }
CpMouseEvent >> offsetX [

	^ self propertyAt: #offsetX
]

{ #category : #accessing }
CpMouseEvent >> offsetY [

	^ self propertyAt: #offsetY
]

{ #category : #accessing }
CpMouseEvent >> pageX [

	^ self propertyAt: #pageX
]

{ #category : #accessing }
CpMouseEvent >> pageY [

	^ self propertyAt: #pageY
]

{ #category : #accessing }
CpMouseEvent >> point [

	^ self pageX @ self pageY
]

{ #category : #printing }
CpMouseEvent >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ', point: ' ;
		print: self point ;
		nextPutAll: ', offset: ' ;
		print: self offset ;
		nextPutAll: ', button: ' ;
		print: self button ;
		nextPutAll: ', buttons: ' ;
		print: self buttons ;
		nextPut: $( ; 
		print: self buttons ;
		nextPut: $) ; 
		nextPutAll: ', modifiers: ' ;
		print: self modifiers
]

{ #category : #accessing }
CpMouseEvent >> relatedTarget [

	"Answer the related target DOM element which received the event"

	^ self propertyAt: #relatedTarget
]

{ #category : #accessing }
CpMouseEvent >> screenX [

	^ self propertyAt: #screenX
]

{ #category : #accessing }
CpMouseEvent >> screenY [

	^ self propertyAt: #screenY
]
