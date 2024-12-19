Class {
	#name : #CpCurrentInternationalizationContext,
	#superclass : #DynamicVariable,
	#category : #'CodeParadise-Canyon-Model-Internationalization'
}

{ #category : #accessing }
CpCurrentInternationalizationContext class >> internationalizationClass [

	^ self value
]
