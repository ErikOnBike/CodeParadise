Class {
	#name : #CpGlobalStaticFileServerDelegate,
	#superclass : #ZnStaticFileServerDelegate,
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #private }
CpGlobalStaticFileServerDelegate >> indexFileIn: fileDirectory [

	"Answer the index file in the specified directory.

	Implementation:
	In addition to the default 'index.html' and 'index.htm' the CodeParadise 'app.html'
	is also allowed.
	Implementation is the same as the superclass' except for some layout and the
	additional filename to check for."

	#('index.html' 'index.htm' 'app.html') do: [ :each |
		| file |
		(file := fileDirectory / each) exists
			ifTrue: [ ^ file fullName ] ].

	^ nil
]

{ #category : #testing }
CpGlobalStaticFileServerDelegate >> isGlobalStaticFileServerDelegate [

	^ true
]
