Extension { #name : #CpClientPropertySlot }

{ #category : #'*CodeParadise-Canyon-App' }
CpClientPropertySlot >> label [

	"Answer the label of the receiver"

	^ self propertyValue: #label ifAbsent: [ self name ]
]
