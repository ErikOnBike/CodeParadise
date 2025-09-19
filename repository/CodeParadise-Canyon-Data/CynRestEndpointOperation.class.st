Class {
	#name : #CynRestEndpointOperation,
	#superclass : #CpNodeJSRestEndpointOperation,
	#category : #'CodeParadise-Canyon-Data-Service'
}

{ #category : #performing }
CynRestEndpointOperation >> handleRequest: aRestRequest response: aRestResponse [

	| start rowId |

	start := CpNodeJSRestHttpServer timerNow.

	aRestRequest propertyAt: #start put: start.
	rowId := CynBaseRestApiService serviceImplementation
		logInfoMessage: ('{1} {2}' format: { aRestRequest method . aRestRequest url }) request: aRestRequest.
	aRestRequest propertyAt: #rowId put: rowId.

	super handleRequest: aRestRequest response: aRestResponse.

	"Update the log with the response"
	CynBaseRestApiService serviceImplementation
		updateLogResponse: aRestResponse
]

{ #category : #performing }
CynRestEndpointOperation >> writeError: anError response: aRestResponse [

	super writeError: anError response: aRestResponse.

	CynBaseRestApiService serviceImplementation
		updateLogError: anError response: aRestResponse
]
