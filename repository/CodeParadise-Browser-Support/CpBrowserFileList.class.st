Class {
	#name : #CpBrowserFileList,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #accessing }
CpBrowserFileList >> itemAt: anInteger [

	"Returns a File object representing the file at the specified index in the file list"

	^ self apply: #item withArguments: { anInteger } resultAs: CpBrowserFile
]

{ #category : #accessing }
CpBrowserFileList >> length [

	"A read-only value indicating the number of files in the list."

	^ self propertyAt: #length
]
