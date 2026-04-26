Class {
	#name : #CpLeaflet,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Leaflet-Core'
}

{ #category : #accessing }
CpLeaflet class >> getClassByName: aString [

	"Answer the Leaflet class with the specified name"

	^ CpGlobalThis
		apply: #leafletClassByName
		withArguments: { aString }
		resultAs: CpJavaScriptClass
]

{ #category : #'class initialization' }
CpLeaflet class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement documentAddExternalScript: 'https://unpkg.com/leaflet@2.0.0-alpha.1/dist/leaflet-global.js'.

	"Setup function to retrieve Leaflet class by name"
	CpGlobalThis propertyAt: #leafletClassByName put: (CpJavaScriptFunction
		method: 'return L[name];'
		arguments: #('name'))
]

{ #category : #accessing }
CpLeaflet class >> map [

	^ self getClassByName: #Map
]

{ #category : #'class initialization' }
CpLeaflet class >> postInstallOnce [

	self loadLibrary
]
