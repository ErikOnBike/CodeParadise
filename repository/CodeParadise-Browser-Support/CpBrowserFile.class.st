Class {
	#name : #CpBrowserFile,
	#superclass : #CpBrowserBlob,
	#category : #'CodeParadise-Browser-Support-Core'
}

{ #category : #accessing }
CpBrowserFile >> lastModified [

	"Returns the last modified time of the file, in millisecond since the UNIX epoch (January 1st, 1970 at Midnight)"

	^ self propertyAt: #lastModified
]

{ #category : #accessing }
CpBrowserFile >> name [

	"Returns the name of the file referenced by the File object"

	^ self propertyAt: #name
]

{ #category : #printing }
CpBrowserFile >> printOn: aStream [

	aStream
		nextPutAll: 'File(name: ' ;
		nextPutAll: self name asString ;
		nextPut: $)
]

{ #category : #accessing }
CpBrowserFile >> webkitRelativePath [

	"Returns the path the URL of the File is relative to"

	^ self propertyAt: #webkitRelativePath
]
