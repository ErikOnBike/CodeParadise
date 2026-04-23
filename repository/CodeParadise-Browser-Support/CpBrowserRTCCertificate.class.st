Class {
	#name : #CpBrowserRTCCertificate,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-WebRTC'
}

{ #category : #accessing }
CpBrowserRTCCertificate >> expires [

	"Returns the expiration date of the certificate."

	^ self propertyAt: #expires resultAs: CpJavaScriptDate
]

{ #category : #operations }
CpBrowserRTCCertificate >> getFingerprints [

	"Returns an array of certificate fingerprints, calculated using the different algorithms supported by the browser."

	^ self apply: #getFingerprints
]
