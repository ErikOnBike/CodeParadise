"
I represent bulleted content in a Slide.
I have zero or more bullets, each of which can be SlideContent.

"
Class {
	#name : #CpBulletedContent,
	#superclass : #CpSlideContent,
	#instVars : [
		'bullets'
	],
	#category : #'CodeParadise-WebApplication-Presentation-Model'
}

{ #category : #adding }
CpBulletedContent >> addBullet: aSlideContent [

	self bullets add: aSlideContent.

	self valueChanged.

	^ aSlideContent
]

{ #category : #accessing }
CpBulletedContent >> bullets [

	^ bullets
]

{ #category : #initialization }
CpBulletedContent >> initialize [

	super initialize.

	bullets := OrderedCollection new
]

{ #category : #adding }
CpBulletedContent >> insertBullet: aSlideContent beforeBullet: anotherSlideContent [

	| index |

	index := self bullets indexOf: anotherSlideContent ifAbsent: [ self error: 'Unknown slide content for relative positioning' ].
	self bullets insert: aSlideContent before: index.

	self valueChanged.

	^ aSlideContent
]

{ #category : #api }
CpBulletedContent >> preferredPresenterClass [

	^ CpBulletedContentPresenter
]
