Class {
	#name : #CpChangeEvent,
	#superclass : #CpUserInterfaceEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #visiting }
CpChangeEvent >> sendTo: anObject [

	anObject handleChangeEvent: self
]
