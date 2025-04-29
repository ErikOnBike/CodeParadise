Class {
	#name : #CynLoginAccount,
	#superclass : #CynAccount,
	#instVars : [
		'#password => CpPropertySlot',
		'#expires => CpPropertySlot',
		'#success => CpPropertySlot',
		'#settings => CpPropertySlot'
	],
	#category : #'CodeParadise-Canyon-Model-Core'
}

{ #category : #accessing }
CynLoginAccount class >> propertyConstraints [

	| constraints |

	constraints := super propertyConstraints.

	self for: #password addConstraint: CynPasswordPropertyConstraint default to: constraints. 
	self for: #expires addConstraint: (CynSelectionPropertyConstraint selection: #(usage day never)) to: constraints.

	^ constraints
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
CynLoginAccount >> initializeProperties [

	super initializeProperties.

	task := #login.
	expires := #day.
	success := false
]

{ #category : #accessing }
CynLoginAccount >> password [

	^ password
]

{ #category : #accessing }
CynLoginAccount >> resetPassword [

	password := nil
]
