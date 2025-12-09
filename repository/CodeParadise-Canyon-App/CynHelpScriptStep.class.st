Class {
	#name : #CynHelpScriptStep,
	#superclass : #Object,
	#instVars : [
		'selectors',
		'element'
	],
	#category : #'CodeParadise-Canyon-App-Help'
}

{ #category : #'instance creation' }
CynHelpScriptStep class >> id: aString element: anElement [

	^ self selectors: { '#', aString } element: anElement
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> id: idString html: htmlString [

	^ self selectors: { '#', idString } html: htmlString
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> id: idString text: textString [

	^ self selectors: { '#', idString } text: textString
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> ids: aCollection element: anElement [

	^ self selectors: (aCollection collect: [ :each | '#', each ]) element: anElement
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> ids: aCollection html: aString [

	^ self selectors: (aCollection collect: [ :each | '#', each ]) html: aString
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> ids: aCollection text: aString [

	^ self selectors: (aCollection collect: [ :each | '#', each ]) text: aString
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> new [

	self errorNewReplacedBy: #selectors:element:
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> selector: aString element: anElement [

	^ self selectors: { aString } element: anElement
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> selector: selectorString html: htmlString [

	^ self selectors: { selectorString } html: htmlString
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> selector: selectorString text: textString [

	^ self selectors: { selectorString } text: textString
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> selectors: aCollection element: anElement [

	^ self basicNew
		initializeWithSelectors: aCollection element: anElement ;
		yourself
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> selectors: aCollection html: aString [

	^ self
		selectors: aCollection
		element: ((CpHtmlElement newWithTag: #div)
			markupContent: aString ;
			yourself)
]

{ #category : #'instance creation' }
CynHelpScriptStep class >> selectors: aCollection text: aString [

	^ self selectors: aCollection element: (aString inHtmlTag: #p)
]

{ #category : #accessing }
CynHelpScriptStep >> element [

	^ element clone
]

{ #category : #initialization }
CynHelpScriptStep >> initializeWithSelectors: aCollection element: anElement [

	self initialize.

	selectors := aCollection.
	element := anElement
]

{ #category : #accessing }
CynHelpScriptStep >> selectors [

	^ selectors
]
