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
