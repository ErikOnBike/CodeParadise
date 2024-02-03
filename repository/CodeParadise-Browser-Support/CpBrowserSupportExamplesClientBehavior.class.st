Class {
	#name : #CpBrowserSupportExamplesClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-Browser-Support-Examples'
}

{ #category : #accessing }
CpBrowserSupportExamplesClientBehavior >> clearOutput [

	self outputElement textContent: ''
]

{ #category : #examples }
CpBrowserSupportExamplesClientBehavior >> clipboardRead [

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
CpBrowserSupportExamplesClientBehavior >> clipboardReadText [

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
CpBrowserSupportExamplesClientBehavior >> clipboardWrite [

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
CpBrowserSupportExamplesClientBehavior >> clipboardWriteText [

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
CpBrowserSupportExamplesClientBehavior >> exampleBrowserClipboard [

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
CpBrowserSupportExamplesClientBehavior >> exampleBrowserGeolocation [

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
CpBrowserSupportExamplesClientBehavior >> exampleBrowserNavigator [

	<example: 'Navigator' order: 1>

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
CpBrowserSupportExamplesClientBehavior >> exampleDNU [

	<example: 'DNU' order: 9999>

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
				yourself) ]
]

{ #category : #examples }
CpBrowserSupportExamplesClientBehavior >> exampleJavaScriptProxy [

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
			when: CpClickEvent primary only do: [ CpJavaScriptObject global setTimeout: [ outputElement appendChild: 'Hello!' asHtmlElement ] duration: 2000 ] ;
			yourself) ;
		yourself
]

{ #category : #examples }
CpBrowserSupportExamplesClientBehavior >> geolocationGetCurrent [

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
CpBrowserSupportExamplesClientBehavior >> initialize [

	super initialize.

	self showIndex
]

{ #category : #accessing }
CpBrowserSupportExamplesClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpBrowserSupportExamplesClientBehavior >> showIndex [

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
			when: CpClickEvent send: item key to: self ;
			yourself) ]
]
