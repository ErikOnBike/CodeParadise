Class {
	#name : #CpBrowserScreenOrientation,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-Browser-Support-Screen'
}

{ #category : #accessing }
CpBrowserScreenOrientation >> angle [

	"Returns the document's current orientation angle."

	^ self propertyAt: #angle
]

{ #category : #operations }
CpBrowserScreenOrientation >> lock: aString [

	"Locks the orientation of the containing document to its default orientation and returns a Promise."

	"The specified orientation should be one of:
	'any'
		Any of portrait-primary, portrait-secondary, landscape-primary or landscape-secondary.
	'natural'
		The natural orientation of the screen from the underlying operating system: either portrait-primary or
		landscape-primary.
	'landscape'
		An orientation where screen width is greater than the screen height. Depending on the platform convention,
		this may be landscape-primary, landscape-secondary, or both.
	'portrait'
		An orientation where screen height is greater than the screen width. Depending on the platform convention,
		this may be portrait-primary, portrait-secondary, or both.
	'portrait-primary'
		The 'primary' portrait mode. If the natural orientation is a portrait mode (screen height is greater
		than width), this will be the same as the natural orientation, and correspond to an angle of 0 degrees.
		If the natural orientation is a landscape mode, then the user agent can choose either portrait orientation
		as the portrait-primary and portrait-secondary; one of those will be assigned the angle of 90 degrees and
		the other will have an angle of 270 degrees.
	'portrait-secondary'
		The secondary portrait orientation. If the natural orientation is a portrait mode, this will have an angle
		of 180 degrees (in other words, the device is upside down relative to its natural orientation). If the
		natural orientation is a landscape mode, this can be either orientation as selected by the user agent:
		whichever was not selected for portrait-primary.
	'landscape-primary'
		The 'primary' landscape mode. If the natural orientation is a landscape mode (screen width is greater
		than height), this will be the same as the natural orientation, and correspond to an angle of 0 degrees.
		If the natural orientation is a portrait mode, then the user agent can choose either landscape orientation
		as the landscape-primary with an angle of either 90 or 270 degrees (landscape-secondary will be the other
		orientation and angle).
	'landscape-secondary'
		The secondary landscape mode. If the natural orientation is a landscape mode, this orientation is upside
		down relative to the natural orientation, and will have an angle of 180 degrees. If the natural
		orientation is a portrait mode, this can be either orientation as selected by the user agent: whichever
		was not selected for landscape-primary.
	"

	<ignoreReference: #CpJavaScriptPromise>

	^ self apply: #lock withArguments: { aString } resultAs: CpJavaScriptPromise
]

{ #category : #'event handling' }
CpBrowserScreenOrientation >> onChangeDo: aBlock [

	"Fired whenever the screen changes orientation."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #change handler: aBlock
]

{ #category : #accessing }
CpBrowserScreenOrientation >> type [

	"Returns the document's current orientation type, one of ""portrait-primary"", ""portrait-secondary"", ""landscape-primary"", or ""landscape-secondary""."

	^ self propertyAt: #type
]

{ #category : #operations }
CpBrowserScreenOrientation >> unlock [

	"Unlocks the orientation of the containing document from its default orientation."

	^ self apply: #unlock
]
