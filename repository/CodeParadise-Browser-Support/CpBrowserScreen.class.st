Class {
	#name : #CpBrowserScreen,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-Screen'
}

{ #category : #accessing }
CpBrowserScreen class >> current [

	"Answer an instance of the receiver"

	^ CpBrowserWindow current
		apply: #screen resultAs: self
]

{ #category : #'instance creation' }
CpBrowserScreen class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self error: 'An instance should be retrieved using the selector ', #current
]

{ #category : #accessing }
CpBrowserScreen >> availHeight [

	"Specifies the height of the screen, in pixels, minus permanent or semipermanent user interface features displayed by the operating system, such as the Taskbar on Windows."

	^ self propertyAt: #availHeight
]

{ #category : #accessing }
CpBrowserScreen >> availWidth [

	"Returns the amount of horizontal space in pixels available to the window."

	^ self propertyAt: #availWidth
]

{ #category : #accessing }
CpBrowserScreen >> colorDepth [

	"Returns the color depth of the screen."

	^ self propertyAt: #colorDepth
]

{ #category : #accessing }
CpBrowserScreen >> height [

	"Returns the height of the screen in pixels."

	^ self propertyAt: #height
]

{ #category : #accessing }
CpBrowserScreen >> orientation [

	"Returns the ScreenOrientation instance associated with this screen."

	^ self propertyAt: #orientation
]

{ #category : #accessing }
CpBrowserScreen >> pixelDepth [

	"Gets the bit depth of the screen."

	^ self propertyAt: #pixelDepth
]

{ #category : #accessing }
CpBrowserScreen >> width [

	"Returns the width of the screen."

	^ self propertyAt: #width
]
