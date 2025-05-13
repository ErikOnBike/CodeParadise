Class {
	#name : #CpBrowserSupportExamplesWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#instVars : [
		'process'
	],
	#category : #'CodeParadise-Browser-Support-Examples'
}

{ #category : #'class initialization' }
CpBrowserSupportExamplesWebClientBehavior class >> beLoaded [

	CpBrowserSpeechSynthesisEvent beLoaded
]

{ #category : #accessing }
CpBrowserSupportExamplesWebClientBehavior >> clearOutput [

	self outputElement textContent: ''
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> clipboardRead [

	| outputElement |

	outputElement := self outputElement.

	CpBrowserClipboard current
		readThenDo: [ :clipboardItems |
			clipboardItems do: [ :eachClipboardItem |
				eachClipboardItem types do: [ :eachType |
					eachClipboardItem
						getType: eachType
						thenDo:[ :content |
							| contentString |
							contentString := (eachType beginsWith: 'text/')
								ifTrue: [ String fromUTF8EncodedByteArray: content ]
								ifFalse: [ '<content type "', eachType, '" can''t be shown yet>' ].
							outputElement appendChild: ((CpHtmlElement newWithTag: #div)
								textContent: 'ClipboardItem type: ', eachType, ' content: ', contentString ;
								yourself) ]
						onError: [
							outputElement appendChild: ((CpHtmlElement newWithTag: #div)
								textContent: 'ClipboardItem type: ', eachType, ' error retrieving content'
								yourself) ] ].
				outputElement appendChild: ((CpHtmlElement newWithTag: #p)
					textContent: 'ClipboardItem with types: ', eachClipboardItem types printString ;
					yourself) ] ]
		onError: [ :reason |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'read failed: ', reason printString ;
				yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> clipboardReadText [

	| outputElement |

	outputElement := self outputElement.

	CpBrowserClipboard current
		readTextThenDo: [ :text |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Clipboard text: ', text printString ;
				yourself) ]
		onError: [ :reason |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'readText failed: ', reason printString ;
				yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> clipboardWrite [

	| outputElement input input2 htmlInput items |

	outputElement := self outputElement.
	input := (outputElement firstDescendantMatching: '#input') propertyAt: #value.
	input2 := (outputElement firstDescendantMatching: '#input2') propertyAt: #value.
	htmlInput := String streamContents: [ :aStream |
		aStream
			nextPutAll: '<div>'.
		input2 do: [ :each |
			each = $&
				ifTrue: [ aStream nextPutAll: '&amp;' ]
				ifFalse: [
					each = $<
						ifTrue: [ aStream nextPutAll: '&lt;' ]
						ifFalse: [
							each = $>
								ifTrue: [ aStream nextPutAll: '&gt;' ]
								ifFalse: [ aStream nextPut: each ] ] ] ].
		aStream nextPutAll: '</div>' ].

	"Create ClipboardItems based on input (some browsers do not support more than 1 item)"
	items := input
		ifEmpty: [
			input2
				ifEmpty: [ { CpBrowserClipboardItem newWithString: '' type: 'text/plain' } ]
				ifNotEmpty: [ { CpBrowserClipboardItem newWithBlob: (CpBrowserBlob newWith: htmlInput type: 'text/html') } ] ]
		ifNotEmpty: [
			input2
				ifEmpty: [ { CpBrowserClipboardItem newWithString: input type: 'text/plain' } ]
				ifNotEmpty: [ {
					CpBrowserClipboardItem newWithString: input type: 'text/plain'.
					CpBrowserClipboardItem newWithBlob: (CpBrowserBlob newWith: htmlInput type: 'text/html') } ] ].

	CpBrowserClipboard current
		write: items
		thenDo: [
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Clipboard written: "', input printString, (input2 ifEmpty: [ '"' ] ifNotEmpty: [ '" and a HTML representation' ]);
				yourself) ]
		onError: [ :reason |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'write failed: ', reason printString ;
				yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> clipboardWriteText [

	| outputElement input |

	outputElement := self outputElement.
	input := (outputElement firstDescendantMatching: '#input') propertyAt: #value.

	CpBrowserClipboard current
		writeText: input
		thenDo: [
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Clipboard written: "', input printString, '"' ;
				yourself) ]
		onError: [ :reason |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'writeText failed: ', reason printString ;
				yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserClipboard [

	<example: 'Clipboard API' order: 100>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.
	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Clipboard API' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'You can use different browser APIs from CodeParadise. This is the Clipboard API.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: Your browser might show a "paste" menu or request for permission while executing the read operation.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: Your browser might not support multiple inputs when using the write operation.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: Your browser might Add some additional HTML (and/or styling) when using the write operation.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: Your browser might not support "application/json" format when using the write operation (not part of this demo).' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'If you copy some content (including styled text like the bullets on the left) and push the "read" variant, you should be able to see both text/plain and text/html as variant being shown.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			markupContent: 'Your text input for the clipboard: <input id="input"> and html input <input id="input2">'
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Read clipboard' ;
			when: CpClickEvent primary only send: #clipboardRead to: self ;
			yourself) ;
		appendChild: ' ' asHtmlElement ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Read text clipboard' ;
			when: CpClickEvent primary only send: #clipboardReadText to: self ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Write clipboard' ;
			when: CpClickEvent primary only send: #clipboardWrite to: self ;
			yourself) ;
		appendChild: ' ' asHtmlElement ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Write text clipboard' ;
			when: CpClickEvent primary only send: #clipboardWriteText to: self ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserGeolocation [

	<example: 'Geolocation API' order: 200>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Geolocation API' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'You can use different browser APIs from CodeParadise. This is the Geolocation API.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: You might be asked for permission to use your location. Depending on your response a different result will be shown. To get the permission request again, you might need to reload this page.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: You might need to have WiFi enabled to help in position (otherwise error value 2 "POSITION_UNAVAILABLE" might be given).' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Get current position' ;
			when: CpClickEvent primary only send: #geolocationGetCurrent to: self ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserMediaStreams [

	<example: 'Media Streams API (stream video)' order: 510>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Media Streams API (stream video)' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'After clicking the button (and giving permission to use the video) your camera input should be shown below.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #video)
			attributeAt: #playsinline put: '' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			id: #progress ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Start video' ;
			yourself).

	(outputElement firstDescendantMatching: #button)
		when: CpClickEvent primary only send: #mediaStreamShowVideo to: self
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserMediaStreamsDevices [

	<example: 'Media Streams API (show devices)' order: 509>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Media Streams API (show devices)' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Results for label and id can be empty (after clicking the button below) if this is called before actually requesting access to a media device. This is to prevent finger printing of clients. If you see empty values, please try to use the "stream media" example which actually uses the video. Then returning here should show more information.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Show devices' ;
			yourself).

	(outputElement firstDescendantMatching: #button)
		when: CpClickEvent primary only send: #mediaStreamShowDevices to: self
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserNavigator [

	<example: 'Navigator' order: 50>

	| outputElement languages language list |

	languages := CpBrowserNavigator current languages.
	language := CpBrowserNavigator current language.

	self clearOutput.
	outputElement := self outputElement.
	list := outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Navigator' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Supported languages:' ;
			yourself) ;
		appendChild: (CpHtmlElement newWithTag: #ul).

	languages do: [ :each |
		list
			appendChild: ((CpHtmlElement newWithTag: #li)
				textContent: each ;
				yourself) ].

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Preferred language: ', language ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserScreen [

	<example: 'Screen' order: 25>

	| outputElement screen |

	screen := CpBrowserScreen current.

	self clearOutput.
	outputElement := self outputElement.
	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Screen' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Available height: ', screen availHeight printString ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Available width: ', screen availWidth printString ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Height: ', screen height printString ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Width: ', screen width printString ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Color depth: ', screen colorDepth printString ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Pixel depth: ', screen pixelDepth printString ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Orientation: ', screen orientation type ;
			yourself)
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleBrowserSpeechSynthesis [

	<example: 'Speech API (Synthesis)' order: 300>

	| outputElement voicesSelection |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Speech API (Synthesis)' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Enter a text which should be spoken (and hear and watch it being spoken). The dev console also shows a lot of event info.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #input)
			id: #text ;
			attributeAt: #size put: '80' ;
			propertyAt: #value put: 'Smalltalk is a great programming language for great and small projects' ;
			styleAt: #'font-size' put: '14px' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			id: #progress ;
			textContent: '' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Select the voice and language to speak' ;
			yourself) ;
		appendChild: (CpHtmlElement newWithTag: #select) ;
		appendChild: (CpHtmlElement newWithTag: #p) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Speak!' ;
			when: CpClickEvent primary only send: #speechSpeak to: self ;
			yourself).

	voicesSelection := outputElement firstDescendantMatching: #select.
	CpBrowserSpeechSynthesis current getVoices do: [ :each |
		voicesSelection appendChild: ((CpHtmlElement newWithTag: #option)
			attributeAt: #selected put: (each default ifTrue: [ "" ] ifFalse: [ nil ]) ;
			textContent: each name, ' - ', each lang, ' ', (each localService ifTrue: [ '(local synth)' ] ifFalse: [ '(remote synth)' ]) ;
			yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleDNU [

	<example: 'Basic: DNU' order: 1400>

	| outputElement math |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'DNU test' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Below is the error which is signaled as a result of a DNU on a proxied JavaScript object (i.e. trying the equivalent of "Math.doSomething")' ;
			yourself) ;
		yourself.

	[
		math := CpJavaScriptClass forName: #Math.
		math apply: #doSomething ] on: Error do: [ :err |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'DNU error: ', err printString ;
				yourself) ].

	outputElement appendChild: ('Doing a DNU from setTimeout(2s)' inHtmlTag: #p).

	CpGlobalThis setTimeout: 2000 thenDo: [ [
		math apply: #doSomethingInCallback ] on: Error do: [ :err |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'DNU error in callback: ', err printString ;
				yourself) ] ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleJavaScriptEventTarget [

	<example: 'Basic: Proxy for JavaScript EventTarget' order: 1100>

	| outputElement eventTarget handler |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Proxy for JavaScript EventTarget' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Click me to add text' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Click me to remove event listener (stop other button)' ;
			when: CpClickEvent primary only do: [ eventTarget removeEventListener: handler ] for: self ;
			yourself) ;
		yourself.

	eventTarget := CpBrowserEventTarget wrap: (outputElement firstDescendantMatching: #button).
	handler := eventTarget addEventListener: #click handler: [ :event | outputElement appendChild: ((CpHtmlElement newWithTag: #div) textContent: event printString ; yourself) ].

]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleJavaScriptFunction [

	<example: 'Basic: Proxy for JavaScript functions' order: 1000>

	| outputElement jsFunc1 jsFunc2 jsFunc3 jsFunc4 counter |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'JavaScript functions' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Smalltalk Blocks can be used in place of JavaScript functions (like callbacks or in Promises). The Smalltalk Block can call other JavaScript functions which can call Smalltalk Blocks again. Even recursively. See the output below (please check source code to see what is going on).' ;
			yourself) ;
		yourself.

	counter := 1.

	jsFunc1 := CpJavaScriptFunction wrap: [ :input |
		self showInfo: 'In func1 with input: ', input printString.
		counter := counter + 1.

		"Answer counter without the increment"
		counter - 1 ].

	jsFunc2 := CpJavaScriptFunction wrap: [ :input |
		| x |
		
		self showInfo: 'In func2 with input: ', input printString.
		self showInfo: 'Calling func1'.
		x := jsFunc1 call: nil withArguments: { 'from func2 first' }.
		x = 1
			ifFalse: [ self showInfo: 'Unexpected result from func1' ].
		self showInfo: 'Called func1 -  (expect result 1): ', x printString.
		self showInfo: 'Calling func1'.
		x := jsFunc1 call: nil withArguments: { 'from func2 second' }.
		x = 2
			ifFalse: [ self showInfo: 'Unexpected result from func1' ].
		self showInfo: 'Called func1 more - (expect result 2): ', x printString.

		"Answer fixed value"		
		123 ].

	(jsFunc2 call: nil withArguments: { 'from example' })
		ifNotNil: [ :result |
			result = 123
				ifFalse: [ self showInfo: 'Unexpected result from func2' ].
			self showInfo: 'Ran all - result (expect result 123): ', result printString ]
		ifNil: [ self showInfo: 'Unexpected result from func2' ].

	"Some recursive calls"
	counter := 10.
	jsFunc3 := CpJavaScriptFunction wrap: [ counter >= 0 ifTrue: [ self showInfo: 'Count down ', counter printString. counter := counter - 1. jsFunc3 call: nil withArguments: nil ] ].
	jsFunc3 call: nil withArguments: nil.

	"Prevent errors from giving results"
	jsFunc4 := CpJavaScriptFunction wrap: [ self showInfo: 'In for an error?'. self error: 'OOPS' ].
	[
		self showInfo: 'Result on error ', (jsFunc4 call: nil withArguments: nil) printString
	] on: Error do: [ :err |
		self showInfo: '(Expected) Error during JavaScriptFunction: ', err rootException printString
	].
	self showInfo: 'After the Error incident (glad that is over ;-)'
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleJavaScriptPromise [

	<example: 'Basic: Proxy for JavaScript Promises' order: 1200>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'JavaScript Promises' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Promises can be used and created from Smalltalk using CpJavaScriptPromise class >> #on: aTwoArgBlock, CpJavaScriptPromise class >> #resolve: aBlock or CpJavaScriptPromise class >> #all: aCollection' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'You can use the asynchronous behavior of Promises.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			id: 'promise-button' ;
			textContent: 'Run Promise: show message after 2 second delay' ;
			when: CpClickEvent primary only send: #promiseRun to: self ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'You can make Promises behave more like synchronous using #await.' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'BE AWARE: you should always use #await in a separate Process from a browser event handler (or transition), since it will otherwise make the browser unresponsive. To prevent this happening, an Error will be signaled if the Process does not allow "awaiting" (currently this is the case for both the CpEvent handler and the CpTransition handler).' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			id: 'promise-await-button' ;
			textContent: 'Run Promise: show message after 2 second delay, using await' ;
			when: CpClickEvent primary only send: #promiseRunAwait to: self ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Errors within Promises are handled differently. If you don''t have a .catch(...) it will become an unhandled rejection. If using the default async mechanism, this rejection happens outside of any Smalltalk context. In that case, the best CP can do is show in which CodeBlock the issue arose. Fix this by adding a catch, because it is a programmer''s mistake. Be sure your catch doesn''t signal an error itself, otherwise we are back at square one ;-).' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'When applying #await however, the async code is made synchronous again. Now you can catch the rejection using a regular [ ... ] on: Error do: [ ...] handler. (See the code of this example)' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			id: 'promise-error-button' ;
			textContent: 'Run Promise: show message then signal error (no catch)' ;
			when: CpClickEvent primary only send: #promiseRunError to: self ;
			yourself) ;
		yourself.

	self promiseRunTests
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleJavaScriptProxy [

	<example: 'Basic: Proxy for JavaScript objects' order: 1000>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Proxy for JavaScript objects' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'You can use a Smalltalk Block as a JavaScript callback function. The button below will have a JavaScript "window.setTimeout(func, duration)" being called which will, after 2 seconds, append a text after the button. Feel free to press it in short repetition as well. All clicks will result in a text (albeit, with some delay).' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			textContent: 'Add text (after 2s)' ;
			when: CpClickEvent primary only do: [ CpBrowserWindow current setTimeout: 2000 thenDo: [ outputElement appendChild: 'Hello!' asHtmlElement ] ] for: self ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> exampleProcess [

	<example: 'Basic: Process test' order: 1300>

	| outputElement |

	self clearOutput.
	outputElement := self outputElement.

	outputElement
		appendChild: ((CpHtmlElement newWithTag: #h1)
			textContent: 'Process' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Press buttons to start or stop the process' ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			id: 'start-button' ;
			textContent: 'Start' ;
			when: CpClickEvent primary only do: [
				process
					ifNotNil: [
						process isSuspended
							ifTrue: [ process resume ]
							ifFalse: [ outputElement appendChild: ('Not suspended' inHtmlTag: #p) ] ]
					ifNil: [
						outputElement appendChild: ('About to start new process...' inHtmlTag: #p).
						process := [ | counter | outputElement appendChild: ('Go!' inHtmlTag: #p). counter := 0. [ counter := counter + 1. (counter rem: 100000) = 0 ifTrue: [ outputElement appendChild: (('counted ', counter printString) inHtmlTag: #p) ]. counter > 0 ] whileTrue ] forkAt: 3 ] ] for: self ;
			yourself) ;
		appendChild: ((CpHtmlElement newWithTag: #button)
			id: 'stop-button' ;
			textContent: 'Stop' ;
			when: CpClickEvent primary only do: [
				process
					ifNotNil: [ process isSuspended
							ifTrue: [ outputElement appendChild: ('Already suspended' inHtmlTag: #p) ]
							ifFalse: [ process suspend ] ]
					ifNil: [ outputElement appendChild: ('Not created yet' inHtmlTag: #p) ] ] for: self ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> geolocationGetCurrent [

	| outputElement |
	
	outputElement := self outputElement.

	CpBrowserGeolocation current
		getCurrentPosition: [ :position |
			| coords |
			coords := position coords.
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'lat/long (accuracy): ', coords latitude printString, ' / ', coords longitude printString, ' (', coords accuracy printString, ')' ;
				yourself) ]
		onError: [ :err |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Error retrieving position: ', err code printString, ': ', err message ;
				yourself) ]
		withOptions: nil
]

{ #category : #initialization }
CpBrowserSupportExamplesWebClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> mediaStreamShowDevices [

	| outputElement |

	outputElement := self outputElement.

	"Enumerate devices"
	CpBrowserMediaDevices current enumerateDevices
		then: [ :devices |
			devices do: [ :each |
				outputElement appendChild: ((CpHtmlElement newWithTag: #p)
					textContent: 'Device label: ', each label printString, ' kind: ', each kind printString, ' id: ', each deviceId printString ;
					yourself) ] ]
		catch: [ :error |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Failed to retrieve user media devices ', error printString ;
				yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> mediaStreamShowVideo [

	| outputElement video progress |

	outputElement := self outputElement.
	video := outputElement firstDescendantMatching: #video.
	progress := outputElement firstDescendantMatching: '#progress'.

	"Retrieve Video"
	CpBrowserMediaDevices current getUserMediaVideo
		then: [ :stream |
			video
				propertyAt: #srcObject put: stream ;
				apply: #play withArguments: nil ]
		catch: [ :error |
			progress replaceAllChildrenWith: ('Failed to retrieve user media video: ', error printString) asHtmlElement ]
]

{ #category : #accessing }
CpBrowserSupportExamplesWebClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> promiseRun [

	| outputElement jsPromise |

	outputElement := self outputElement.

	jsPromise := CpJavaScriptPromise on: [ :resolveBlock :rejectBlock |
		CpGlobalThis setTimeout: 2000 thenDo: [ resolveBlock value: 'Hello world' ] ].

	outputElement appendChild: ((CpHtmlElement newWithTag: #p)
		textContent: 'Wait 2 seconds...' ;
		yourself).
	jsPromise then: [  :value |
		outputElement appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: value ;
			yourself) ].
	outputElement appendChild: ((CpHtmlElement newWithTag: #p)
		textContent: 'After Promise >> #then, but Promise not fulfilled yet (result will arrive soon...)' ;
		yourself)
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> promiseRunAwait [

	| outputElement jsPromise result |

	[
		outputElement := self outputElement.

		jsPromise := CpJavaScriptPromise on: [ :resolveBlock :rejectBlock |
			CpGlobalThis setTimeout: 2000 thenDo: [ resolveBlock value: 'Hello world' ] ].

		outputElement appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Wait 2 seconds...' ;
			yourself).
		result := (jsPromise then: [  :value | value asUppercase ]) await.
		outputElement appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: result ;
			yourself).
		outputElement appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Finished Promise (waited for result)' ;
			yourself)
	] fork
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> promiseRunError [

	| outputElement |

	"Run the following code in separate Process since we can't await in the Event handler Process"
	[
		outputElement := self outputElement.

		outputElement appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Wait 2 seconds...' ;
			yourself).
		[
			(((CpJavaScriptPromise on: [ :resolveBlock :rejectBlock | CpGlobalThis setTimeout: 2000 thenDo: [ resolveBlock value: 'Going to signal an Error (sync waiting for it)' ] ])
				then: [ :value |
					outputElement
						appendChild: ((CpHtmlElement newWithTag: #p)
							textContent: value ;
							yourself) ;
						appendChild: ('This unhandled exception will be caught (the rejection reason follows below)' inHtmlTag: #p) ])
				then: [ :value | self error: 'Error as expected' ]) await
		] on: Error do: [ :error |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Error is caught, because of await on Promise: ', error rootException printString ;
				yourself) ].

		outputElement appendChild: ((CpHtmlElement newWithTag: #p)
			textContent: 'Wait another 2 seconds...' ;
			yourself).
		[
			((CpJavaScriptPromise on: [ :resolveBlock :rejectBlock | CpGlobalThis setTimeout: 2000 thenDo: [ resolveBlock value: 'Going to signal an Error (async no await)' ] ])
				then: [ :value |
					outputElement
						appendChild: ((CpHtmlElement newWithTag: #p)
							textContent: value ;
							yourself) ;
						appendChild: ('Check the console for the message about an unhandled exception. It can''t be caught because of the async nature of Promises. This type of unhandled rejection should be considered a programmer''s error. Please add a #catch: or make the call synchronous using #await to allow a regular Smalltalk [ ... ] on: Error do: [ ...] handler.' inHtmlTag: #p) ])
				then: [ :value | self error: 'Error as expected' ]
		] on: Error do: [ :error |
			outputElement appendChild: ((CpHtmlElement newWithTag: #p)
				textContent: 'Error is never caught, because of async nature of Promises: ', error rootException printString ;
				yourself) ].
	] fork
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> promiseRunTests [

	| outputElement jsPromise result error |

	[
		outputElement := self outputElement.

		jsPromise := CpJavaScriptPromise resolve: 123.
		result := (jsPromise
			then: [ :value |
				value = 123
					ifFalse: [ outputElement appendChild: ('ERROR: resolve failure 1' inHtmlTag: #p) ].
				999 ]
			then: [ :value |
				value = 999
					ifFalse: [ outputElement appendChild: ('ERROR: resolve failure 2' inHtmlTag: #p) ].
			1000 ]) await.
		result = 1000
			ifFalse: [ outputElement appendChild: ('ERROR: resolve failure 3' inHtmlTag: #p) ].

		result := (jsPromise
			then: [ :value | CpJavaScriptPromise reject: 666 ]
			then: [ :value | 123 ]
			catch: [ :reason |
				reason = 666
					ifFalse: [ outputElement appendChild: ('ERROR: reject failure 1' inHtmlTag: #p) ].
				1000 ]) await.
		result = 1000
			ifFalse: [ outputElement appendChild: ('ERROR: reject failure 2' inHtmlTag: #p) ].

		result := (jsPromise
			then: [ :value | error := Error new messageText: 'Oops' ; yourself. error signal ]
			then: [ :value | 123 ]
			catch: [ :reason |
				reason = error
					ifFalse: [ outputElement appendChild: ('ERROR: reject failure 3' inHtmlTag: #p) ].
				1000 ]) await.
		result = 1000
			ifFalse: [ outputElement appendChild: ('ERROR: reject failure 4' inHtmlTag: #p) ].

		result := (jsPromise
			then: [ :value | 345 ]
			thenAwait: [ :value |
				value ~= 345
					ifTrue: [ self error: 'Failed on 345' ].
				(CpJavaScriptPromise resolve: 456) await ]).
		result = 456
			ifFalse: [ outputElement appendChild: ('ERROR: reject failure 5' inHtmlTag: #p) ].

		[ result := jsPromise
			then: [ :value | 345 ]
			thenAwait: [ :value |
				value ~= 345
					ifTrue: [ self error: 'Failed on 345' ].
				(CpJavaScriptPromise reject: 456) await ].
			outputElement appendChild: ('ERROR: reject failure 6' inHtmlTag: #p)
		] on: Error do: [ :err |
			err rootCause = 456
				ifFalse: [ outputElement appendChild: ('ERROR: reject failure 7' inHtmlTag: #p) ] ].

		self traceCr: 'Internal tests done'
	] fork
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| body list items |

	CpHtmlElement documentAddStyle: '
		#menu {
			display: inline-block;
			width: 20em;
			height: calc(100vh - 6em);
			border-right: 1px solid #999;
		}
		#menu li { 
			cursor: pointer;
		}
		#result {
			position: absolute;
			display: inline-block;
			width: calc(100% - 24em);
			height: calc(100vh - 10em);
			padding: 2em;
		}
		#output {
			position: relative;
			width: 100%;
			height: 100%;
		}'.
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>Browser Support Examples</h1>
		<div style="width: 100%; margin: 0; padding: 0;">
			<div id="menu"><ul id="list"></ul></div><div id="result"><div id="output"></div></div>
		</div>
	'.

	list := body firstDescendantMatching: '#list'.

	"Collect items from example methods"

	items := 	OrderedCollection new.
	(self class selectors select: [ :each | each beginsWith: #example ]) do: [ :selector |
		(self class >> selector) properties ifNotNil: [ :properties |
			(properties at: #example:order:) ifNotNil: [ :pragma |
				items add: selector -> pragma arguments ] ] ].

	"Sort items (a and b are associations where the value contains the pragma arguments #title and #order)"
	items sort: [ :a :b |
		"Either the order of a is lower than order of b"
		(a value second < b value second) or: [
			"or the have the same order and a comes before b alphabetically" 
			(a value second = b value second) and: [ a value first < b value first ] ] ].

	"Render items onto DOM"
	items do: [ :item |
				
		list appendChild: ((CpHtmlElement newWithTag: 'li')
			id: item key ;	"ie selector"
			textContent: item value first ;	"ie title"
			when: CpClickEvent send: #stopProcess to: self ;
			when: CpClickEvent send: item key to: self ;
			yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> showInfo: aString [

	self outputElement appendChild: (aString inHtmlTag: #div)
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> speechSpeak [

	| outputElement speakButton text progress speechSynthesis utterance onStartHandler onBoundaryHandler onEndHandler onErrorHandler cleanup |

	outputElement := self outputElement.
	speakButton := outputElement firstDescendantMatching: #button.
	text := (outputElement firstDescendantMatching: '#text') propertyAt: #value.
	progress := outputElement firstDescendantMatching: '#progress'.

	"Disable button first"
	speakButton propertyAt: #disabled put: true.

	"Setup progress information"
	progress textContent: text.

	"Create Utterance"
	utterance := CpBrowserSpeechSynthesisUtterance text: text.
	self speechVoiceSelected ifNotNil: [ :voice |
		self traceCr: 'Set voice: ', voice printString.
		utterance
			voice: voice ;
			lang: voice lang ].

	"Add event handlers"
	cleanup := [
		utterance
			removeEventListener: onStartHandler ;
			removeEventListener: onBoundaryHandler ;
			removeEventListener: onEndHandler ;
			removeEventListener: onErrorHandler.

		"Restore progress"
		progress textContent: text.

		"Enable button again"
		speakButton propertyAt: #disabled put: false ].

	onStartHandler := utterance onStartDo: [ :event | self traceCr: 'start speaking: ', event printString ].
	onBoundaryHandler := utterance onBoundaryDo: [ :event |
		| start end prefix word postfix |
		self traceCr: 'boundary: ', event printString.

		"Select the word being uttered"
		start := (event charIndex + 1) min: text size.
		end := (start + event charLength - 1) min: text size.	"End is inclusive"
		prefix := start = 1
			ifTrue: [ '' ]
			ifFalse: [ text copyFrom: 1 to: start - 1 ].
		word := text copyFrom: start to: end.
		postfix := end < text size
			ifTrue: [ text copyFrom: end + 1 to: text size ]
			ifFalse: [ '' ].

		"Update the progress, showing word being spoken highlighted"
		progress
			removeChildren ;
			appendChild: prefix asHtmlElement ;
			appendChild: (word asHtmlElement
				styleAt: #'border-bottom' put: '4px solid blue' ;
				yourself) ;
			appendChild: postfix asHtmlElement ].
	onEndHandler := utterance onEndDo: [ :event | self traceCr: 'end speaking: ', event printString. cleanup value ].
	onErrorHandler := utterance onErrorDo: [ :event | self traceCr: 'error during speaking: ', event printString. cleanup value ].

	speechSynthesis := CpBrowserSpeechSynthesis current.
	speechSynthesis speak: utterance
]

{ #category : #examples }
CpBrowserSupportExamplesWebClientBehavior >> speechVoiceSelected [

	| voiceIndex |

	"JavaScript has 0-based indices, add 1 to make it 1-based for Smalltalk"
	voiceIndex := ((self outputElement firstDescendantMatching: #select) propertyAt: #selectedIndex) + 1.

	^ CpBrowserSpeechSynthesis current getVoices at: voiceIndex ifAbsent: [ nil ]
]

{ #category : #support }
CpBrowserSupportExamplesWebClientBehavior >> stopProcess [

	process ifNil: [ ^ self ].
	process terminate.
	process := nil
]
