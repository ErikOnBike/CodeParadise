"
I represent one of the following Constrain 'types'. These types are not classes but are
represented as regular Objects/dictionaries in the Browser.

	ConstrainBoolean
	ConstrainDOMString

See https://developer.mozilla.org/en-US/docs/Web/API/MediaTrackConstraints

"
Class {
	#name : #CpBrowserMediaTrackConstrainValue,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserMediaTrackConstrainValue >> exact [

	"Depending on whether a ConstrainBoolean or ConstrainDOMString is used:
	
	A Boolean which must be the value of the property. If the property can't be set to this value, matching will fail.
	A string or an array of strings, one of which must be the value of the property. If the property can't be set to one of the listed values, matching will fail."

	^ self propertyAt: #exact
]

{ #category : #accessing }
CpBrowserMediaTrackConstrainValue >> exact: anObject [

	"Depending on whether a ConstrainBoolean or ConstrainDOMString is used:
	
	A Boolean which must be the value of the property. If the property can't be set to this value, matching will fail.
	A string or an array of strings, one of which must be the value of the property. If the property can't be set to one of the listed values, matching will fail."

	self propertyAt: #exact put: anObject
]

{ #category : #accessing }
CpBrowserMediaTrackConstrainValue >> ideal [

	"Depending on whether a ConstrainBoolean or ConstrainDOMString is used:
	
	A Boolean specifying an ideal value for the property. If possible, this value will be used, but if it's not possible, the user agent will use the closest possible match.
	A string or an array of strings, specifying ideal values for the property. If possible, one of the listed values will be used, but if it's not possible, the user agent will use the closest possible match."

	^ self propertyAt: #ideal
]

{ #category : #accessing }
CpBrowserMediaTrackConstrainValue >> ideal: anObject [

	"Depending on whether a ConstrainBoolean or ConstrainDOMString is used:
	
	A Boolean specifying an ideal value for the property. If possible, this value will be used, but if it's not possible, the user agent will use the closest possible match.
	A string or an array of strings, specifying ideal values for the property. If possible, one of the listed values will be used, but if it's not possible, the user agent will use the closest possible match."

	self propertyAt: #ideal put: anObject
]
