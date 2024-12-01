"
I represent both the Browser AbortSignal and the Node.js AbortSignal.
These classes are similar enough to have to same proxy implementation.
"
Class {
	#name : #CpBrowserAbortSignal,
	#superclass : #CpBrowserEventTarget,
	#category : #'CodeParadise-JavaScript-Shared'
}

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> abort [

	"Returns an AbortSignal instance that is already set as aborted."

	^ self apply: #abort resultAs: self
]

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> abort: reasonObject [

	"Returns an AbortSignal instance that is already set as aborted."

	^ self apply: #abort withArguments: { reasonObject } resultAs: self
]

{ #category : #accessing }
CpBrowserAbortSignal class >> abortSignalPolyfillCode [

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

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> any: aCollection [

	"Returns an AbortSignal that aborts when any of the given abort signals abort."

	^ self apply: #any withArguments: { aCollection } resultAs: self
]

{ #category : #'class initialization' }
CpBrowserAbortSignal class >> postInstallOnce [

	(self getClass propertyAt: #timeout)
		ifNil: [
			CpHtmlElement
				documentAddScript: self abortSignalPolyfillCode
				type: nil
				id: 'abortsignal-timeout-polyfill' ]
]

{ #category : #'instance creation' }
CpBrowserAbortSignal class >> timeout: anInteger [

	"Returns an AbortSignal instance that will automatically abort after a specified time (in ms)."

	^ self apply: #timeout withArguments: { anInteger } resultAs: self
]

{ #category : #accessing }
CpBrowserAbortSignal >> aborted [

	"A Boolean that indicates whether the request(s) the signal is communicating with is/are aborted (true) or not (false)."

	^ self propertyAt: #aborted
]

{ #category : #accessing }
CpBrowserAbortSignal >> reason [

	"A JavaScript value providing the abort reason, once the signal has aborted."

	^ self propertyAt: #reason
]

{ #category : #accessing }
CpBrowserAbortSignal >> throwIfAborted [

	"Throws the signal's abort reason if the signal has been aborted; otherwise it does nothing."

	self apply: #throwIfAborted
]
