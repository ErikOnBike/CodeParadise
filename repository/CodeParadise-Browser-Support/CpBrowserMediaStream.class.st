Class {
	#name : #CpBrowserMediaStream,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #'instance creation' }
CpBrowserMediaStream class >> newInstanceWithStream: aMediaStream [

	"Create an instance of the receiver based on another MediaStream.
	A different MediaStream object whose tracks are added to the newly-created stream automatically. The tracks are not removed from the original stream, so they're shared by the two streams."

	^ self newInstanceWithArguments: { aMediaStream }
]

{ #category : #'instance creation' }
CpBrowserMediaStream class >> newInstanceWithTracks: anArray [

	"Create an instance of the receiver based on an Array of MediaStreamTrack.
	An Array of MediaStreamTrack objects, one for each track to add to the stream."

	^ self newInstanceWithArguments: { anArray }
]

{ #category : #accessing }
CpBrowserMediaStream >> active [

	"A Boolean value that returns true if the MediaStream is active, or false otherwise."

	^ self propertyAt: #active
]

{ #category : #operations }
CpBrowserMediaStream >> addTrack: aMediaStreamTrack [

	"Stores a copy of the MediaStreamTrack given as argument. If the track has already been added to the MediaStream object, nothing happens."

	self apply: #addTrack withArguments: { aMediaStreamTrack }
]

{ #category : #operations }
CpBrowserMediaStream >> clone [

	"Returns a clone of the MediaStream object. The clone will, however, have a unique value for id."

	^ self apply: #clone
]

{ #category : #operations }
CpBrowserMediaStream >> getAudioTracks [

	"Returns a list of the MediaStreamTrack objects stored in the MediaStream object that have their kind attribute set to audio. The order is not defined, and may not only vary from one browser to another, but also from one call to another."

	^ self apply: #getAudioTracks
]

{ #category : #operations }
CpBrowserMediaStream >> getTrackById: aString [

	"Returns the track whose ID corresponds to the one given in parameters, trackid. If no parameter is given, or if no track with that ID does exist, it returns null. If several tracks have the same ID, it returns the first one."

	^ self apply: #getTrackById
]

{ #category : #operations }
CpBrowserMediaStream >> getTracks [

	"Returns a list of all MediaStreamTrack objects stored in the MediaStream object, regardless of the value of the kind attribute. The order is not defined, and may not only vary from one browser to another, but also from one call to another."

	^ self apply: #getTracks
]

{ #category : #operations }
CpBrowserMediaStream >> getVideoTracks [

	"Returns a list of the MediaStreamTrack objects stored in the MediaStream object that have their kind attribute set to video. The order is not defined, and may not only vary from one browser to another, but also from one call to another."

	^ self apply: #getVideoTracks
]

{ #category : #accessing }
CpBrowserMediaStream >> id [

	"A string containing a 36-character universally unique identifier (UUID) for the object."

	^ self propertyAt: #id
]

{ #category : #'event handling' }
CpBrowserMediaStream >> onActiveDo: aBlock [

	"Fired when the MediaStream is activated."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #active handler: aBlock
]

{ #category : #'event handling' }
CpBrowserMediaStream >> onAddTrackDo: aBlock [

	"Fired when a new MediaStreamTrack object is added."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #addtrack handler: aBlock
]

{ #category : #'event handling' }
CpBrowserMediaStream >> onInactiveDo: aBlock [

	"Fired when the MediaStream is inactivated."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #inactive handler: aBlock
]

{ #category : #'event handling' }
CpBrowserMediaStream >> onRemoveTrackDo: aBlock [

	"Fired when a MediaStreamTrack object has been removed."

	"Add an event listener and answer the handler (a JavaScript Function).
	Use the handler to remove the listener later when no longer needed."

	^ self addEventListener: #removetrack handler: aBlock
]

{ #category : #'event handling' }
CpBrowserMediaStream >> removeActiveHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #active handler: aFunction
]

{ #category : #'event handling' }
CpBrowserMediaStream >> removeAddTrackHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #addtrack handler: aFunction
]

{ #category : #'event handling' }
CpBrowserMediaStream >> removeInactiveHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #inactive handler: aFunction
]

{ #category : #'event handling' }
CpBrowserMediaStream >> removeRemoveTrackHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #removetrack handler: aFunction
]

{ #category : #operations }
CpBrowserMediaStream >> removeTrack: aMediaStreamTrack [

	"Removes the MediaStreamTrack given as argument. If the track is not part of the MediaStream object, nothing happens."

	self apply: #removeTrack withArguments: { aMediaStreamTrack }
]
