Class {
	#name : #CpBrowserMediaTrackSupportedConstraints,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-MediaStreams'
}

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> aspectRatio [

	"A Boolean value whose value is true if the aspectRatio constraint is supported in the current environment."

	^ self propertyAt: #aspectRatio
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> autoGainControl [

	"A Boolean whose value is true if the autoGainControl constraint is supported in the current environment."

	^ self propertyAt: #autoGainControl
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> channelCount [

	"A Boolean value whose value is true if the channelCount constraint is supported in the current environment."

	^ self propertyAt: #channelCount
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> deviceId [

	"A Boolean value whose value is true if the deviceId constraint is supported in the current environment."

	^ self propertyAt: #deviceId
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> echoCancellation [

	"A Boolean value whose value is true if the echoCancellation constraint is supported in the current environment."

	^ self propertyAt: #echoCancellation
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> facingMode [

	"A Boolean value whose value is true if the facingMode constraint is supported in the current environment."

	^ self propertyAt: #facingMode
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> frameRate [

	"A Boolean value whose value is true if the frameRate constraint is supported in the current environment."

	^ self propertyAt: #frameRate
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> groupId [

	"A Boolean value whose value is true if the groupId constraint is supported in the current environment."

	^ self propertyAt: #groupId
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> height [

	"A Boolean value whose value is true if the height constraint is supported in the current environment."

	^ self propertyAt: #height
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> latency [

	"A Boolean value whose value is true if the latency constraint is supported in the current environment."

	^ self propertyAt: #latency
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> noiseSuppression [

	"A Boolean whose value is true if the noiseSuppression constraint is supported in the current environment."

	^ self propertyAt: #noiseSuppression
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> resizeMode [

	"A Boolean value whose value is true if the resizeMode constraint is supported in the current environment."

	^ self propertyAt: #resizeMode
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> sampleRate [

	"A Boolean value whose value is true if the sampleRate constraint is supported in the current environment."

	^ self propertyAt: #sampleRate
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> sampleSize [

	"A Boolean value whose value is true if the sampleSize constraint is supported in the current environment."

	^ self propertyAt: #sampleSize
]

{ #category : #accessing }
CpBrowserMediaTrackSupportedConstraints >> width [

	"A Boolean value whose value is true if the width constraint is supported in the current environment."

	^ self propertyAt: #width
]
