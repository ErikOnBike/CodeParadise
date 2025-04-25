Class {
	#name : #CpNodeJSSharpModule,
	#superclass : #CpNodeJSImportedModule,
	#category : #'CodeParadise-NodeJS-Sharp-Core'
}

{ #category : #accessing }
CpNodeJSSharpModule class >> moduleName [

	^ 'sharp'
]

{ #category : #accessing }
CpNodeJSSharpModule >> versions [

	"An Object containing the version numbers of sharp, libvips and (when using prebuilt binaries) its dependencies"

	^ self propertyAt: #versions
]
