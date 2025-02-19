Class {
	#name : #CpAnimationDemoContentView,
	#superclass : #CpCustomContentView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #rendering }
CpAnimationDemoContentView >> render [

	"Render two squares which animate"

	| canvas element1 element2 |

	self removeChildren.
	canvas := self appendChild: ((CpHtmlElement newWithTag: #div)
		styleAt: #position put: 'absolute' ;
		styleAt: #left put: '0' ;
		styleAt: #top put: '0' ;
		styleAt: #width put: '100%' ;
		styleAt: #height put: '100%' ;
		styleAt: #overflow put: 'hidden' ;
		yourself).
	element1 := canvas appendChild: ((CpHtmlElement newWithTag: #div)
		styleAt: #cursor put: 'pointer' ;
		styleAt: #position put: 'absolute' ;
		styleAt: #width put: '30%' ;
		styleAt: #height put: '50%' ;
		styleAt: #top put: '20%' ;
		styleAt: #left put: '30%' ;
		styleAt: #'background-color' put: '#C2B280' ;
		when: CpPrimaryClickEvent send: #render to: self ;
		yourself).
	element2 := canvas appendChild: ((CpHtmlElement newWithTag: #div)
		styleAt: #cursor put: 'pointer' ;
		styleAt: #position put: 'absolute' ;
		styleAt: #width put: '20%' ;
		styleAt: #height put: '20%' ;
		styleAt: #top put: 'calc(20% + 50%)' ;
		styleAt: #left put: 'calc(30% + 30%)' ;
		styleAt: #transform put: 'translate(200px)'	 ;
		styleAt: #'background-color' put: '#004E6E' ;
		when: CpPrimaryClickEvent send: #renderMany to: self ;
		yourself).

	[ :p | element1 styleAt: #transform put: 'rotate(', (360 * p) printString, 'deg)' ] asTransition
		duration: 1500 ;
		startDelayedBy: 1000.
	[ :p | element2 styleAt: #transform put: 'translate(', ((1 - p) * 200) printString, 'px,0)' ] asTransition
		duration: 800 ;
		startDelayedBy: 1700

]

{ #category : #rendering }
CpAnimationDemoContentView >> renderMany [

	"Render a series of squares which animate"

	| elements finalColors |

	self removeChildren.

	elements := OrderedCollection new
		add: (self appendChild: ((CpHtmlElement newWithTag: #div)
			styleAt: #cursor put: 'pointer' ;
			styleAt: #position put: 'absolute' ;
			styleAt: #width put: '30vmin' ;
			styleAt: #height put: '30vmin' ;
			styleAt: #bottom put: 'calc(50% + 2vmin)' ;
			styleAt: #right put: 'calc(50% + 2vmin)' ;
			when: CpPrimaryClickEvent send: #render to: self ;
			yourself)) ;
		add: (self appendChild: ((CpHtmlElement newWithTag: #div)
			styleAt: #cursor put: 'pointer' ;
			styleAt: #position put: 'absolute' ;
			styleAt: #width put: '30vmin' ;
			styleAt: #height put: '30vmin' ;
			styleAt: #bottom put: 'calc(50% + 2vmin)' ;
			styleAt: #left put: 'calc(50% + 2vmin)' ;
			when: CpPrimaryClickEvent send: #renderMany to: self ;
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

	finalColors := Array new: 4.
	finalColors at: 1 put: (Array with: 1 with: 0.2 with: 0.2).
	finalColors at: 2 put: (Array with: 0.2 with: 1 with: 0.2).
	finalColors at: 3 put: (Array with: 0.2 with: 0.2 with: 1).
	finalColors at: 4 put: (Array with: 1 with: 1 with: 0.2).

	elements withIndexDo: [ :each :index |
		9 timesRepeat: [
			| color |
			color := Array
				with: (95 atRandom + 160) * ((finalColors at: index) at: 1)
				with: (95 atRandom + 160) * ((finalColors at: index) at: 2)
				with: (95 atRandom + 160) * ((finalColors at: index) at: 3).
			each appendChild: ((CpHtmlElement newWithTag: #div)
				styleAt: #display put: 'inline-block' ;
				styleAt: #width put: 'calc(33.3333% - 12px)' ;
				styleAt: #height put: 'calc(33.3333% - 12px)' ;
				styleAt: #margin put: '6px' ;
				propertyAt: #red put: (color at: 1) ;
				propertyAt: #green put: (color at: 2) ;
				propertyAt: #blue put: (color at: 3) ;
				styleAt: #'background-color' put: '#00384F' ;
				yourself) ] ].

	[ :p |
			| rotate |
			rotate := String streamContents: [ :stream |
				stream nextPutAll: 'rotate('.
				(360 * p) printOn: stream.
				stream nextPutAll: 'deg)' ].
			elements do: [ :each | each styleAt: #transform put: rotate ].
			elements withIndexDo: [ :each :index | each children do: [ :eachChild |
				| red green blue color scale |
				red := eachChild propertyAt: #red.
				green := eachChild propertyAt: #green.
				blue := eachChild propertyAt: #blue.
				color := String streamContents: [ :stream |
					stream nextPutAll: 'rgb('.
					(red * p) printOn: stream.
					stream nextPut: $,.
					(56 + ((green - 56) * p)) printOn: stream.
					stream nextPut: $,.
					(79 + ((blue - 79) * p)) printOn: stream.
					stream nextPut: $) ].
				scale := String streamContents: [ :stream |
					stream nextPutAll: 'scale('.
					(1.0 + (3 * (p > 0.5 ifTrue: [ 1 - p ] ifFalse: [ p ]))) printOn: stream.
					stream nextPut: $) ].
				eachChild
					styleAt: #'background-color' put: color ;
					styleAt: #transform put: scale ] ] ] asTransition
		duration: 1500 ;
		startDelayedBy: 1000
]
