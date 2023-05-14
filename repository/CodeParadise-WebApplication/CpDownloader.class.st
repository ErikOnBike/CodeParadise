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

	"Answer a Javascript download script.

	Implementation:
	When an event handler is producing another event, the SqueakJS VM
	stack might become unbalanced. This is because events are handled
	with high priority and primitive methods currently don't mix well
	in the scheduling (some event handling is done through primitive
	methods). Therefore we need to prevent the 'generated' click event
	from bubbling right here (by using stopPropagation() which will not
	stop the click event itself, but simply prevent other DOM elements
	from receiving the event)."

	^ 'window.cpDownload = function(content, type, filename) {
	const blob = new Blob([ content ], { type: type });
	const objectURL = URL.createObjectURL(blob);
	const linkElement = document.createElement("a");
	linkElement.addEventListener("click", function(event) { event.stopPropagation(); });
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

	CpHtmlElement documentAddScript: self downloadContentScript
]
