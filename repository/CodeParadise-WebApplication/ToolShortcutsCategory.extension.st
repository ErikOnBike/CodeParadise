Extension { #name : #ToolShortcutsCategory }

{ #category : #'*CodeParadise-WebApplication' }
ToolShortcutsCategory >> cpApplications [ 

	"Extension method to map key combination to open an inspector on the web application instances.

	Might require reset of keymap repository:
	KMRepository reset"

	<shortcut>

	^ KMKeymap 
		shortcut: CpDevTools shortcutApplications 
		action: CpDevTools actionApplications
]

{ #category : #'*CodeParadise-WebApplication' }
ToolShortcutsCategory >> cpOpen [ 

	"Extension method to map key combination to open a browser on a running CodeParadise application.

	Might require reset of keymap repository:
	KMRepository reset"

	<shortcut>

	^ KMKeymap 
		shortcut: CpDevTools shortcutOpen 
		action: CpDevTools actionOpen
]
