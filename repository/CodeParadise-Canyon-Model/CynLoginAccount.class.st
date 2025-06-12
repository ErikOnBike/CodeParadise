Class {
	#name : #CynLoginAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#password => CynPropertySlot',
		'#expires => CynPropertySlot',
		'#success => CynPropertySlot',
		'#settings => CynPropertySlot',
		'#isExpired'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #'accessing - generated' }
CynLoginAccount class >> allPropertyNames [

	"Generated code. DO NOT EDIT"

	^ #(id task email password expires success settings)
]

{ #category : #accessing }
CynLoginAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CynPasswordPropertyConstraint default to: constraints. 
	self for: #expires addConstraint: (CynSelectionPropertyConstraint selection: #(usage day never)) to: constraints.

	^ constraints
]

{ #category : #'accessing - generated' }
CynLoginAccount class >> readWriteProperties [

	"Generated code. DO NOT EDIT"

	^ #(id task email password expires success settings)
]

{ #category : #accessing }
CynLoginAccount >> expires [

	^ expires
]

{ #category : #testing }
CynLoginAccount >> hasPasswordValue [

	^ password isEmptyOrNil not
]

{ #category : #initialization }
CynLoginAccount >> initialize [

	"Initialize the receiver"

	super initialize.

	"Only used in the browser to mark an expired login"
	isExpired := false
]

{ #category : #initialization }
CynLoginAccount >> initializeProperties [

	super initializeProperties.

	task := #login.
	expires := #day.
	success := false.
	settings := Dictionary new
]

{ #category : #accessing }
CynLoginAccount >> password [

	^ password
]

{ #category : #accessing }
CynLoginAccount >> resetPassword [

	password := nil
]

{ #category : #accessing }
CynLoginAccount >> settingAt: aSymbol [

	^ settings at: aSymbol ifAbsent: [ nil ]
]
