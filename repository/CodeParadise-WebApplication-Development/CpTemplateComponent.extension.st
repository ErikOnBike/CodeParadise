Extension { #name : #CpTemplateComponent }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpTemplateComponent class >> thoroughWhichMethodsReferTo: literal specialIndex: specialIndex [

	"Answer the receiver's methods which refer to the argument as a literal.

	Implementation:
	Test for words inside the special resource methods to find references in HTML/CSS."

	<serverEnvironment>

	| methods |

	methods := super thoroughWhichMethodsReferTo: literal specialIndex: specialIndex.

	"Add special behavior to check for reference in web resource method"
	self classSide methods do: [ :method |
		(method isWebResourceMethod and: [ (method webResourceRefersTo: literal) and: [ (methods includes: method) not ] ])
			ifTrue: [
				methods isArray
					ifTrue: [ methods := methods asOrderedCollection ].
				methods add: method ] ].

	"Convert Collection back to Array (just in case)"
	methods isArray
		ifFalse: [ methods := methods asArray ].

	^ methods
]
