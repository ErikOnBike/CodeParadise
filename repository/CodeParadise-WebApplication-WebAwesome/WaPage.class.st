Class {
	#name : #WaPage,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #convenience }
WaPage >> beDisableNavigationToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disableNavigationToggle: true
]

{ #category : #convenience }
WaPage >> beNavOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self navOpen: true
]

{ #category : #convenience }
WaPage >> beNotDisableNavigationToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disableNavigationToggle: false
]

{ #category : #convenience }
WaPage >> beNotNavOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self navOpen: false
]

{ #category : #accessing }
WaPage >> disableNavigationToggle [

	"Determines whether or not to hide the default hamburger button.
	This will automatically flip to ""true"" if you add an element with `data-toggle-nav` anywhere in the element light DOM.
	Generally this will be set for you and you don't need to do anything, unless you're using SSR, in which case you should set this manually for initial page loads.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disableNavigationToggle
]

{ #category : #accessing }
WaPage >> disableNavigationToggle: aBoolean [

	"Determines whether or not to hide the default hamburger button.
	This will automatically flip to ""true"" if you add an element with `data-toggle-nav` anywhere in the element light DOM.
	Generally this will be set for you and you don't need to do anything, unless you're using SSR, in which case you should set this manually for initial page loads.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disableNavigationToggle put: aBoolean
]

{ #category : #actions }
WaPage >> hideNavigation [

	"Hides the mobile navigation drawer"

	^ self apply: #hideNavigation
]

{ #category : #accessing }
WaPage >> mobileBreakpoint [

	"At what page width to hide the ""navigation"" slot and collapse into a hamburger button.
	Accepts both numbers (interpreted as px) and CSS lengths (e.g. `50em`), which are resolved based on the root element.
	
	Type: String
	Default: '768px'"

	^ self propertyAt: #mobileBreakpoint
]

{ #category : #accessing }
WaPage >> mobileBreakpoint: aString [

	"At what page width to hide the ""navigation"" slot and collapse into a hamburger button.
	Accepts both numbers (interpreted as px) and CSS lengths (e.g. `50em`), which are resolved based on the root element.
	
	Type: String
	Default: '768px'"

	self propertyAt: #mobileBreakpoint put: aString
]

{ #category : #accessing }
WaPage >> navOpen [

	"Whether or not the navigation drawer is open. Note, the navigation drawer is only ""open"" on mobile views.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #navOpen
]

{ #category : #accessing }
WaPage >> navOpen: aBoolean [

	"Whether or not the navigation drawer is open. Note, the navigation drawer is only ""open"" on mobile views.
	
	Type: Boolean
	Default: false"

	self propertyAt: #navOpen put: aBoolean
]

{ #category : #accessing }
WaPage >> navigationPlacement [

	"Where to place the navigation when in the mobile viewport.
	
	Type: String
	Default: 'start'
	Allowed: 'start' | 'end'"

	^ self propertyAt: #navigationPlacement
]

{ #category : #accessing }
WaPage >> navigationPlacement: aString [

	"Where to place the navigation when in the mobile viewport.
	
	Type: String
	Default: 'start'
	Allowed: 'start' | 'end'"

	self propertyAt: #navigationPlacement put: aString
]

{ #category : #actions }
WaPage >> showNavigation [

	"Shows the mobile navigation drawer"

	^ self apply: #showNavigation
]

{ #category : #actions }
WaPage >> toggleNavigation [

	"Toggles the mobile navigation drawer"

	^ self apply: #toggleNavigation
]

{ #category : #accessing }
WaPage >> view [

	"The view is a reflection of the ""mobileBreakpoint"", when the page is larger than the `mobile-breakpoint` (768px by
	default), it is considered to be a ""desktop"" view. The view is merely a way to distinguish when to show/hide the
	navigation. You can use additional media queries to make other adjustments to content as necessary.
	The default is ""desktop"" because the ""mobile navigation drawer"" isn't accessible via SSR due to drawer requiring JS.
	
	Type: String
	Default: 'desktop'
	Allowed: 'mobile' | 'desktop'"

	^ self propertyAt: #view
]

{ #category : #accessing }
WaPage >> view: aString [

	"The view is a reflection of the ""mobileBreakpoint"", when the page is larger than the `mobile-breakpoint` (768px by
	default), it is considered to be a ""desktop"" view. The view is merely a way to distinguish when to show/hide the
	navigation. You can use additional media queries to make other adjustments to content as necessary.
	The default is ""desktop"" because the ""mobile navigation drawer"" isn't accessible via SSR due to drawer requiring JS.
	
	Type: String
	Default: 'desktop'
	Allowed: 'mobile' | 'desktop'"

	self propertyAt: #view put: aString
]

{ #category : #actions }
WaPage >> visiblePixelsInViewport: aCpHtmlElement [

	"https://stackoverflow.com/a/26831113
	This prevents awkward gaps when scrolling the page and the aside / menu dont ""fill"" the gaps.
	
	Parameter: element (HTMLElement | null)"

	^ self apply: #visiblePixelsInViewport withArguments: { aCpHtmlElement }
]
