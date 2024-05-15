"
I am a helper class to start servers for WebApplications.
I will start a server for HTTP access for static files.
I will start a server for WebSocket access for Remote Environments.

"
Class {
	#name : 'CpApplicationServerStarter',
	#superclass : 'Object',
	#category : 'CodeParadise-WebApplication-Support',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Support'
}

{ #category : 'starting/stopping' }
CpApplicationServerStarter class >> startUsingConfig: configuration [

	"Start a new server instance for running WebApplications using the given configuration.
	The configuration should implement the #at:ifAbsent: method to allow configuration items
	to be retrieved.
	
	The following configuration items are allowed:
		#ioPath
			String specifying on which absolute path the WebSocket will be used
			(required, default: '/io')
		#portNumber
			Integer specifying the port number on which the WebApplication will be accessed
			(required, default: 80)
		#staticFilesPath
			String specifying on which absolute path within the URL the static files for the WebApplication will be accessed
			(optional, if #staticFilesDirectoryName is specified the default value is '/static', otherwise no default value)
		#staticFilesDirectoryName
			String specifying in which directory the static files are stored in the file system
			(optional, no default value, an error will be signaled if this configuration item is missing but #staticFilesPath is given)
	"

	| ioPath portNumber staticFilesPath staticFilesDirectory applicationServer staticFilesDelegate |

	"Create reference to static file directory (if available)"
	staticFilesDirectory := (configuration at: #staticFilesDirectoryName ifAbsent: [ nil ])
		ifNotNil: [ :directoryName | directoryName asFileReference ].

	"Extract normalized URL for WebSocket I/O"
	ioPath := (ZnUrl fromString: (configuration at: #ioPath ifAbsent: [ '/io' ])) path.

	"Create normalized URL for static files (this will work for relative and absolute paths)"
	staticFilesPath := configuration at: #staticFilesPath ifAbsent: [ staticFilesDirectory ifNotNil: [ '/static' ] ].
	staticFilesPath
		ifNotNil: [
			staticFilesPath ifEmpty: [ self error: 'Configuration item #staticFilesPath should not be an empty string' ].
			staticFilesPath := (ZnUrl fromString: staticFilesPath) path ].

	"Validate static files information"
	(staticFilesPath isNil and: [  staticFilesDirectory notNil ])
		ifTrue: [ self error: 'Configuration item #staticFilesPath not specified, while #staticFilePath is given' ].
	staticFilesDirectory
		ifNotNil: [
			(staticFilesDirectory exists and: [ staticFilesDirectory isDirectory ])
				ifFalse: [ self error: 'Specified directory ', staticFilesDirectory pathString, ' does not exist or is not a directory' ] ].

	"Validate paths are non-ambiguous"
	(ioPath beginsWith: staticFilesPath)
		ifTrue: [ self error: 'Configuration item #ioPath should not point to location within #staticFilesPath (making request handling ambiguous)' ].

	"Port number"
	portNumber := configuration at: #portNumber ifAbsent: [ 80 ].

	"Stop any existing servers on 'our' port"
	(ZnServer allSubInstances select: [ :each | each port = portNumber and: [ each isRunning ] ]) do: [ :each | each stop ].
	Delay forMilliseconds: 200.

	"Create new application server"
	applicationServer := CpApplicationServer newOnPort: portNumber path: '/'.

	"Add client error handler (if configured)"
	configuration at: #clientErrorHandler ifPresent: [ :clientErrorHandler |
		applicationServer clientErrorHandler: clientErrorHandler ].

	"Create delegate for handling static file requests"
	staticFilesDelegate := ZnStaticFileServerDelegate new
		directory: staticFilesDirectory ;
		yourself.

	"Add static file delegate to server"
	applicationServer server
		stop ;
		delegate: (ZnPrefixMappingDelegate new
			map: ioPath to: applicationServer server delegate ;
			map: staticFilesPath to: staticFilesDelegate ;
			yourself) ;
		start.

	^ applicationServer 
]
