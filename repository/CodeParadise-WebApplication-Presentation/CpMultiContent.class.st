Class {
	#name : #CpMultiContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'contentCollection'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #'instance creation' }
CpMultiContent class >> withAll: aContentCollection [

	| instance |

	instance := self new.
	aContentCollection do: [ :each | instance addContent: each ].

	^ instance
]

{ #category : #adding }
CpMultiContent >> addContent: aContent [

	contentCollection add: aContent.

	self valueChanged.

	^ aContent
]

{ #category : #accessing }
CpMultiContent >> contentCollection [

	^ contentCollection
]

{ #category : #initialization }
CpMultiContent >> initialize [

	super initialize.

	contentCollection := OrderedCollection new
]
