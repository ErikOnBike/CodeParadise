Class {
	#name : #CpAnimationDemoContentView,
	#superclass : #CpCustomContentView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'event handling' }
CpAnimationDemoContentView >> handleClickEvent: aClickEvent [

	aClickEvent elementId = 'square1'
		ifTrue: [ ^ self render ].
	aClickEvent elementId = 'square2'
		ifTrue: [ ^ self renderMany ].

	super handleClickEvent: aClickEvent
]

{ #category : #rendering }
CpAnimationDemoContentView >> render [

	"Render two squares which animate"

	| element1 element2 |

	self removeChildren.
	element1 := self appendChild: ((CpHtmlElement newWithTag: #div)
		id: 'square1' ;
		styleAt: #position put: 'absolute' ;
		styleAt: #width put: '50vmin' ;
		styleAt: #height put: '50vmin' ;
		styleAt: #top put: '20vh' ;
		styleAt: #left put: '30vw' ;
		styleAt: #'background-color' put: '#C2B280' ;
		yourself).
	element2 := self appendChild: ((CpHtmlElement newWithTag: #div)
		id: 'square2' ;
		styleAt: #position put: 'absolute' ;
		styleAt: #width put: '20vmin' ;
		styleAt: #height put: '20vmin' ;
		styleAt: #top put: 'calc(20vh + 50vmin)' ;
		styleAt: #left put: 'calc(30vw + 50vmin + 30vw)' ;		
		styleAt: #'background-color' put: '#B280C2' ;
		yourself).

	CpBrowserAnimator current
		addAnimation: (CpAnimation for: [ :p |
			element1 styleAt: #transform put: 'rotate(', (360 * p) printString, 'deg)' ] duration: 1500)
		delay: 1000 ;
		addAnimation: (CpAnimation for: [ :p |
			element2 styleAt: #transform put: 'translate(', (-30 * p) printString, 'vw,0)' ] duration: 800)
		delay: 1700

]

{ #category : #rendering }
CpAnimationDemoContentView >> renderMany [

	"Render a series of squares which animate"

	| elements finalColors |

	self removeChildren.

	elements := OrderedCollection new
		add: (self appendChild: ((CpHtmlElement newWithTag: #div)
			id: 'square1' ;
			styleAt: #position put: 'absolute' ;
			styleAt: #width put: '30vmin' ;
			styleAt: #height put: '30vmin' ;
			styleAt: #bottom put: 'calc(50% + 2vmin)' ;
			styleAt: #right put: 'calc(50% + 2vmin)' ;
			yourself)) ;
		add: (self appendChild: ((CpHtmlElement newWithTag: #div)
			id: 'square2' ;
			styleAt: #position put: 'absolute' ;
			styleAt: #width put: '30vmin' ;
			styleAt: #height put: '30vmin' ;
			styleAt: #bottom put: 'calc(50% + 2vmin)' ;
			styleAt: #left put: 'calc(50% + 2vmin)' ;
			yourself)) ;
		add: (self appendChild: ((CpHtmlElement newWithTag: #div)
			styleAt: #position put: 'absolute' ;
			styleAt: #width put: '30vmin' ;
			styleAt: #height put: '30vmin' ;
			styleAt: #top put: 'calc(50% + 2vmin)' ;
			styleAt: #right put: 'calc(50% + 2vmin)' ;
			yourself)) ;
		add: (self appendChild: ((CpHtmlElement newWithTag: #div)
			styleAt: #position put: 'absolute' ;
			styleAt: #width put: '30vmin' ;
			styleAt: #height put: '30vmin' ;
			styleAt: #top put: 'calc(50% + 2vmin)' ;
			styleAt: #left put: 'calc(50% + 2vmin)' ;
			yourself)) ;
		yourself.

	elements do: [ :each |
		9 timesRepeat: [
			| color |
			color := Array
				with: 255 atRandom
				with: 255 atRandom
				with: 255 atRandom.				
			each appendChild: ((CpHtmlElement newWithTag: #div)
				styleAt: #display put: 'inline-block' ;
				styleAt: #width put: 'calc(33.3333% - 12px)' ;
				styleAt: #height put: 'calc(33.3333% - 12px)' ;
				styleAt: #margin put: '6px' ;
				propertyAt: #red put: (color at: 1) ;
				propertyAt: #green put: (color at: 2) ;
				propertyAt: #blue put: (color at: 3) ;
				styleAt: #'background-color' put: '#000' ;
				yourself) ] ].

	finalColors := Array new: 4.
	finalColors at: 1 put: (Array with: 255 with: 0 with: 0).
	finalColors at: 2 put: (Array with: 0 with: 255 with: 0).
	finalColors at: 3 put: (Array with: 0 with: 0 with: 255).
	finalColors at: 4 put: (Array with: 0 with: 0 with: 0).
	CpBrowserAnimator current
		addAnimation: (CpAnimation for: [ :p |
			elements do: [ :each | each styleAt: #transform put: 'rotate(', (90 * p) printString, 'deg)' ].
			elements withIndexDo: [ :each :index | each children do: [ :eachChild |
				eachChild
					styleAt: #'background-color' put: 'rgb(',
						(p * (((finalColors at: index) at: 1) + (eachChild propertyAt: #red) / 2)) printString, ',',
						(p * (((finalColors at: index) at: 2) + (eachChild propertyAt: #green) / 2)) printString, ',',
						(p * (((finalColors at: index) at: 3) + (eachChild propertyAt: #blue) / 2)) printString, ')' ;
					styleAt: #transform put: 'scale(', (1.0 + (p > 0.5 ifTrue: [ 1 - p ] ifFalse: [ p ])) printString, ')' ] ] ] duration: 1500)
		delay: 1000
]
