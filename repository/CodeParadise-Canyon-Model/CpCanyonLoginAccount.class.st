Class {
	#name : #CpCanyonLoginAccount,
	#superclass : #CpCanyonAccount,
	#instVars : [
		'#password => CpPropertySlot',
		'#expires => CpPropertySlot',
		'#success => CpPropertySlot',
		'#settings => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CpCanyonLoginAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CpPasswordPropertyConstraint default to: constraints. 

	self for: #expires addConstraint: (CpSelectionPropertyConstraint selection: #(usage day never)) to: constraints.

	^ constraints
]

{ #category : #accessing }
CpCanyonLoginAccount >> expires [

	^ expires
]

{ #category : #testing }
CpCanyonLoginAccount >> hasPasswordValue [

	^ password isEmptyOrNil not
]

{ #category : #initialization }
CpCanyonLoginAccount >> initializeProperties [

	super initializeProperties.

	task := #login.
	expires := #day.
	success := false
]

{ #category : #accessing }
CpCanyonLoginAccount >> password [

	^ password
]

{ #category : #accessing }
CpCanyonLoginAccount >> resetPassword [

	password := nil
]
