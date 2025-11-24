Class {
	#name : #CpBrowserHistory,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-History'
}

{ #category : #accessing }
CpBrowserHistory class >> current [

	^ CpGlobalThis propertyAt: #history
]

{ #category : #'instance creation' }
CpBrowserHistory class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	self errorNewReplacedBy: #current
]

{ #category : #operations }
CpBrowserHistory >> back [

	"This asynchronous method goes to the previous page in session history, the same action as when the user clicks the browser's Back button. Equivalent to history.go(-1).
	Calling this method to go back beyond the first page in the session history has no effect and doesn't raise an exception."

	self apply: #back
]

{ #category : #operations }
CpBrowserHistory >> forward [

	"This asynchronous method goes to the next page in session history, the same action as when the user clicks the browser's Forward button; this is equivalent to history.go(1).
	Calling this method to go forward beyond the most recent page in the session history has no effect and doesn't raise an exception."

	self apply: #forward
]

{ #category : #operations }
CpBrowserHistory >> go [

	"Asynchronously loads a page from the session history, identified by its relative location to the current page, for example -1 for the previous page or 1 for the next page.
	If you specify an out-of-bounds value (for instance, specifying -1 when there are no previously-visited pages in the session history), this method silently has no effect.
	Calling go() without parameters or a value of 0 reloads the current page."

	self apply: #go
]

{ #category : #operations }
CpBrowserHistory >> go: anInteger [

	"Asynchronously loads a page from the session history, identified by its relative location to the current page, for example -1 for the previous page or 1 for the next page.
	If you specify an out-of-bounds value (for instance, specifying -1 when there are no previously-visited pages in the session history), this method silently has no effect.
	Calling go() without parameters or a value of 0 reloads the current page."

	self apply: #go withArguments: { anInteger }
]

{ #category : #accessing }
CpBrowserHistory >> length [

	"Returns an Integer representing the number of elements in the session history, including the currently loaded page. For example, for a page loaded in a new tab this property returns 1."

	^ self propertyAt: #length
]

{ #category : #operations }
CpBrowserHistory >> pushState: anObject [

	"Pushes the given data onto the session history stack with the specified title (and, if provided, URL). The data is treated as opaque by the DOM;
	you may specify any JavaScript object that can be serialized. Note that all browsers but Safari currently ignore the title parameter.
	For more information, see https://developer.mozilla.org/en-US/docs/Web/API/History_API/Working_with_the_History_API"

	self apply: #pushState withArguments: { anObject . '' }
]

{ #category : #operations }
CpBrowserHistory >> pushState: anObject url: aString [

	"Pushes the given data onto the session history stack with the specified title (and, if provided, URL). The data is treated as opaque by the DOM;
	you may specify any JavaScript object that can be serialized. Note that all browsers but Safari currently ignore the title parameter.
	For more information, see https://developer.mozilla.org/en-US/docs/Web/API/History_API/Working_with_the_History_API"

	self apply: #pushState withArguments: { anObject . '' . aString }
]

{ #category : #operations }
CpBrowserHistory >> replaceState: anObject [

	"Updates the most recent entry on the history stack to have the specified data, title, and, if provided, URL. The data is treated as opaque by the DOM;
	you may specify any JavaScript object that can be serialized. Note that all browsers but Safari currently ignore the title parameter.
	For more information, see https://developer.mozilla.org/en-US/docs/Web/API/History_API/Working_with_the_History_API"

	self apply: #replaceState withArguments: { anObject . '' }
]

{ #category : #operations }
CpBrowserHistory >> replaceState: anObject url: aString [

	"Updates the most recent entry on the history stack to have the specified data, title, and, if provided, URL. The data is treated as opaque by the DOM;
	you may specify any JavaScript object that can be serialized. Note that all browsers but Safari currently ignore the title parameter.
	For more information, see https://developer.mozilla.org/en-US/docs/Web/API/History_API/Working_with_the_History_API"

	self apply: #replaceState withArguments: { anObject . '' . aString }
]

{ #category : #accessing }
CpBrowserHistory >> scrollRestoration [

	"Allows web applications to explicitly set default scroll restoration behavior on history navigation. This property can be either auto or manual."

	^ self propertyAt: #scrollRestoration
]

{ #category : #accessing }
CpBrowserHistory >> scrollRestoration: aString [

	"Allows web applications to explicitly set default scroll restoration behavior on history navigation. This property can be either auto or manual."

	self propertyAt: #scrollRestoration put: aString
]

{ #category : #accessing }
CpBrowserHistory >> state [

	"Returns an any value representing the state at the top of the history stack. This is a way to look at the state without having to wait for a popstate event."

	^ self propertyAt: #state
]
