Extension { #name : #String }

{ #category : #'*CodeParadise-Browser-Support' }
String >> asBrowserClipboardItem [

	<webApplicationExtension>
	<ignoreReference: #CpBrowserClipboardItem>

	^ CpBrowserClipboardItem newWithString: self
]
