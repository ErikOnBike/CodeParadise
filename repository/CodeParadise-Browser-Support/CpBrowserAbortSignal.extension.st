Extension { #name : #CpBrowserAbortSignal }

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> abortSignalPolyfillCode [

	<environment: #browser>

	"JavaScript code to polyfill AbortSignal.timeout function.

	See also: https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal#browser_compatibility"

	^'if(AbortSignal.timeout === undefined) {

	// Add the missing timeout method on AbortSignal
	AbortSignal.timeout = function(time) {

		// Create AbortSignal instance using AbortController
		const abortController = new AbortController();
		const abortSignal = abortController.signal;

		// Attache a timer to the AbortSignal which ensures aborting (through AbortController)
		abortSignal.__cp_timer = window.setTimeout(function() {
			abortController.abort(new DOMException("", "TimeoutError"));
		}, time);

		// Answer the "prepped" AbortSignal instance
		return abortSignal;
	};

	// Replace window.fetch with an enhanced version for our AbortSignal
	const fetchOrig = window.fetch;
	window.fetch = function(resource, options) {

		// Call original fetch method and keep result (Promise resolving to Response)
		const result = fetchOrig.call(window, resource, options);

		// Check for our "prepped" AbortSignal (otherwise ignore)
		if(options && options.signal && options.signal.__cp_timer) {

			// Clear timer after receiving a response
			return result.then(function(response) {
				window.clearTimeout(options.signal.__cp_timer);
				delete options.signal.__cp_timer;

				// Answer response so caller can use it
				return response;
			});
		}
		return result;
	};
}

// Remove myself (the script)
document.getElementById("abortsignal-timeout-polyfill").remove();'
]

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> beLoadedInBrowser [

	<environment: #browser>

	CpBrowserDOMException beLoaded
]

{ #category : #'*CodeParadise-Browser-Support' }
CpBrowserAbortSignal class >> postInstallOnce [

	<environment: #browser>

	(self getClass propertyAt: #timeout)
		ifNil: [
			CpHtmlElement
				documentAddScript: self abortSignalPolyfillCode
				type: nil
				id: 'abortsignal-timeout-polyfill' ]
]
