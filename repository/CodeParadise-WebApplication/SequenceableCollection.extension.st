Extension { #name : 'SequenceableCollection' }

{ #category : '*CodeParadise-WebApplication' }
SequenceableCollection >> findNext: aBlock after: anInteger [

	"Return the index of the next element (start after the specified index) for which aBlock evaluates as true"

	<clientEnvironment>

	| index |

	index := anInteger.

	[ (index := index + 1) <= self size ] whileTrue: [
		(aBlock value: (self at: index))
			ifTrue: [ ^ index ] ].

	^ 0
]
