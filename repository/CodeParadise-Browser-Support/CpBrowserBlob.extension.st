Extension { #name : #CpBrowserBlob }

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserBlob >> asBrowserClipboardItem [

	<ignoreReference: #CpBrowserClipboardItem>

	^ CpBrowserClipboardItem newWithBlob: self
]
