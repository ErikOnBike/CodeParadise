Class {
	#name : #CpNodeJSSharpCacheOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #'accessing - structure variables' }
CpNodeJSSharpCacheOptions >> files [

	"Is the maximum number of files to hold open.

	Type: Integer
	Default: 20"

	^ options at: #files
]

{ #category : #'accessing - structure variables' }
CpNodeJSSharpCacheOptions >> files: anInteger [

	"Is the maximum number of files to hold open.

	Type: Integer
	Default: 20"

	options at: #files put: anInteger
]

{ #category : #'accessing - structure variables' }
CpNodeJSSharpCacheOptions >> items [

	"Is the maximum number of operations to cache.

	Type: Integer
	Default: 100"

	^ options at: #items
]

{ #category : #'accessing - structure variables' }
CpNodeJSSharpCacheOptions >> items: anInteger [

	"Is the maximum number of operations to cache.

	Type: Integer
	Default: 100"

	options at: #items put: anInteger
]

{ #category : #'accessing - structure variables' }
CpNodeJSSharpCacheOptions >> memory [

	"Is the maximum memory in MB to use for this cache.

	Type: Integer
	Default: 50"

	^ options at: #memory
]

{ #category : #'accessing - structure variables' }
CpNodeJSSharpCacheOptions >> memory: anInteger [

	"Is the maximum memory in MB to use for this cache.

	Type: Integer
	Default: 50"

	options at: #memory put: anInteger
]
