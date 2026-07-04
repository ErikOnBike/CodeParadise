Class {
	#name : #WaPage,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - slots' }
WaPage >> asideElement [

	"Content to be shown on the right side of the page. Typically contains a table of contents, ads, etc. This section ""sticks"" to the top as the page scrolls."

	^ self firstChildAtSlotNamed: #aside
]

{ #category : #'accessing - slots' }
WaPage >> asideElement: anElement [

	"Content to be shown on the right side of the page. Typically contains a table of contents, ads, etc. This section ""sticks"" to the top as the page scrolls."

	self replaceAllChildrenWith: anElement atSlotNamed: #aside
]

{ #category : #'accessing - slots' }
WaPage >> bannerElement [

	"The banner that gets display above the header. The banner will not be shown if no content is provided."

	^ self firstChildAtSlotNamed: #banner
]

{ #category : #'accessing - slots' }
WaPage >> bannerElement: anElement [

	"The banner that gets display above the header. The banner will not be shown if no content is provided."

	self replaceAllChildrenWith: anElement atSlotNamed: #banner
]

{ #category : #'accessing - convenience' }
WaPage >> beDisableNavigationToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disableNavigationToggle: true
]

{ #category : #'accessing - convenience' }
WaPage >> beNavOpen [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self navOpen: true
]

{ #category : #'accessing - convenience' }
WaPage >> beNotDisableNavigationToggle [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disableNavigationToggle: false
]

{ #category : #'accessing - convenience' }
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

{ #category : #'accessing - slots' }
WaPage >> footerElement [

	"The content to display in the footer. This is always displayed underneath the viewport so will always make the page ""scrollable""."

	^ self firstChildAtSlotNamed: #footer
]

{ #category : #'accessing - slots' }
WaPage >> footerElement: anElement [

	"The content to display in the footer. This is always displayed underneath the viewport so will always make the page ""scrollable""."

	self replaceAllChildrenWith: anElement atSlotNamed: #footer
]

{ #category : #'accessing - slots' }
WaPage >> headerElement [

	"The header to display at the top of the page. If a banner is present, the header will appear below the banner. The header will not be shown if there is no content."

	^ self firstChildAtSlotNamed: #header
]

{ #category : #'accessing - slots' }
WaPage >> headerElement: anElement [

	"The header to display at the top of the page. If a banner is present, the header will appear below the banner. The header will not be shown if there is no content."

	self replaceAllChildrenWith: anElement atSlotNamed: #header
]

{ #category : #actions }
WaPage >> hideNavigation [

	"Hides the mobile navigation drawer"

	^ self apply: #hideNavigation
]

{ #category : #'accessing - slots' }
WaPage >> mainFooterElement [

	"Footer to display inline below the main content."

	^ self firstChildAtSlotNamed: #'main-footer'
]

{ #category : #'accessing - slots' }
WaPage >> mainFooterElement: anElement [

	"Footer to display inline below the main content."

	self replaceAllChildrenWith: anElement atSlotNamed: #'main-footer'
]

{ #category : #'accessing - slots' }
WaPage >> mainHeaderElement [

	"Header to display inline above the main content."

	^ self firstChildAtSlotNamed: #'main-header'
]

{ #category : #'accessing - slots' }
WaPage >> mainHeaderElement: anElement [

	"Header to display inline above the main content."

	self replaceAllChildrenWith: anElement atSlotNamed: #'main-header'
]

{ #category : #'accessing - slots' }
WaPage >> menuElement [

	"The left side of the page. If you slot an element in here, you will override the default `navigation` slot and will be handling navigation on your own. This also will not disable the fallback behavior of the navigation button. This section ""sticks"" to the top as the page scrolls."

	^ self firstChildAtSlotNamed: #menu
]

{ #category : #'accessing - slots' }
WaPage >> menuElement: anElement [

	"The left side of the page. If you slot an element in here, you will override the default `navigation` slot and will be handling navigation on your own. This also will not disable the fallback behavior of the navigation button. This section ""sticks"" to the top as the page scrolls."

	self replaceAllChildrenWith: anElement atSlotNamed: #menu
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

{ #category : #'accessing - slots' }
WaPage >> navigationElement [

	"The main content to display in the navigation area. This is displayed on the left side of the page, if `menu` is not used. This section ""sticks"" to the top as the page scrolls."

	^ self firstChildAtSlotNamed: #navigation
]

{ #category : #'accessing - slots' }
WaPage >> navigationElement: anElement [

	"The main content to display in the navigation area. This is displayed on the left side of the page, if `menu` is not used. This section ""sticks"" to the top as the page scrolls."

	self replaceAllChildrenWith: anElement atSlotNamed: #navigation
]

{ #category : #'accessing - slots' }
WaPage >> navigationFooterElement [

	"The footer for a navigation area. On mobile this will be the footer for `<wa-drawer>`."

	^ self firstChildAtSlotNamed: #'navigation-footer'
]

{ #category : #'accessing - slots' }
WaPage >> navigationFooterElement: anElement [

	"The footer for a navigation area. On mobile this will be the footer for `<wa-drawer>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'navigation-footer'
]

{ #category : #'accessing - slots' }
WaPage >> navigationHeaderElement [

	"The header for a navigation area. On mobile this will be the header for `<wa-drawer>`."

	^ self firstChildAtSlotNamed: #'navigation-header'
]

{ #category : #'accessing - slots' }
WaPage >> navigationHeaderElement: anElement [

	"The header for a navigation area. On mobile this will be the header for `<wa-drawer>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'navigation-header'
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

{ #category : #'accessing - slots' }
WaPage >> navigationToggleElement [

	"Use this slot to slot in your own button + icon for toggling the navigation drawer. By default it is a `<wa-button>` + a 3 bars `<wa-icon>`"

	^ self firstChildAtSlotNamed: #'navigation-toggle'
]

{ #category : #'accessing - slots' }
WaPage >> navigationToggleElement: anElement [

	"Use this slot to slot in your own button + icon for toggling the navigation drawer. By default it is a `<wa-button>` + a 3 bars `<wa-icon>`"

	self replaceAllChildrenWith: anElement atSlotNamed: #'navigation-toggle'
]

{ #category : #'accessing - slots' }
WaPage >> navigationToggleIconElement [

	"Use this to slot in your own icon for toggling the navigation drawer. By default it is 3 bars `<wa-icon>`."

	^ self firstChildAtSlotNamed: #'navigation-toggle-icon'
]

{ #category : #'accessing - slots' }
WaPage >> navigationToggleIconElement: anElement [

	"Use this to slot in your own icon for toggling the navigation drawer. By default it is 3 bars `<wa-icon>`."

	self replaceAllChildrenWith: anElement atSlotNamed: #'navigation-toggle-icon'
]

{ #category : #actions }
WaPage >> showNavigation [

	"Shows the mobile navigation drawer"

	^ self apply: #showNavigation
]

{ #category : #'accessing - slots' }
WaPage >> skipToContentElement [

	"The ""skip to content"" slot. You can override this If you would like to override the `Skip to content` button and add additional ""Skip to X"", they can be inserted here."

	^ self firstChildAtSlotNamed: #'skip-to-content'
]

{ #category : #'accessing - slots' }
WaPage >> skipToContentElement: anElement [

	"The ""skip to content"" slot. You can override this If you would like to override the `Skip to content` button and add additional ""Skip to X"", they can be inserted here."

	self replaceAllChildrenWith: anElement atSlotNamed: #'skip-to-content'
]

{ #category : #'accessing - slots' }
WaPage >> subheaderElement [

	"A subheader to display below the `header`. This is a good place to put things like breadcrumbs."

	^ self firstChildAtSlotNamed: #subheader
]

{ #category : #'accessing - slots' }
WaPage >> subheaderElement: anElement [

	"A subheader to display below the `header`. This is a good place to put things like breadcrumbs."

	self replaceAllChildrenWith: anElement atSlotNamed: #subheader
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
