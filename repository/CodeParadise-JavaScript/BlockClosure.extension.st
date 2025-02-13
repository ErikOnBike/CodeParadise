Extension { #name : #BlockClosure }

{ #category : #'*CodeParadise-JavaScript' }
BlockClosure >> forkedOn: aClass do: aBlock [

	"Evaluate the receiver with the specified error handler Block
	in a separate Process. This method is useful in combination
	with CpJavaScriptPromise >> #await which requires to run in a
	regular Process (not in the event handler Process)."

	<applicationExtension>

	[ self on: aClass do: aBlock ] fork
]

{ #category : #'*CodeParadise-JavaScript' }
BlockClosure >> forkedOnErrorDo: aBlock [

	"Evaluate the receiver with the specified error handler Block
	in a separate Process. This method is useful in combination
	with CpJavaScriptPromise >> #await which requires to run in a
	regular Process (not in the event handler Process)."

	<applicationExtension>

	[ self on: Error do: aBlock ] fork
]
