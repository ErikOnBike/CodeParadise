Class {
	#name : #CynEmailPropertyConstraint,
	#superclass : #CynDefaultPropertyConstraint,
	#category : #'CodeParadise-Canyon-Model-Constraints'
}

{ #category : #accessing }
CynEmailPropertyConstraint >> normalize: aString [

	"Normalize the specified value.
	Only trim whitespace. Upper- and lowercase are the user's preference."

	aString ifNil: [ ^ nil ].

	^ aString trim
]

{ #category : #validating }
CynEmailPropertyConstraint >> violationsForValue: aString in: aModel do: aBlock [

	"Validate the provided String as email"

	| validNameCharacters validDomainCharacters parts domainName domainParts |

	"If empty a single violation is given"
	aString ifEmptyOrNil: [ ^ aBlock value: #'constraint.empty' ].

	"See https://html.spec.whatwg.org/multipage/input.html#email-state-(type=email)"
	validNameCharacters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.!#$%&''*+/=?^_`{|}~@'.
	validDomainCharacters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.'.

	"Chop email in name and domain part"
	parts := aString findTokens: '@'.
	(parts size > 2 or: [ (aString occurrencesOf: $@) ~= 1 ])
		ifTrue: [ ^ aBlock value: #'constraint.email.format' ].

	"Make sure there are no empty parts"
	((aString beginsWith: '@') or: [ aString endsWith: '@' ])
		ifTrue: [ ^ aBlock value: #'constraint.email.at' ].

	"If invalid characters a single violation is given, because description is rich"
	(parts first allSatisfy: [ :each | validNameCharacters includes: each ])
		ifFalse: [ ^ aBlock value: (CynTextReference key: #'constraint.email.name' with: (validNameCharacters copyFrom: 63 to: validNameCharacters size - 1)) ].
	(parts second allSatisfy: [ :each | validDomainCharacters includes: each ])
		ifFalse: [ ^ aBlock value: #'constraint.email.domain' ].

	"Make sure domain has at least one dot"
	domainName := parts second.
	(domainName includes: $.)
		ifFalse: [ ^ aBlock value: #'constraint.email.domain.dot.missing' ].

	"From here on, multiple violations can be processed. Do not return from this method until everything is checked."
	((domainName beginsWith: '.') or: [ (domainName endsWith: '.') or: [ domainName includesSubstring: '..' ] ])
		ifTrue: [ aBlock value: #'constraint.email.domain.dot.position' ].
	domainParts := domainName findTokens: '.'.
	(domainParts anySatisfy: [ :name | (name beginsWith: '-') or: [ name endsWith: '-' ] ])
		ifTrue: [ aBlock value: #'constraint.email.domain.dash' ]
]
