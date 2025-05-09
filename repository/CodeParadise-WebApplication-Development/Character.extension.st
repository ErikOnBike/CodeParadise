Extension { #name : #Character }

{ #category : #'*CodeParadise-WebApplication-Development' }
Character >> isAllowedInWebResourceId [

	"Answer a Boolean stating whether the receiver is an allowed Character in a
	web resource identifier. The set is limited to alphanumeric values and the
	dot, dash and underscore. These are the regular Characters used in either an
	id or class attribute.
	This method is assumed to be used only during development for finding
	references to Symbols used in id or class attributes.
	Be aware that the identifiers CodeParadise generates for identifiers use a
	broader set of Characters, but these are not used in stylesheets and are
	only referenced explicitly (i.e. don't require this method)."

	<serverEnvironment>

	^ self isAlphaNumeric or: [ #($. $- $_) includes: self ]
]
