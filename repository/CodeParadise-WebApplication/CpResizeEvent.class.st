Class {
	#name : #CpResizeEvent,
	#superclass : #CpCustomEvent,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #'processing - private' }
CpResizeEvent class >> addListenerTo: anElement [

	"Add a browser event listener to the specified element"

	"Observe the element"
	self addResizeObserverTo: anElement.

	super addListenerTo: anElement
]

{ #category : #'processing - private' }
CpResizeEvent class >> addResizeObserverTo: anElement [

	CpHtmlElement globalApply: #addResizeObserverTo: withArguments: { anElement }
]

{ #category : #'class initialization' }
CpResizeEvent class >> installCode [

	"Install code for the receiver.

	Add methods to observe/unobserve elements and when a resize is observed,
	dispatch a custom resize event."

	CpHtmlElement documentAddScript: '
		window.__cp_resizeObserver = new ResizeObserver(function(entries) {
			const resizeEvent = new CustomEvent("resize");
			entries.forEach(function(entry) {
				entry.target.dispatchEvent(resizeEvent);
			});
		});
		window["addResizeObserverTo:"] = function(target) {
			// Defer operation to allow style to be available (needed when listener is added from #initialize)
			window.setTimeout(function() {
				const style = window.getComputedStyle(target);
				const boxSizing = style.getPropertyValue("box-sizing") || "content-box";
				window.__cp_resizeObserver.observe(target, { box: boxSizing });
			}, 0);
		};
		window["removeResizeObserverFrom:"] = function(target) {
			window.__cp_resizeObserver.unobserve(target);
		};'
]

{ #category : #'class initialization' }
CpResizeEvent class >> postInstallOnce [

	self installCode
]

{ #category : #'processing - private' }
CpResizeEvent class >> removeListenerFrom: anElement [

	"Remove a browser event listener from the specified element"

	"Unobserve the element"
	self removeResizeObserverFrom: anElement.

	super removeListenerFrom: anElement
]

{ #category : #'processing - private' }
CpResizeEvent class >> removeResizeObserverFrom: anElement [

	CpHtmlElement globalApply: #removeResizeObserverFrom: withArguments: { anElement }
]
