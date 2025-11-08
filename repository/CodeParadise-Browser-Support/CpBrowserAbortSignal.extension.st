Extension { #name : #CpBrowserAbortSignal }

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> beLoadedInBrowser [

	<environment: #browser>

	CpBrowserDOMException beLoaded
]

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> installAbortSignalPolyfillCode [

	<environment: #browser>

	"JavaScript code to polyfill AbortSignal.timeout function.

	See also: https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal#browser_compatibility"

	"Create AbortSignal instance using AbortController"
	self getClass
		propertyAt: #timeout put: (CpJavaScriptFunction
			method:
'const abortController = new AbortController();
const abortSignal = abortController.signal;

// Attache a timer to the AbortSignal which ensures aborting (through AbortController)
abortSignal.__cp_timer = window.setTimeout(function() {
	abortController.abort(new DOMException("", "TimeoutError"));
}, time);

// Answer the "prepped" AbortSignal instance
return abortSignal;'
			arguments: #('time')).

	"Replace window.fetch with an enhanced version for our AbortSignal.
	Keep the original fetch implementation first. Then replace with special version.
	Call original fetch method and then check result for our 'prepped' AbortSignal
	(otherwise ignore) and answer result."
	CpGlobalThis propertyAt: #fetchOrig put: (CpGlobalThis propertyAt: #fetch).
	CpGlobalThis propertyAt: #fetch put: (CpJavaScriptFunction
		method:
'const result = window.fetchOrig.call(window, resource, options);
if(options && options.signal && options.signal.__cp_timer) {

	// Clear timer after receiving a response
	return result.then(function(response) {
		window.clearTimeout(options.signal.__cp_timer);
		delete options.signal.__cp_timer;

		// Answer response so caller can use it
		return response;
	});
}
return result;'
		arguments: #('resource' 'options'))
]

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> postInstallOnce [

	<environment: #browser>

	(self getClass propertyAt: #timeout)
		ifNil: [ self installAbortSignalPolyfillCode ]
]

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> postSnapshotOnce [

	<environment: #browser>

	self postInstallOnce
]
