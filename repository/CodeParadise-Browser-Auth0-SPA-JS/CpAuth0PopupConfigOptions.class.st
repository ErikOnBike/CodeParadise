Class {
	#name : #CpAuth0PopupConfigOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0PopupConfigOptions >> closePopup [

	^ options at: #closePopup:
]

{ #category : #accessing }
CpAuth0PopupConfigOptions >> closePopup: aBoolean [

	options at: #closePopup put: aBoolean
]

{ #category : #accessing }
CpAuth0PopupConfigOptions >> popup [

	"Accepts an already-created popup window to use. If not specified, the SDK will create its own. This may be useful for platforms like iOS that have security restrictions around when popups can be invoked (e.g. from a user click event)"

	^ options at: #popup:
]

{ #category : #accessing }
CpAuth0PopupConfigOptions >> popup: anElement [

	"Accepts an already-created popup window to use. If not specified, the SDK will create its own. This may be useful for platforms like iOS that have security restrictions around when popups can be invoked (e.g. from a user click event)"

	options at: #popup put: anElement
]

{ #category : #accessing }
CpAuth0PopupConfigOptions >> timeoutInSeconds [

	^ options at: #timeoutInSeconds:
]

{ #category : #accessing }
CpAuth0PopupConfigOptions >> timeoutInSeconds: anInteger [

	options at: #timeoutInSeconds put: anInteger
]
