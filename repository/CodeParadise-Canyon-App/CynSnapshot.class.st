Class {
	#name : #CynSnapshot,
	#superclass : #CpEvent,
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'class initialization' }
CynSnapshot class >> beLoaded [

	CpBrowserSnapshot beLoaded
]

{ #category : #'class initialization' }
CynSnapshot class >> postSnapshotOnce [

	self traceCr: 'Canyon post snapshot'.

	"HACK!"
	Smalltalk at: #CpTransition put: CynApp
]

{ #category : #'class initialization' }
CynSnapshot class >> preSnapshotOnce [

	self traceCr: 'Canyon pre snapshot'.

	CpHtmlElement documentBody removeChildren. 

	CynApp preSnapshotOnce
]
