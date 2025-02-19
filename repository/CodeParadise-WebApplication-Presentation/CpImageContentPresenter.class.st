"
I am a SlideContent Presenter specialized in ImageContent.
I support a ImageContentModel and use ImageContentView.
"
Class {
	#name : #CpImageContentPresenter,
	#superclass : #CpSlideContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Presenter'
}

{ #category : #model }
CpImageContentPresenter >> hasHeight [

	^ self height notNil
]

{ #category : #model }
CpImageContentPresenter >> hasWidth [

	^ self width notNil
]

{ #category : #model }
CpImageContentPresenter >> height [

	^ self model height
]

{ #category : #view }
CpImageContentPresenter >> renderView [

	(self hasWidth or: [ self hasHeight ])
		ifNotNil: [ :size | self view renderImage: self model url width: self width height: self height ]
		ifNil: [ self view renderImage: self model url ]
]

{ #category : #model }
CpImageContentPresenter >> width [

	^ self model width
]
