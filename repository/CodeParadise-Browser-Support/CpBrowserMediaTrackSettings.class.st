Class {
	#name : 'CpBrowserMediaTrackSettings',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-Browser-Support-MediaStreams',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'MediaStreams'
}

{ #category : 'accessing' }
CpBrowserMediaTrackSettings class >> getClassName [

	"Browsers implement me as a regular object/dictionary, therefore override the class I represent"

	^ 'Object'
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackSettings >> aspectRatio [

	"A double-precision floating point value indicating the current value of the aspectRatio property, specified precisely to 10 decimal places. This is the width of the image in pixels divided by its height in pixels. Common values include 1.3333333333 (for the classic television 4:3 ""standard"" aspect ratio, also used on tablets such as Apple's iPad), 1.7777777778 (for the 16:9 high-definition widescreen aspect ratio), and 1.6 (for the 16:10 aspect ratio common among widescreen computers and tablets)."

	^ self propertyAt: #aspectRatio
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> autoGainControl [

	"A Boolean which indicates the current value of the autoGainControl property, which is true if automatic gain control is enabled and is false otherwise."

	^ self propertyAt: #autoGainControl
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> channelCount [

	"A long integer value indicating the current value of the channelCount property, specifying the number of audio channels present on the track (therefore indicating how many audio samples exist in each audio frame). This is 1 for mono, 2 for stereo, and so forth."

	^ self propertyAt: #channelCount
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackSettings >> cursor [

	"A string which indicates whether or not the mouse cursor is being included in the generated stream and under what conditions. Possible values are:

	always
		The mouse is always visible in the video content of the {domxref(""MediaStream""), unless the mouse has moved outside the area of the content.
	motion
		The mouse cursor is always included in the video if it's moving, and for a short time after it stops moving.
	never
		The mouse cursor is never included in the shared video."

	^ self propertyAt: #cursor
]

{ #category : 'accessing - all media tracks' }
CpBrowserMediaTrackSettings >> deviceId [

	"A string indicating the current value of the deviceId property. The device ID is an origin-unique string identifying the source of the track; this is usually a GUID. This value is specific to the source of the track's data and is not usable for setting constraints; it can, however, be used for initially selecting media when calling MediaDevices.getUserMedia()."

	^ self propertyAt: #deviceId
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackSettings >> displaySurface [

	"A string which specifies the type of source the track contains; one of:

	application
		The stream contains all of the windows of the application chosen by the user rendered into the one video track.
	browser
		The stream contains the contents of a single browser tab selected by the user.
	monitor
		The stream's video track contains the entire contents of one or more of the user's screens.
	window
		The stream contains a single window selected by the user for sharing."

	^ self propertyAt: #displaySurface
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> echoCancellation [

	"A Boolean indicating the current value of the echoCancellation property, specifying true if echo cancellation is enabled, otherwise false."

	^ self propertyAt: #echoCancellation
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackSettings >> facingMode [

	"A string indicating the current value of the facingMode property, specifying the direction the camera is facing. The value will be one of:

	user
		A camera facing the user (commonly known as a ""selfie cam""), used for self-portraiture and video calling.
	environment
		A camera facing away from the user (when the user is looking at the screen). This is typically the highest quality camera on the device, used for general photography.
	left
		A camera facing toward the environment to the user's left.
	right
		A camera facing toward the environment to the user's right."

	^ self propertyAt: #facingMode
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackSettings >> frameRate [

	"A double-precision floating point value indicating the current value of the frameRate property, specifying how many frames of video per second the track includes. If the value can't be determined for any reason, the value will match the vertical sync rate of the device the user agent is running on."

	^ self propertyAt: #frameRate
]

{ #category : 'accessing - all media tracks' }
CpBrowserMediaTrackSettings >> groupId [

	"A string indicating the current value of the groupId property. The group ID is a browsing session-unique string identifying the source group of the track. Two devices (as identified by the deviceId) are considered part of the same group if they are from the same physical device. For instance, the audio input and output devices for the speaker and microphone built into a phone would share the same group ID, since they're part of the same physical device. The microphone on a headset would have a different ID, though. This value is specific to the source of the track's data and is not usable for setting constraints; it can, however, be used for initially selecting media when calling MediaDevices.getUserMedia()."

	^ self propertyAt: #groupId
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackSettings >> height [

	"A long integer value indicating the current value of the height property, specifying the height of the track's video data in pixels."

	^ self propertyAt: #height
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> latency [

	"A double-precision floating point value indicating the current value of the latency property, specifying the audio latency, in seconds. Latency is the amount of time which elapses between the start of processing the audio and the data being available to the next stop in the audio utilization process. This value is a target value; actual latency may vary to some extent for various reasons."

	^ self propertyAt: #latency
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackSettings >> logicalSurface [

	"A Boolean value which, if true, indicates that the video contained in the stream's video track contains a background rendering context, rather than a user-visible one. This is false if the video being captured is coming from a foreground (user-visible) source."

	^ self propertyAt: #logicalSurface
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> noiseSuppression [

	"A Boolean which indicates the current value of the noiseSuppression property, which is true if noise suppression is enabled and is false otherwise."

	^ self propertyAt: #noiseSuppression
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackSettings >> resizeMode [

	"A string indicating the current value of the resizeMode property, specifying the mode used by the user agent to derive the resolution of the track. The value will be one of:

	none
		The track has the resolution offered by the camera, its driver or the OS.
	crop-and-scale
		The track's resolution might be the result of the user agent using cropping or downscaling from a higher camera resolution."

	^ self propertyAt: #resizeMode
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> sampleRate [

	"A long integer value indicating the current value of the sampleRate property, specifying the sample rate in samples per second of the audio data. Standard CD-quality audio, for example, has a sample rate of 41,000 samples per second."

	^ self propertyAt: #sampleRate
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackSettings >> sampleSize [

	"A long integer value indicating the current value of the sampleSize property, specifying the linear size, in bits, of each audio sample. CD-quality audio, for example, is 16-bit, so this value would be 16 in that case."

	^ self propertyAt: #sampleSize
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackSettings >> width [

	"A long integer value indicating the current value of the width property, specifying the width of the track's video data in pixels."

	^ self propertyAt: #width
]
