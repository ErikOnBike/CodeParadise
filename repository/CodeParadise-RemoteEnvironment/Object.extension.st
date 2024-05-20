Extension { #name : #Object }

{ #category : #'*CodeParadise-RemoteEnvironment' }
Object >> cpEncoded [

	"Encode the receiver as a ByteArray for transfering over network connection"

	<clientEnvironment>

	| encoder |

	encoder := CpObjectEncoder new.
	self cpEncodeWith: encoder.
	^ encoder bytes
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Object >> isErrorObject [

	"Answer whether the receiver represents an Error"

	<applicationExtension>

	^ false
]

{ #category : #'*CodeParadise-RemoteEnvironment' }
Object >> isJavaScriptObject [

	<applicationExtension>

	^ false
]
