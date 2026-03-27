Class {
	#name : #CpAuth0LogoutParams,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-Browser-Auth0-SPA-JS-Support'
}

{ #category : #accessing }
CpAuth0LogoutParams >> federated [

	^ options at: #federated:
]

{ #category : #accessing }
CpAuth0LogoutParams >> federated: aBoolean [

	options at: #federated put: aBoolean
]

{ #category : #accessing }
CpAuth0LogoutParams >> returnTo [

	^ options at: #returnTo:
]

{ #category : #accessing }
CpAuth0LogoutParams >> returnTo: aString [

	options at: #returnTo put: aString
]
