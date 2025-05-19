Class {
	#name : #CynSnapshot,
	#superclass : #Object,
	#category : #'CodeParadise-Canyon-App-Support'
}

{ #category : #'class initialization' }
CynSnapshot class >> beLoaded [

	CpBrowserSnapshot beLoaded
]

{ #category : #'class initialization' }
CynSnapshot class >> postInstallOnce [

	self traceCr: 'Removing content'.
	CpHtmlElement documentBody removeChildren.

	self traceCr: 'Performing snapshot'.
	CpBrowserSnapshot saveSnapshot
]
