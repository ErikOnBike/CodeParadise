Class {
	#name : #CpDevTools,
	#superclass : #Object,
	#category : #'CodeParadise-WebApplication-DevTools'
}

{ #category : #actions }
CpDevTools class >> actionApplications [ 

	^ [ CpServerApplication allSubInstances inspect ]
]

{ #category : #actions }
CpDevTools class >> actionOpen [ 

	^ [ self open ]
]

{ #category : #actions }
CpDevTools class >> actionReload [ 

	^ [ self resetSession ]
]

{ #category : #actions }
CpDevTools class >> actionReset [ 

	^ [ self restart ]
]

{ #category : #accessing }
CpDevTools class >> allApplications [
	"Answer all the defined CP web applications"
	
	^ CpWebApplication allSubclasses select: [ :c | c class includesSelector: #app ]
]

{ #category : #accessing }
CpDevTools class >> defaultPort [ 
	^8080
]

{ #category : #'message handling' }
CpDevTools class >> handleClientError: aClientError for: aServerEnvironment [

	"Show inspector with the error and environment"
	{ 'An error occurred in the Client Environment' . aClientError . aServerEnvironment } inspect
]

{ #category : #scripts }
CpDevTools class >> open [
	"Open a Web Browser on a selected application"
	<script>
	
	| choices |
	choices := self allApplications collect: [ :a | a app ].
	
	(UIManager default
		chooseFrom: choices
		values: choices
		message: 'Select the example to browse:'
		title: 'Browse WebApplication')
		ifNotNil: [ :choice | 
			WebBrowser openOn: 'http://localhost:8080/static/app.html?', choice ]
]

{ #category : #scripts }
CpDevTools class >> resetSession [
	"Reset the browser session for the selected application"
	<script>
	
	| apps |
	
	apps := CpServerApplication allSubInstances
		select: [ :cs | cs environment notNil ].
		
	(UIManager default
		chooseFrom: (apps collect: [ :a | a class app , ' [' , a environment id , ']' ])
		values: apps
		message: 'Select the WebApplication to reload:'
		title: 'Reload Session')
		ifNotNil: [ :choice | 
			choice environment
				sendMessage: (MessageSend receiver: nil selector: #invalidSession arguments: {}).
			choice release ]
]

{ #category : #scripts }
CpDevTools class >> restart [ 
	<script>

	self stop; start
]

{ #category : #shortcuts }
CpDevTools class >> shortcutApplications [ 

	^ $r meta , $i meta
]

{ #category : #shortcuts }
CpDevTools class >> shortcutOpen [ 

	^ $r meta , $o meta
]

{ #category : #shortcuts }
CpDevTools class >> shortcutReload [ 

	^ $r meta , $r meta
]

{ #category : #shortcuts }
CpDevTools class >> shortcutReset [ 

	^ $r meta , $t meta
]

{ #category : #scripts }
CpDevTools class >> start [
	"Start a server and examples"
	<script>
	
	| resourcePath |
	self crTrace: 'Starting CP...'.
	
	CpMessageChannel environmentImplementation: CpZincWebSocketChannel.

	"Register the example applications"
	self allApplications do: [ :app | app register ].

	resourcePath := IceRepository directoryNamed: 'html' in: 'CP-ClientEnvironment'.

	"Start the HTTP and WeSocket servers (use the path where you stored the ClientEnvironment)"
	CpApplicationServerStarter
		startUsingConfig: {
			#portNumber -> self defaultPort.
			#staticFilesDirectoryName 	-> resourcePath.
			#clientErrorHandler -> self
		} asDictionary
]

{ #category : #scripts }
CpDevTools class >> stop [
	"Stop all server instances and applications"
	<script>

	self crTrace: 'Stopping CP...'.
	
	ZnServer allSubInstances
		do: [ :each | 
			(each port = self defaultPort and: [ each isRunning ])
				ifTrue: [ each stop ] ].
			
	CpServerApplication allSubInstances do: [ :each | each stop ].
	CpApplicationServer allInstances do: [ :each | each stop ].

	"Unregister applications"
	self allApplications do: [ :app | app unregister ].

	"Garbage collect works better in triples ;-)"
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect
]

{ #category : #menu }
CpDevTools class >> worldMenuCommandOn: aBuilder [

	"Create the world menu for some Dev Tools.

	The accompanying key combination shortcuts (set using #keyText:) are implemented as extension 
	methods on the class ToolShortcutsCategory. To enable these shortcuts in a running image, reset 
	the keymap repository by evaluating: KMRepository reset."

	<worldMenu>
	 
	| menuId |
	
	(aBuilder item: (menuId := #Paradise))
		order: 4.0;
		target: self;
		help: 'Tools to support Code Paradise projects'.
		
	(aBuilder item: #'Open...')
		parent: menuId;
		help: 'Open a web browser on a running application';
		order: 10;
		keyText: 'r, o';
		icon: (self iconNamed: #smallOpen);
		action: self actionOpen.
		
	(aBuilder item: #'Reload...')
		parent: menuId;
		help: 'Clear the session for a web application, and reload its page';
		order: 15;
		keyText: 'r, r';
		icon: (self iconNamed: #smallUpdate);
		action: self actionReload.
		
	aBuilder withSeparatorAfter.
	
	(aBuilder item: #'Reset')
		parent: menuId;
		help: 'Reset the backend server and all web applications';
		order: 20;
		keyText: 'r, t';
		icon: (self iconNamed: #smallError);
		action: self actionReset.		
	
	(aBuilder item: #'Applications...')
		parent: menuId;
		help: 'Open an inspector on the web application instances';
		order: 25;
		keyText: 'r, i';
		icon: (self iconNamed: #smallInspectIt);
		action: self actionApplications
]
