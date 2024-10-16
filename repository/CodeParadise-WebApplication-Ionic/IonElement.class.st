Class {
	#name : #IonElement,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #accessing }
IonElement class >> importBasePath [

	^ 'https://cdn.jsdelivr.net/npm/@ionic/core'
]

{ #category : #accessing }
IonElement class >> importModulePath [

	"Answer the module path for the framework"

	^ self importBasePath, '/dist/ionic/ionic.esm.js'
]

{ #category : #accessing }
IonElement class >> importScriptPath [

	"Answer the script path for the framework"

	^ self importBasePath, '/dist/ionic/ionic.js'
]

{ #category : #accessing }
IonElement class >> importThemesPath [

	"Answer the themes path for the framework"

	^ self importBasePath, '/css/ionic.bundle.css'
]

{ #category : #'class initialization' }
IonElement class >> loadLibrary [

	"Load library from CDN.

	Implementation:
	Load initial script and stylesheet here. All components will load themselves."

	CpHtmlElement
		documentAddExternalScript: self importModulePath type: 'module' id: #'ionic-module' ;
		documentAddExternalScript: self importScriptPath ;
		documentAddStylesheet: self importThemesPath
]

{ #category : #'class initialization' }
IonElement class >> postInstallOnce [

	"Install Ionic library into receiver"

	self loadLibrary
]