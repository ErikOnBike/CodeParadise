Class {
	#name : 'CpSourceCodeRequest',
	#superclass : 'Announcement',
	#instVars : [
		'className',
		'selector',
		'openBrowser'
	],
	#category : 'CodeParadise-WebApplication-Debugger-Announcements',
	#package : 'CodeParadise-WebApplication-Debugger',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
CpSourceCodeRequest class >> className: aString selector: aSymbol openBrowser: aBoolean [

	^ self basicNew
		initializeWithClassName: aString selector: aSymbol openBrowser: aBoolean ;
		yourself
]

{ #category : 'accessing' }
CpSourceCodeRequest class >> context: aContext [

	^ self context: aContext openBrowser: false
]

{ #category : 'accessing' }
CpSourceCodeRequest class >> context: aContext openBrowser: aBoolean [

	| method |

	method := aContext method.

	^ self className: method methodClass name selector: method selector openBrowser: aBoolean
]

{ #category : 'accessing' }
CpSourceCodeRequest class >> openBrowserOnContext: aContext [

	^ self context: aContext openBrowser: true
]

{ #category : 'accessing' }
CpSourceCodeRequest >> className [

	^ className
]

{ #category : 'initialization' }
CpSourceCodeRequest >> initializeWithClassName: aString selector: aSymbol openBrowser: aBoolean [

	self initialize.

	className := aString.
	selector := aSymbol.
	openBrowser := aBoolean
]

{ #category : 'accessing' }
CpSourceCodeRequest >> openBrowser [

	^ openBrowser
]

{ #category : 'accessing' }
CpSourceCodeRequest >> selector [

	^ selector
]
