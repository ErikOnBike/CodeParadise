Extension { #name : #SequenceableCollection }

{ #category : #'*CodeParadise-WebApplication-MVP' }
SequenceableCollection >> asParameterDictionary [

	"Answer a dictionary with index -> value pairs"

	<webApplicationExtension>

	| dictionary |

	dictionary := Dictionary new: self size.
	self withIndexDo: [ :each :index | dictionary at: index put: each ].

	^ dictionary
]
