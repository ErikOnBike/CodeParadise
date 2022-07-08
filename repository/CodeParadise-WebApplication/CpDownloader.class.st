Class {
	#name : #CpDownloader,
	#superclass : #Object,
	#instVars : [
		'content',
		'type'
	],
	#category : #'CodeParadise-WebApplication-DOM'
}

{ #category : #performing }
CpDownloader class >> content: anObject type: typeString filename: filenameString [

	"Download the specified content (of the specified MIME type) using the given filename"

	CpDomElement globalApply: #cpDownload withArguments: { anObject . typeString . filenameString }
]

{ #category : #accessing }
CpDownloader class >> downloadContentScript [

	^ 'window.cpDownload = function(content, type, filename) {
	const blob = new Blob([ content ], { type: type });
	const objectURL = URL.createObjectURL(blob);
	const linkElement = document.createElement("a");
	linkElement.style.display = "none";
	linkElement.href = objectURL;
	linkElement.download = filename;
	document.body.appendChild(linkElement);
	linkElement.click();
	document.body.removeChild(linkElement);
	URL.revokeObjectURL(objectURL);
}'
]

{ #category : #'class initialization' }
CpDownloader class >> postInstall [

	super postInstall.

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #script)
		textContent: self downloadContentScript ;
		yourself)
]
