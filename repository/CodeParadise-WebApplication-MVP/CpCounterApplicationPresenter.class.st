Class {
	#name : #CpCounterApplicationPresenter,
	#superclass : #CpPresenter,
	#instVars : [
		'localPresenter',
		'globalPresenter'
	],
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #accessing }
CpCounterApplicationPresenter class >> defaultViewClass [

	^ CpCounterApplicationView
]

{ #category : #view }
CpCounterApplicationPresenter >> renderView [

	localPresenter ifNil: [ localPresenter := self createChildPresenter: CpCounterPresenter atSlotNamed: #local forModel: self model local ].
	globalPresenter ifNil: [ globalPresenter := self createChildPresenter: CpCounterPresenter atSlotNamed: #global forModel: self model global ]

]
