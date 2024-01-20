"
I represent a custom mutation event which is produced whenever the MutationObserver detects
any mutations. MutationEvents need to have conditions set explicitly to work. These conditions
specify which type of mutation should be observed. See the Javascript documentation for the
explanation of the conditionals allowed (for every option there is an EventCondition, like
CpAttributeFilterMutation for the 'attributeFilter' option). There are two exceptions, there
is no support for 'characterData' nor 'characterDataOldValue' since CDATA is not supported
within CodeParadise.

"
Class {
	#name : #CpMutationEvent,
	#superclass : #CpCustomEvent,
	#category : #'CodeParadise-WebApplication-Events-Custom'
}

{ #category : #announcing }
CpMutationEvent class >> addListenerTo: anElement [

	"Only #addListenerTo:withConditions: should be used, since mutations
	have to be defined as conditions"

	self error: 'Only use ', #addListenerTo:withConditions:
]

{ #category : #announcing }
CpMutationEvent class >> addListenerTo: anElement withConditions: aCollection [

	"Add a browser event listener to the specified element"

	"Observe the element"
	self addMutationObserverTo: anElement withConditions: aCollection.

	"DO NOT call 'self addListenerTo:' since we want to prevent accidental setting
	MutationObservers without specific conditions (ie conditions always have to
	be set explicitly)"
	super addListenerTo: anElement
]

{ #category : #announcing }
CpMutationEvent class >> addMutationObserverTo: anElement withConditions: aCollection [

	CpHtmlElement
		globalApply: #addMutationObserverTo:withOptions:
		withArguments: { anElement . (self optionsFromConditions: aCollection) }
]

{ #category : #'class initialization' }
CpMutationEvent class >> installCode [

	"Install code for the receiver.

	Add methods to observe/unobserve elements and when a mutation is observed,
	dispatch a custom mutation event."

	CpHtmlElement documentAddScript: '
		window.__cp_cleanUpNodes = function(nodeOrNodeList) {
			if(nodeOrNodeList === null) {
				return null;
			} else if(nodeOrNodeList.nodeType) {
				return nodeOrNodeList.nodeType === Node.ELEMENT_NODE ? nodeOrNodeList : null;
			} else {
				// Convert all NodeList nodes to elements
				return Array.from(nodeOrNodeList)
					.map(function(node) { return window.__cp_cleanUpNodes(node); })
					.filter(function(node) { return node !== null; })
				;
			}
		};
		window["addMutationObserverTo:withOptions:"] = function(target, options) {

			// Remove field "attributeFilter" if null.
			if(options.attributeFilter === null) {
				delete options.attributeFilter;
			}

			// Create new MutationObserver
			const mutationObserver = new MutationObserver(function(mutationRecords) {

				// Create the custom mutation event
				const mutationEvent = new CustomEvent("mutation", {
					detail: mutationRecords
						.map(function(mutation) {
							// Create a copy of the mutation record (replacing NodeLists with Arrays and
							// removing non-Element nodes). Also explicitly leave out the characterData
							// fields (CDATA is not supported in CodeParadise).
							return {
								addedNodes: window.__cp_cleanUpNodes(mutation.addedNodes),
								attributeName: mutation.attributeName,
								attributeNamespace: mutation.attributeNamespace,
								nextSibling: window.__cp_cleanUpNodes(mutation.nextSibling),
								oldValue: mutation.oldValue,
								previousSibling: window.__cp_cleanUpNodes(mutation.previousSibling),
								removedNodes: window.__cp_cleanUpNodes(mutation.removedNodes),
								target: window.__cp_cleanUpNodes(mutation.target),
								type: mutation.type
							};
						})
						.filter(function(mutation) {
							return mutation.addedNodes.length > 0 ||
								mutation.attributeName !== null ||
								mutation.attributeNamespace !== null ||
								mutation.nextSibling !== null ||
								mutation.oldValue !== null ||
								mutation.previousSibling !== null ||
								mutation.removedNodes.length > 0
							;
						})
				});

				// Dispatch the event (if not empty wrt mutation records)
				if(mutationEvent.detail.length > 0) {
					target.dispatchEvent(mutationEvent);
				}
			});

			// Keep track of the observer and options
			mutationObserver.__cp_options = options;
			if(target.__cp_mutationObservers === undefined) {
				target.__cp_mutationObservers = [];
			}
			target.__cp_mutationObservers.push(mutationObserver);

			// Start observing
			mutationObserver.observe(target, options);
		};
		window["removeMutationObserverFrom:withOptions:"] = function(target, options) {

			// Remove field "attributeFilter" if null.
			if(options.attributeFilter === null) {
				delete options.attributeFilter;
			}

			// Since multiple observers can be attached, find the one with exactly the same options
			const optionsAttributeFilter = (options.attributeFilter || []).sort().join(",");	// Pre calculate this value
			const mutationObserverIndex = target.__cp_mutationObservers.findIndex(function(mutationObserver) {
				const compareOptions = mutationObserver.__cp_options;
				return compareOptions.subtree === options.subtree &&
					compareOptions.childList === options.childList &&
					compareOptions.attributes === options.attributes &&
					compareOptions.attributeOldValue === options.attributeOldValue &&
					(compareOptions.attributeFilter || []).sort().join(",") === optionsAttributeFilter	// Perform as last line because it is the most expensive to calculate
				;
			});
			if(mutationObserverIndex === -1) {
				console.warn("removeMutationObserver called for options which do not exist (anymore)", options);
				return;
			}
			
			// Disconnect observer and remove it from the collection
			target.__cp_mutationObservers[mutationObserverIndex].disconnect();
			target.__cp_mutationObservers.splice(mutationObserverIndex, 1);
		};'
]

{ #category : #announcing }
CpMutationEvent class >> optionsFromConditions: aCollection [

	"Answer a Dictionary representing the JavaScript options argument
	for the MutationObserver observe method.

	See: https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver/observe

	The field 'characterData' and 'characterDataOldValue' are not used since there
	is currently no support for CDATA in CodeParadise."

	^ {
		#subtree -> (CpSubtreeMutation optionValueFromConditions: aCollection) .
		#childList -> (CpChildListMutation optionValueFromConditions: aCollection) .
		#attributes -> (CpAttributesMutation optionValueFromConditions: aCollection) .
		#attributeFilter -> (CpAttributeFilterMutation optionValueFromConditions: aCollection) .
		#attributeOldValue -> (CpAttributeOldValueMutation optionValueFromConditions: aCollection) .
	} asDictionary
]

{ #category : #'class initialization' }
CpMutationEvent class >> postInstallOnce [

	self installCode
]

{ #category : #announcing }
CpMutationEvent class >> removeListenerFrom: anElement [

	"Only #removeListenerFrom:withConditions: should be used, since mutations
	have to be defined as conditions"

	self error: 'Only use ', #removeListenerFrom:withConditions:
]

{ #category : #announcing }
CpMutationEvent class >> removeListenerFrom: anElement withConditions: aCollection [

	"Remove a browser event listener from the specified element"

	"Unobserve the element"
	self removeMutationObserverFrom: anElement withConditions: aCollection.

	"DO NOT call 'self removeListenerFrom:' since we want to prevent accidental setting
	MutationObservers without specific conditions (ie conditions always have to
	be set explicitly)"
	super removeListenerFrom: anElement
]

{ #category : #announcing }
CpMutationEvent class >> removeMutationObserverFrom: anElement withConditions: aCollection [

	CpHtmlElement
		globalApply: #removeMutationObserverFrom:withOptions:
		withArguments: { anElement . (self optionsFromConditions: aCollection) }
]

{ #category : #'as yet unclassified' }
CpMutationEvent >> mutationRecords [

	"Answer an Array of Dictionaries representing MutationRecords"

	^ self detail
]
