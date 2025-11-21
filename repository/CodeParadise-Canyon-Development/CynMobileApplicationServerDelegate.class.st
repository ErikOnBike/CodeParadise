Class {
	#name : #CynMobileApplicationServerDelegate,
	#superclass : #Object,
	#instVars : [
		'delegate'
	],
	#category : #'CodeParadise-Canyon-Development-Server'
}

{ #category : #api }
CynMobileApplicationServerDelegate class >> delegate: aDelegate [

	"Answer a new instance of the receiver with the specified (original) delegate"

	^ self basicNew
		initializeWithDelegate: aDelegate ;
		yourself
]

{ #category : #api }
CynMobileApplicationServerDelegate class >> new [

	self errorNewReplacedBy: #delegate:
]

{ #category : #public }
CynMobileApplicationServerDelegate >> handleRequest: aRequest [

	"Handle requests which should be mapped onto the app.
	First try regular static file delegate.
	If nothing found, find the file delegate for the app
	which is specified in the URL. Then request the app
	page itself (i.e. the 'index.html' file which loads
	the app)."

	| response |

	"First try static file handler"
	response := delegate handleRequest: aRequest.
	response isNotFound
		ifFalse: [ ^ response ].

	"Check if request is for our app itself.
	Retrieving the filename for an empty Collection is similar to asking for 'index.html'
	and prevents the need to create a URI object."
	^ delegate prefixDictionary
		at: aRequest uri firstPathSegment
		ifPresent: [ :handler | handler responseForFile: (handler actualFilenameFor: '') fromRequest: aRequest ]
		ifAbsent: [ response ] "original 404 from above"
]

{ #category : #initialization }
CynMobileApplicationServerDelegate >> initializeWithDelegate: aDelegate [

	self initialize.

	delegate := aDelegate
]

{ #category : #public }
CynMobileApplicationServerDelegate >> map: aString to: aDelegate [

	delegate map: aString to: aDelegate
]
