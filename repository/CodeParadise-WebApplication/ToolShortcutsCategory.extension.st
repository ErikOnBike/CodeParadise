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

{ #category : #'*CodeParadise-WebApplication' }
ToolShortcutsCategory >> cpReload [ 

	"Extension method to map key combination to clear the session for a web application, and reload its page.

	Might require reset of keymap repository:
	KMRepository reset"

	<shortcut>

	^ KMKeymap 
		shortcut: CpDevTools shortcutReload 
		action: CpDevTools actionReload
]

{ #category : #'*CodeParadise-WebApplication' }
ToolShortcutsCategory >> cpReset [ 

	"Extension method to map key combination to reset the backend server and all web applications.

	Might require reset of keymap repository:
	KMRepository reset"

	<shortcut>

	^ KMKeymap 
		shortcut: CpDevTools shortcutReset 
		action: CpDevTools actionReset
]
