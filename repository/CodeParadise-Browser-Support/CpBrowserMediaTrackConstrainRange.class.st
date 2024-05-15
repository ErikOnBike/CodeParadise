"
I represent one of the following Constrain 'types'. These types are not classes but are
represented as regular Objects/dictionaries in the Browser.

	ConstrainDouble
	ConstrainULong

See https://developer.mozilla.org/en-US/docs/Web/API/MediaTrackConstraints

"
Class {
	#name : 'CpBrowserMediaTrackConstrainRange',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-Browser-Support-MediaStreams',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'MediaStreams'
}

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange class >> getClassName [

	"Browsers implement me as a regular object/dictionary, therefore override the class I represent"

	^ 'Object'
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> exact [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying a specific, required, value the property must have to be considered acceptable.
	An integer specifying a specific, required, value the property must have to be considered acceptable."

	^ self propertyAt: #exact
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> exact: anObject [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying a specific, required, value the property must have to be considered acceptable.
	An integer specifying a specific, required, value the property must have to be considered acceptable."

	self propertyAt: #exact put: anObject
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> ideal [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying an ideal value for the property. If possible, this value will be used, but if it's not possible, the user agent will use the closest possible match.
	An integer specifying an ideal value for the property. If possible, this value will be used, but if it's not possible, the user agent will use the closest possible match."

	^ self propertyAt: #ideal
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> ideal: anObject [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying an ideal value for the property. If possible, this value will be used, but if it's not possible, the user agent will use the closest possible match.
	An integer specifying an ideal value for the property. If possible, this value will be used, but if it's not possible, the user agent will use the closest possible match."

	self propertyAt: #ideal put: anObject
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> max [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying the largest permissible value of the property it describes. If the value cannot remain equal to or less than this value, matching will fail.
	An integer specifying the largest permissible value of the property it describes. If the value cannot remain equal to or less than this value, matching will fail."

	^ self propertyAt: #max
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> max: anObject [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying the largest permissible value of the property it describes. If the value cannot remain equal to or less than this value, matching will fail.
	An integer specifying the largest permissible value of the property it describes. If the value cannot remain equal to or less than this value, matching will fail."

	self propertyAt: #max put: anObject
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> min [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying the smallest permissible value of the property it describes. If the value cannot remain equal to or greater than this value, matching will fail.
	An integer specifying the smallest permissible value of the property it describes. If the value cannot remain equal to or greater than this value, matching will fail."

	^ self propertyAt: #min
]

{ #category : 'accessing' }
CpBrowserMediaTrackConstrainRange >> min: anObject [

	"Depending on whether a ConstrainDouble or ConstrainULong is used:
	
	A decimal number specifying the smallest permissible value of the property it describes. If the value cannot remain equal to or greater than this value, matching will fail.
	An integer specifying the smallest permissible value of the property it describes. If the value cannot remain equal to or greater than this value, matching will fail."

	self propertyAt: #min put: anObject
]
