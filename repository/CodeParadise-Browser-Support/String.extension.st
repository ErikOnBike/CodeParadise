Extension { #name : 'String' }

{ #category : '*CodeParadise-Browser-Support' }
String >> asBrowserClipboardItem [

	<webApplicationExtension>

	^ CpBrowserClipboardItem newWithString: self
]
