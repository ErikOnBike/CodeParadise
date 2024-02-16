Class {
	#name : #CpBrowserMediaDevices,
	#superclass : #CpJavaScriptEventTarget,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserMediaDevices class >> current [

	"Answer the singleton of the receiver.

	Implementation:
	To prevent adding the MediaDevices and related classes to an image once the Navigator
	is added, perform the call to mediaDevices here. This keeps the reference from going
	from the Navigator to the receiver."

	^ CpBrowserNavigator current
		apply: #mediaDevices resultAs: self
]

{ #category : #'instance creation' }
CpBrowserMediaDevices class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'An instance should be retrieved using the selector ', #current
]

{ #category : #accessing }
CpBrowserMediaDevices >> enumerateDevices [

	"Obtains an array of information about the media input and output devices available on the system."

	^ self apply: #enumerateDevices resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserMediaDevices >> getDisplayMedia [

	^ self getDisplayMediaWithOptions: nil
]

{ #category : #accessing }
CpBrowserMediaDevices >> getDisplayMediaWithOptions: aDictionary [

	"Prompts the user to select a display or portion of a display (such as a window) to capture as a MediaStream for sharing or recording purposes. Returns a promise that resolves to a MediaStream.

	The aDictionary parameter:
	An optional object specifying requirements for the returned MediaStream. The options for getDisplayMedia() work
	in the same as the constraints for the MediaDevices.getUserMedia() method, although in that case only audio and
	video can be specified. The list of possible option properties for getDisplayMedia() is as follows:

	video Optional
		A boolean or a MediaTrackConstraints instance; the default value is true. If this option is omitted or set to
		true, the stream will contain a video track A value of true indicates that the returned MediaStream will
		contain a video track. Since getDisplayMedia() requires a video track, if this option is set to false the
		promise will reject with a TypeError.
	audio Optional
		A boolean or a MediaTrackConstraints instance; the default value is false. A value of true indicates that the
		returned MediaStream will contain an audio track, if audio is supported and available for the display surface
		chosen by the user.
	controller Optional
		A CaptureController object instance containing methods that can be used to further manipulate the capture
		session if included.
	preferCurrentTab Non-standard Optional
		A boolean; a value of true instructs the browser to offer the current tab as the most prominent capture
		source, i.e. as a separate ""This Tab"" option in the ""Choose what to share"" options presented to the user.
		This is useful as many app types generally just want to share the current tab. For example, a slide deck app
		might want to let the user stream the current tab containing the presentation to a virtual conference. A
		default value is not mandated by the spec; see the Browser compatibility section for browser-specific
		defaults.
	selfBrowserSurface Optional
		An enumerated value specifying whether the browser should allow the user to select the current tab for
		capture. This helps to avoid the ""infinite hall of mirrors"" effect experienced when a video conferencing
		app inadvertently shares its own display. Possible values are include, which hints that the browser should
		include the current tab in the choices offered for capture, and exclude, which hints that it should be
		excluded. A default value is not mandated by the spec; see the Browser compatibility section for browser-
		specific defaults.
	surfaceSwitching Optional
		An enumerated value specifying whether the browser should display a control to allow the user to dynamically
		switch the shared tab during screen-sharing. This is much more convenient than having to go through the
		whole sharing process again each time a user wants to switch the shared tab. Possible values are include,
		which hints that the browser should include the control, and exclude, which hints that it should not be shown.
		A default value is not mandated by the spec; see the Browser compatibility section for browser-specific
		defaults.
	systemAudio Optional
		An enumerated value specifying whether the browser should include the system audio among the possible audio
		sources offered to the user. Possible values are include, which hints that the browser should include the
		system audio in the list of choices, and exclude, which hints that it should be excluded. A default value is
		not mandated by the spec; see the Browser compatibility section for browser-specific defaults.
	"

	^ self apply: #getDisplayMedia withArguments: { aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #accessing }
CpBrowserMediaDevices >> getSupportedConstraints [

	"Returns an object conforming to MediaTrackSupportedConstraints indicating which constrainable properties are supported on the MediaStreamTrack interface. See Media Streams API to learn more about constraints and how to use them."

	^ self apply: #getSupportedConstraints resultAs: CpBrowserMediaTrackSupportedConstraints
]

{ #category : #accessing }
CpBrowserMediaDevices >> getUserMediaAudio [

	^ self getUserMediaWithConstraints: { #video -> false . #audio -> true } asDictionary
]

{ #category : #accessing }
CpBrowserMediaDevices >> getUserMediaVideo [

	^ self getUserMediaWithConstraints: { #video -> true . #audio -> false } asDictionary
]

{ #category : #accessing }
CpBrowserMediaDevices >> getUserMediaVideoAndAudio [

	^ self getUserMediaWithConstraints: { #video -> true . #audio -> true } asDictionary
]

{ #category : #accessing }
CpBrowserMediaDevices >> getUserMediaWithConstraints: aDictionary [

	"With the user's permission through a prompt, turns on a camera and/or a microphone on the system and provides a MediaStream containing a video track and/or an audio track with the input.

	The aDictionary parameter:
	An object specifying the types of media to request, along with any requirements for each type.

	The constraints parameter is an object with two members: video and audio, describing the media types requested.
	Either or both must be specified. If the browser cannot find all media tracks with the specified types that
	meet the constraints given, then the returned promise is rejected with NotFoundError DOMException.

	For both video and audio, its value is either a boolean or an object. The default value is false.

	- If true is specified for a media type, the resulting stream is required to have that type of track in it.
	  If one cannot be included for any reason, the returned promise will reject.
	- If false is specified for a media type, the resulting stream must not have that type of track, or the returned
	  promise will reject. Because both video and audio default to false, if the constraints object contains neither
	  property or if it's not present at all, the returned promise will always reject.
	- If an object is specified for a media type, the object is read as a MediaTrackConstraints dictionary.
	"

	^ self apply: #getUserMedia withArguments: { aDictionary } resultAs: CpJavaScriptPromise
]

{ #category : #'event handling' }
CpBrowserMediaDevices >> onDeviceChangeDo: aBlock [

	"Fired when a media input or output device is attached to or removed from the user's computer."

	"Add an event listener for when device change and answer the
	handler (a JavaScript Function). Use the handler 	to remove the
	listener later when no longer needed."

	^ self addEventListener: #devicechange handler: aBlock
]

{ #category : #'event handling' }
CpBrowserMediaDevices >> removeDeviceChangeHandler: aFunction [

	"Remove an earlier installed event listener
	(using the handler which was answered during installation)"

	self removeEventListener: #devicechange handler: aFunction
]
