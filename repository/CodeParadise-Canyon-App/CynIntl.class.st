Class {
	#name : #CynIntl,
	#superclass : #Object,
	#category : #'CodeParadise-Canyon-App-Internationalization'
}

{ #category : #private }
CynIntl class >> clientInternationalizationClass [

	"Answer the internationalization class for the client environment"

	^ CpBrowserIntl
]

{ #category : #accessing }
CynIntl class >> internationalizationClass [

	"Answer the concrete internationalization class for this environment"

	^ (Smalltalk classNamed: #CpServerEnvironment)
		ifNotNil: [ self serverInternationalizationClass ]
		ifNil: [ self clientInternationalizationClass ]
]

{ #category : #accessing }
CynIntl class >> pluralRulesClass [

	"Answer the plural rules class.

	Implementation:
	Based on the environment the receiver is running in, answer a Smalltalk specific
	variant or a JavaScriptObject wrapper around Intl.PluralRules."

	^ self internationalizationClass
		pluralRulesClass
]

{ #category : #private }
CynIntl class >> serverInternationalizationClass [

	"Answer the internationalization class for the server environment.

	Implementation:
	The internationalization class is either set for the current context
	or is the system wide default class. The former allows to run code
	for different internationalization needs simultaniously.

	Because the pragma <serverEnvironment> is present, will this method
	and it referred classes NOT be installed in a client environment."

	<serverEnvironment>
	
	^ CynCurrentInternationalizationContext internationalizationClass
		ifNil: [ CynInternationalization ]
]
