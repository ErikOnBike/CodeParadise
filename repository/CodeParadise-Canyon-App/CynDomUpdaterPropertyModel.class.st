Class {
	#name : #CynDomUpdaterPropertyModel,
	#superclass : #CpDomUpdaterDataObject,
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #accessing }
CynDomUpdaterPropertyModel >> at: aString ifAbsent: aBlock [

	^ self overrideAt: aString ifAbsent: [
		data at: aString ifAbsent: [ data perform: aString asSymbol ] ]
]
