Class {
	#name : #CpApplicationPresenter,
	#superclass : #CpPresenter,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpApplicationPresenter class >> defaultViewClass [

	"The default View for the receiver is the (full) screen"

	^ CpScreen
]

{ #category : #accessing }
CpApplicationPresenter class >> id [

	"Answer the (fixed) default id of the receiver's instance.

	Implementation: There should be only one instance of the receiver per application."

	^ #scrn
]

{ #category : #initialization }
CpApplicationPresenter >> initialize [

	super initialize.

	id := self class id
]
