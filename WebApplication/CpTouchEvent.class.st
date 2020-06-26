Class {
	#name : #CpTouchEvent,
	#superclass : #CpEvent,
	#instVars : [
		'touchPoint',
		'offset'
	],
	#category : #'WebApplication-Events'
}

{ #category : #'instance creation' }
CpTouchEvent class >> newFrom: aDictionary [

	"Create a new instance of the receiver based on the specified DOM event (a Javascript object encoded as a Dictionary)"

	| touchPoint offset |

	touchPoint := self pointFrom: aDictionary.
	offset := self offsetFrom: aDictionary.

	^ (super newFrom: aDictionary)
		touchPoint: touchPoint ;
		offset: offset ;
		yourself
]

{ #category : #accessing }
CpTouchEvent class >> type [

	^ #touch
]

{ #category : #accessing }
CpTouchEvent >> offset [

	^ offset
]

{ #category : #accessing }
CpTouchEvent >> offset: aPoint [

	offset := aPoint
]

{ #category : #accessing }
CpTouchEvent >> touchPoint [

	^ touchPoint
]

{ #category : #accessing }
CpTouchEvent >> touchPoint: aPoint [

	touchPoint := aPoint
]
