Class {
	#name : #CpLeafletObject,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #accessing }
CpLeafletObject class >> getClass [

	"Answer the class representing the receiver"

	^ self getClassByName: (self nameWithoutPrefix withoutPrefix: #Leaflet)
]

{ #category : #accessing }
CpLeafletObject class >> getClassByName: aString [

	"Answer the Leaflet class with the specified name"

	^ CpGlobalThis
		apply: #leafletClassByName
		withArguments: { aString }
		resultAs: CpJavaScriptClass
]

{ #category : #'class initialization' }
CpLeafletObject class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement
		documentAddExternalScript: 'https://unpkg.com/leaflet@2.0.0-alpha.1/dist/leaflet-global.js' ;
		documentAddStylesheet: 'https://unpkg.com/leaflet@2.0.0-alpha.1/dist/leaflet.css'.

	"Setup function to retrieve Leaflet class by name"
	CpGlobalThis propertyAt: #leafletClassByName put: (CpJavaScriptFunction
		method: 'return L[name];'
		arguments: #('name'))
]

{ #category : #'class initialization' }
CpLeafletObject class >> postInstallOnce [

	self loadLibrary
]

{ #category : #adding }
CpLeafletObject >> addTo: aMap [

	self apply: #addTo withArguments: { aMap }
]
