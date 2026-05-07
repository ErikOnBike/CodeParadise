Class {
	#name : #CpViewInspectorSupport,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'CodeParadise-WebApplication-Development-Support'
}

{ #category : #'event handling' }
CpViewInspectorSupport class >> applicationLoaded: anApplicationLoaded [

	"A new application is loaded create a new instance of the receiver
	(it will register as listener to the application's environment and therefore remain 'alive')"

	| serverEnvironment |

	serverEnvironment := anApplicationLoaded environment ifProduction: [ ^ self ].

	"Only install instances of the receiver in WebApplications"
	anApplicationLoaded application class isWebApplication
		ifFalse: [ ^ self ].

	^ self on: serverEnvironment
]

{ #category : #'class initialization' }
CpViewInspectorSupport class >> initialize [

	"Perform this method to have all applications receive view inspector support.
	Otherwise add support manually sending #addViewInspector to a specific Application instance."

	CpServerApplication whenLoadedSend: #applicationLoaded: to: self
]

{ #category : #'instance creation' }
CpViewInspectorSupport class >> on: anEnvironment [

	| instance |

	instance := self basicNew
		initializeWithEnvironment: anEnvironment ;
		yourself.

	self traceCr: 'ViewInspector installed ', instance printString.

	^ instance
]

{ #category : #'class initialization' }
CpViewInspectorSupport class >> release [

	<script>

	CpServerEnvironment unsubscribe: self.

	super release
]

{ #category : #initialization }
CpViewInspectorSupport >> initializeWithEnvironment: anEnvironment [

	self initialize.

	environment := anEnvironment.

	environment
		addInstallationChecker: (CpPackageInstallationChecker packages: { CpViewInspectorView package . SlElement package }) ;
		addClass: CpViewInspectorView ;
		addMethod: (CpDomElement >> #allNonShadowedElementsDo:) ;
		when: CpViewInspectorRequest send: #viewInspectorRequest: to: self ;
		when: CpCodeEditorHtmlTagsRequest send: #updateHtmlTagsRequest to: self
]

{ #category : #'event handling' }
CpViewInspectorSupport >> updateHtmlTagsRequest [

	| htmlTags |

	"Start with common <div> and <span> (block/inline) elements"
	htmlTags := OrderedCollection new
		add: #div ;
		add: #span ;
		yourself.

	"Add all WebComponents"
	CpWebComponent allSubclassesDo: [ :each |
		each hasAbstractTag
			ifFalse: [ htmlTags add: each tagName ] ].

	environment sendMessage: (MessageSend
		receiver: CpViewInspectorView name
		selector: #updateHtmlTags:
		arguments: { htmlTags asArray })
]

{ #category : #'event handling' }
CpViewInspectorSupport >> viewInspectorRequest: aViewInspectorRequest [

	aViewInspectorRequest performIn: environment
]
