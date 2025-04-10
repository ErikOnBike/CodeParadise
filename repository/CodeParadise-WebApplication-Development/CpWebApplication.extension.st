Extension { #name : #CpWebApplication }

{ #category : #'*CodeParadise-WebApplication-Development' }
CpWebApplication >> addViewInspector [

	CpViewInspectorSupport on: self environment
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CpWebApplication class >> addWebResourcesDelegateTo: aServer [

	"Add the repository's web resource directory to the Zinc server's delegates.
	By default, the following mapping will be installed:
		/<app-name> -> './www'.

	For example, a WebApplication class with app identifier #'my-first-app'
	will receive the following mapping:
		'/my-first-app' -> './www'

	The subfolder 'www' can be changed by overriding the method #webResourceDirectory."
	
	| packageName icePackage repository resourcePath |

	packageName := self package name.
	icePackage := IcePackage allInstances detect: [ :each | each package = packageName ] ifNone: [ ^ self ].
	repository := icePackage workingCopy repository.

	resourcePath := repository location / self webResourceDirectory.
	resourcePath ifAbsent: [ ^ self ].

	"Add file delegate to all running application servers (replacing any existing ones)"
	aServer delegate
		map: self app asString
		to: (ZnStaticFileServerDelegate new
			directory: resourcePath ;
			yourself)
]

{ #category : #'*CodeParadise-WebApplication-Development' }
CpWebApplication class >> webResourceDirectory [

	"Answer the name of the directory (within the repository) containing the web resources"

	^ 'www'
]
