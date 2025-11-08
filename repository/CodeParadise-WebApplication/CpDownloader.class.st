Class {
	#name : #CpDownloader,
	#superclass : #Object,
	#instVars : [
		'content',
		'type'
	],
	#category : #'CodeParadise-WebApplication-Support'
}

{ #category : #performing }
CpDownloader class >> blob: aBlob filename: aString [

	"Download the specified Blob using the given filename.

	Implementation:
	Create a link <a> element with a download using an ObjectURL.
	Then fake a click on the link to perform the download."

	| url linkElement |

	"Create link"
	url := CpBrowserURL createObjectURL: aBlob.
	linkElement := (CpHtmlElement newWithTag: #a)
		styleAt: #display put: #none ;
		attributeAt: #href put: url ;
		attributeAt: #download put: aString ;
		when: CpClickEvent do: [ :event | event stopPropagation ] for: self ;
		yourself.

	"Add link to page and click it"
	CpHtmlElement documentBody
		appendChild: linkElement.
	linkElement apply: #click.

	"Clean up"
	linkElement destroy.
	CpBrowserURL revokeObjectURL: url
]

{ #category : #performing }
CpDownloader class >> content: anObject type: typeString filename: filenameString [

	self blob: (CpBrowserBlob newWith: anObject type: typeString) filename: filenameString
]
