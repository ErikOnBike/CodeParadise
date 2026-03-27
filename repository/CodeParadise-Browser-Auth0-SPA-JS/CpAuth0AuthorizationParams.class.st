Class {
	#name : #CpAuth0AuthorizationParams,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0AuthorizationParams >> acr_values [

	^ options at: #acr_values:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> acr_values: aString [

	options at: #acr_values put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> audience [

	^ options at: #audience:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> audience: aString [

	options at: #audience put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> connection [

	^ options at: #connection:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> connection: aString [

	options at: #connection put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> display [

	" 'page' | 'popup' | 'touch' | 'wap' "

	^ options at: #display:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> display: aString [

	" 'page' | 'popup' | 'touch' | 'wap' "

	options at: #display put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> id_token_hint [

	^ options at: #id_token_hint:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> id_token_hint: aString [

	options at: #id_token_hint put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> invitation [

	^ options at: #invitation:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> invitation: aString [

	options at: #invitation put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> login_hint [

	^ options at: #login_hint:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> login_hint: aString [

	options at: #login_hint put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> max_age [

	^ options at: #max_age:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> max_age: anInteger [

	options at: #max_age put: anInteger
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> organization [

	^ options at: #organization:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> organization: aString [

	options at: #organization put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> prompt [

	" 'none' | 'login' | 'consent' | 'select_account' "

	^ options at: #prompt:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> prompt: aString [

	" 'none' | 'login' | 'consent' | 'select_account' "

	options at: #prompt put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> redirect_uri [

	^ options at: #redirect_uri:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> redirect_uri: aString [

	options at: #redirect_uri put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> scope [

	^ options at: #scope:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> scope: aString [

	options at: #scope put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> screen_hint [

	^ options at: #screen_hint:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> screen_hint: aString [

	options at: #screen_hint put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> session_transfer_token [

	^ options at: #session_transfer_token:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> session_transfer_token: aString [

	options at: #session_transfer_token put: aString
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> ui_locales [

	^ options at: #ui_locales:
]

{ #category : #accessing }
CpAuth0AuthorizationParams >> ui_locales: aString [

	options at: #ui_locales put: aString
]
