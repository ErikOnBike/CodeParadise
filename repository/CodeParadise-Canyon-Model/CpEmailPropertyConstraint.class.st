Class {
	#name : #CpEmailPropertyConstraint,
	#superclass : #CpDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CpEmailPropertyConstraint >> collectViolationsIn: aString [

	"Validate the provided String as email.
	Answer a Collection of Symbols containing the violations
	or a single Symbol representing the overall violation."

	| violations validNameCharacters validDomainCharacters parts domainName domainParts |

	"If empty a single violation is answered"
	aString isEmptyOrNil
		ifTrue: [ ^ #'constraint.empty' ].

	"See https://html.spec.whatwg.org/multipage/input.html#email-state-(type=email)"
	validNameCharacters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.!#$%&''*+/=?^_`{|}~@'.
	validDomainCharacters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.'.

	"Chop email in name and domain part"
	parts := aString findTokens: '@'.
	(parts size ~= 2 or: [ (aString occurrencesOf: $@) ~= 1 ])
		ifTrue: [ ^ #'constraint.email.format' ].

	"If invalid characters a single violation is answered, because description is rich"
	(parts first allSatisfy: [ :each | validNameCharacters includes: each ])
		ifFalse: [ ^ CpParamText key: #'constraint.email.name' with: (validNameCharacters copyFrom: 63 to: validNameCharacters size - 1) ].
	(parts second allSatisfy: [ :each | validDomainCharacters includes: each ])
		ifFalse: [ ^ #'constraint.email.domain' ].

	violations := OrderedCollection  new.
	((aString beginsWith: '@') or: [ aString endsWith: '@' ])
		ifTrue: [ violations add: #'constraint.email.at' ].
	domainName := parts second.
	((domainName beginsWith: '.') or: [ (domainName endsWith: '.') or: [ domainName includesSubstring: '..' ] ])
		ifTrue: [ violations add: #'constraint.email.dot' ].
	domainParts := domainName findTokens: '.'.
	(domainParts anySatisfy: [ :name | (name beginsWith: '-') or: [ name endsWith: '-' ] ])
		ifTrue: [ violations add: #'constraint.email.dash' ].

	^ violations
]

{ #category : #accessing }
CpEmailPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace. Upper- and lowercase are the user's preference."

	aString ifNil: [ ^ nil ].

	^ aString trim
]
