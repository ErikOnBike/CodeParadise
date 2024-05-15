"
I am a DOM Element and I represent a XML Element.

I add namespace support to my DOM Element interface. When a XML (ie non-HTML) Element is present in the DOM an instance of me or one of my subclasses is answered when querying this element.

"
Class {
	#name : 'CpXmlElement',
	#superclass : 'CpDomElement',
	#category : 'CodeParadise-WebApplication-DOM',
	#package : 'CodeParadise-WebApplication',
	#tag : 'DOM'
}

{ #category : 'class initialization' }
CpXmlElement class >> namespace [

	^ 'http://www.w3.org/XML/1998/namespace'
]

{ #category : 'instance creation' }
CpXmlElement class >> newWithTag: tagString [

	"Create a new instance of the receiver using the specified tag.
	XML tags require prefixing if used within the browser DOM"

	^ super newWithTag: (self tag: tagString withPrefix: self prefix)
]

{ #category : 'accessing' }
CpXmlElement class >> prefix [

	^ #xml
]
