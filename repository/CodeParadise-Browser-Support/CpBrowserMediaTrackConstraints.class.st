Class {
	#name : 'CpBrowserMediaTrackConstraints',
	#superclass : 'CpJavaScriptObject',
	#category : 'CodeParadise-Browser-Support-MediaStreams',
	#package : 'CodeParadise-Browser-Support',
	#tag : 'MediaStreams'
}

{ #category : 'accessing' }
CpBrowserMediaTrackConstraints class >> getClassName [

	"Browsers implement me as a regular object/dictionary, therefore override the class I represent"

	^ 'Object'
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> aspectRatio [

	"A ConstrainDouble specifying the video aspect ratio or range of aspect ratios which are acceptable and/or required."

	^ self propertyAt: #aspectRatio
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> aspectRatio: aConstrainRange [

	"A ConstrainDouble specifying the video aspect ratio or range of aspect ratios which are acceptable and/or required."

	self propertyAt: #aspectRatio put: aConstrainRange
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> autoGainControl [

	"A ConstrainBoolean object which specifies whether automatic gain control is preferred and/or required."

	^ self propertyAt: #autoGainControl
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> autoGainControl: aConstrainValue [

	"A ConstrainBoolean object which specifies whether automatic gain control is preferred and/or required."

	self propertyAt: #autoGainControl put: aConstrainValue
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> brightness [

	"A ConstrainDouble (a double-precision integer) specifying a desired brightness setting."

	^ self propertyAt: #brightness
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> brightness: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying a desired brightness setting."

	self propertyAt: #brightness put: aConstrainRange
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> channelCount [

	"A ConstrainULong specifying the channel count or range of channel counts which are acceptable and/or required."

	^ self propertyAt: #channelCount
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> channelCount: aConstrainRange [

	"A ConstrainULong specifying the channel count or range of channel counts which are acceptable and/or required."

	self propertyAt: #channelCount put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> colorTemperature [

	"A ConstrainDouble (a double-precision integer) specifying a desired color temperature in degrees kelvin."

	^ self propertyAt: #colorTemperature
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> colorTemperature: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying a desired color temperature in degrees kelvin."

	self propertyAt: #colorTemperature put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> contrast [

	"A ConstrainDouble (a double-precision integer) specifying the degree of difference between light and dark."

	^ self propertyAt: #contrast
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> contrast: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying the degree of difference between light and dark."

	self propertyAt: #contrast put: aConstrainRange
]

{ #category : 'accessing - all media tracks' }
CpBrowserMediaTrackConstraints >> deviceId [

	"A ConstrainDOMString object specifying a device ID or an array of device IDs which are acceptable and/or required."

	^ self propertyAt: #deviceId
]

{ #category : 'accessing - all media tracks' }
CpBrowserMediaTrackConstraints >> deviceId: aConstrainValue [

	"A ConstrainDOMString object specifying a device ID or an array of device IDs which are acceptable and/or required."

	self propertyAt: #deviceId put: aConstrainValue
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackConstraints >> displaySurface [

	"A ConstrainDOMString which specifies the types of display surface that may be selected by the user. This may be a single one of the following strings, or a list of them to allow multiple source surfaces:

	browser
		The stream contains the contents of a single browser tab selected by the user.
	monitor
		The stream's video track contains the entire contents of one or more of the user's screens.
	window
		The stream contains a single window selected by the user for sharing."

	^ self propertyAt: #displaySurface
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackConstraints >> displaySurface: aConstrainValue [

	"A ConstrainDOMString which specifies the types of display surface that may be selected by the user. This may be a single one of the following strings, or a list of them to allow multiple source surfaces:

	browser
		The stream contains the contents of a single browser tab selected by the user.
	monitor
		The stream's video track contains the entire contents of one or more of the user's screens.
	window
		The stream contains a single window selected by the user for sharing."

	self propertyAt: #displaySurface put: aConstrainValue
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> echoCancellation [

	"A ConstrainBoolean object specifying whether or not echo cancellation is preferred and/or required."

	^ self propertyAt: #echoCancellation
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> echoCancellation: aConstrainValue [

	"A ConstrainBoolean object specifying whether or not echo cancellation is preferred and/or required."

	self propertyAt: #echoCancellation put: aConstrainValue
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> exposureCompensation [

	"A ConstrainDouble (a double-precision integer) specifying f-stop adjustment by up to ±3."

	^ self propertyAt: #exposureCompensation
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> exposureCompensation: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying f-stop adjustment by up to ±3."

	self propertyAt: #exposureCompensation put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> exposureMode [

	"A String specifying one of 'none', 'manual', 'single-shot', or 'continuous'."

	^ self propertyAt: #exposureMode
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> exposureMode: aString [

	"A String specifying one of 'none', 'manual', 'single-shot', or 'continuous'."

	self propertyAt: #exposureMode put: aString
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> facingMode [

	"A ConstrainDOMString object specifying a facing or an array of facings which are acceptable and/or required."

	^ self propertyAt: #facingMode
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> facingMode: aConstrainValue [

	"A ConstrainDOMString object specifying a facing or an array of facings which are acceptable and/or required."

	self propertyAt: #facingMode put: aConstrainValue
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> focusDistance [

	"A ConstrainDouble (a double-precision integer) specifying distance to a focused object."

	^ self propertyAt: #focusDistance
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> focusDistance: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying distance to a focused object."

	self propertyAt: #focusDistance put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> focusMode [

	"A String specifying one of 'none', 'manual', 'single-shot', or 'continuous'."

	^ self propertyAt: #focusMode
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> focusMode: aString [

	"A String specifying one of 'none', 'manual', 'single-shot', or 'continuous'."

	self propertyAt: #focusMode put: aString
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> frameRate [

	"A ConstrainDouble specifying the frame rate or range of frame rates which are acceptable and/or required."

	^ self propertyAt: #frameRate
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> frameRate: aConstrainRange [

	"A ConstrainDouble specifying the frame rate or range of frame rates which are acceptable and/or required."

	self propertyAt: #frameRate put: aConstrainRange
]

{ #category : 'accessing - all media tracks' }
CpBrowserMediaTrackConstraints >> groupId [

	"A ConstrainDOMString object specifying a group ID or an array of group IDs which are acceptable and/or required."

	^ self propertyAt: #groupId
]

{ #category : 'accessing - all media tracks' }
CpBrowserMediaTrackConstraints >> groupId: aConstrainValue [

	"A ConstrainDOMString object specifying a group ID or an array of group IDs which are acceptable and/or required."

	self propertyAt: #groupId put: aConstrainValue
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> height [

	"A ConstrainULong specifying the video height or range of heights which are acceptable and/or required."

	^ self propertyAt: #height
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> height: aConstrainRange [

	"A ConstrainULong specifying the video height or range of heights which are acceptable and/or required."

	self propertyAt: #height put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> iso [

	"A ConstrainDouble (a double-precision integer) specifying a desired iso setting."

	^ self propertyAt: #iso
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> iso: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying a desired iso setting."

	self propertyAt: #iso put: aConstrainRange
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> latency [

	"A ConstrainDouble specifying the latency or range of latencies which are acceptable and/or required."

	^ self propertyAt: #latency
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> latency: aConstrainRange [

	"A ConstrainDouble specifying the latency or range of latencies which are acceptable and/or required."

	self propertyAt: #latency put: aConstrainRange
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackConstraints >> logicalSurface [

	"A ConstrainBoolean value which may contain a single Boolean value or a set of them, indicating whether or not to allow the user to choose source surfaces which do not directly correspond to display areas. These may include backing buffers for windows to allow capture of window contents that are hidden by other windows in front of them, or buffers containing larger documents that need to be scrolled through to see the entire contents in their windows."

	^ self propertyAt: #logicalSurface
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackConstraints >> logicalSurface: aConstrainValue [

	"A ConstrainBoolean value which may contain a single Boolean value or a set of them, indicating whether or not to allow the user to choose source surfaces which do not directly correspond to display areas. These may include backing buffers for windows to allow capture of window contents that are hidden by other windows in front of them, or buffers containing larger documents that need to be scrolled through to see the entire contents in their windows."

	self propertyAt: #logicalSurface put: aConstrainValue
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> noiseSuppression [

	"A ConstrainBoolean which specifies whether noise suppression is preferred and/or required."

	^ self propertyAt: #noiseSuppression
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> noiseSuppression: aConstrainValue [

	"A ConstrainBoolean which specifies whether noise suppression is preferred and/or required."

	self propertyAt: #noiseSuppression put: aConstrainValue
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> pointsOfInterest [

	"The pixel coordinates on the sensor of one or more points of interest. This is either an object in the form { x:value, y:value } or an array of such objects, where value is a double-precision integer."

	^ self propertyAt: #pointsOfInterest
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> pointsOfInterest: anObject [

	"The pixel coordinates on the sensor of one or more points of interest. This is either an object in the form { x:value, y:value } or an array of such objects, where value is a double-precision integer."

	self propertyAt: #pointsOfInterest put: anObject
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> resizeMode [

	"A ConstrainDOMString object specifying a mode or an array of modes the UA can use to derive the resolution of a video track. Allowed values are none and crop-and-scale. none means that the user agent uses the resolution provided by the camera, its driver or the OS. crop-and-scale means that the user agent can use cropping and downscaling on the camera output in order to satisfy other constraints that affect the resolution."

	^ self propertyAt: #resizeMode
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> resizeMode: aConstrainValue [

	"A ConstrainDOMString object specifying a mode or an array of modes the UA can use to derive the resolution of a video track. Allowed values are none and crop-and-scale. none means that the user agent uses the resolution provided by the camera, its driver or the OS. crop-and-scale means that the user agent can use cropping and downscaling on the camera output in order to satisfy other constraints that affect the resolution."

	self propertyAt: #resizeMode put: aConstrainValue
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> sampleRate [

	"A ConstrainULong specifying the sample rate or range of sample rates which are acceptable and/or required."

	^ self propertyAt: #sampleRate
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> sampleRate: aConstrainRange [

	"A ConstrainULong specifying the sample rate or range of sample rates which are acceptable and/or required."

	self propertyAt: #sampleRate put: aConstrainRange
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> sampleSize [

	"A ConstrainULong specifying the sample size or range of sample sizes which are acceptable and/or required."

	^ self propertyAt: #sampleSize
]

{ #category : 'accessing - audio tracks' }
CpBrowserMediaTrackConstraints >> sampleSize: aConstrainRange [

	"A ConstrainULong specifying the sample size or range of sample sizes which are acceptable and/or required."

	self propertyAt: #sampleSize put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> saturation [

	"A ConstrainDouble (a double-precision integer) specifying the degree of color intensity."

	^ self propertyAt: #saturation
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> saturation: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying the degree of color intensity."

	self propertyAt: #saturation put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> sharpness [

	"A ConstrainDouble (a double-precision integer) specifying the intensity of edges."

	^ self propertyAt: #sharpness
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> sharpness: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying the intensity of edges."

	self propertyAt: #sharpness put: aConstrainRange
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackConstraints >> surpressLocalAudioPlayback [

	"A ConstrainBoolean value describing the requested or mandatory constraints placed upon the value of the suppressLocalAudioPlayback constrainable property. This property controls whether the audio playing in a tab will continue to be played out of a user's local speakers when the tab is captured.

	(Experimental)"

	^ self propertyAt: #surpressLocalAudioPlayback
]

{ #category : 'accessing - shared screen tracks' }
CpBrowserMediaTrackConstraints >> surpressLocalAudioPlayback: aConstrainValue [

	"A ConstrainBoolean value describing the requested or mandatory constraints placed upon the value of the suppressLocalAudioPlayback constrainable property. This property controls whether the audio playing in a tab will continue to be played out of a user's local speakers when the tab is captured.

	(Experimental)"

	self propertyAt: #surpressLocalAudioPlayback put: aConstrainValue
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> torch [

	"A boolean value defining whether the fill light is continuously connected, meaning it stays on as long as the track is active."

	^ self propertyAt: #torch
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> torch: aBoolean [

	"A boolean value defining whether the fill light is continuously connected, meaning it stays on as long as the track is active."

	self propertyAt: #torch put: aBoolean
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> whiteBalanceMode [

	"A String specifying one of 'none', 'manual', 'single-shot', or 'continuous'."

	^ self propertyAt: #whiteBalanceMode
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> whiteBalanceMode: aString [

	"A String specifying one of 'none', 'manual', 'single-shot', or 'continuous'."

	self propertyAt: #whiteBalanceMode put: aString
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> width [

	"A ConstrainULong specifying the video width or range of widths which are acceptable and/or required."

	^ self propertyAt: #width
]

{ #category : 'accessing - video tracks' }
CpBrowserMediaTrackConstraints >> width: aConstrainRange [

	"A ConstrainULong specifying the video width or range of widths which are acceptable and/or required."

	self propertyAt: #width put: aConstrainRange
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> zoom [

	"A ConstrainDouble (a double-precision integer) specifying the desired focal length."

	^ self propertyAt: #zoom
]

{ #category : 'accessing - image tracks' }
CpBrowserMediaTrackConstraints >> zoom: aConstrainRange [

	"A ConstrainDouble (a double-precision integer) specifying the desired focal length."

	self propertyAt: #zoom put: aConstrainRange
]
