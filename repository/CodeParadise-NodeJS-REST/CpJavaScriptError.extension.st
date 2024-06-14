Extension { #name : #CpJavaScriptError }

{ #category : #'*CodeParadise-NodeJS-REST' }
CpJavaScriptError >> restResponseCode [

	^ 500
]

{ #category : #'*CodeParadise-NodeJS-REST' }
CpJavaScriptError >> restResponseString [

	^ self description
]
