Class {
	#name : #SlElement,
	#superclass : #CpWebComponent,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #initialization }
SlElement class >> eventMappingJS [
	"Javascript fragment to map Shoelace events to known CP events"
	
	^ 'document.body.addEventListener("sl-change", function(evt) {
			console.log("mapping sl-change to change...");
         var cpEvent = new Event("change", { bubbles: true, composed: true });
         evt.target.dispatchEvent(cpEvent);
      });

		document.body.addEventListener("sl-show", function(evt) {
			console.log("mapping sl-show to focus...");
         var cpEvent = new Event("focus", { bubbles: true, composed: true });
         evt.target.dispatchEvent(cpEvent);
      });

		function _cpslPreventEventDefault(element, eventName) {  
			element.addEventListener(eventName, event => event.preventDefault());
		};
		
		function _cpslShowSettingFocusOn(promptElement, focusElement) {  
			console.log("show: ", promptElement, " focusing: ", focusElement);
			
			Promise.all([
  				customElements.whenDefined(promptElement.localName),
  				customElements.whenDefined(focusElement.localName)
  			]).then(() => {
    			promptElement.addEventListener("sl-initial-focus", event => {
      				event.preventDefault();
					console.log("focusing: ", focusElement);
      				focusElement.focus({ preventScroll: true });
    			});
  				promptElement.show();  
			});
		};
'

]

{ #category : #initialization }
SlElement class >> loadLibrary [

	"Load library from CDN"

	CpHtmlElement documentHead
		appendChild:
			((CpHtmlElement newWithTag: #meta)
				attributeAt: #name put: 'viewport' ;
				attributeAt: #content put: 'width=device-width, initial-scale=1.0' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #script)
				attributeAt: #type put: 'module' ;
				attributeAt: #src put: 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.0.0-beta.43/dist/shoelace.js' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #link)
				attributeAt: #rel put: 'stylesheet' ;
				attributeAt: #type put: 'text/css' ;
				attributeAt: #href put: 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.0.0-beta.43/dist/themes/base.css' ;
				yourself) ;
		appendChild:
			((CpHtmlElement newWithTag: #script)
				markupContent: self eventMappingJS ;
				yourself)

]

{ #category : #'instance creation' }
SlElement class >> new [

	"Answer a new instance of the receiver.
	Although not allowed on the receiver or its superclasses,
	new instances of the receiver's subclasses are allowed to be created,
	because the receiver knows its own tag."

	self = SlElement
		ifTrue: [ ^ super new ].

	^ self newWithTag: self tagName
]

{ #category : #'class initialization' }
SlElement class >> postInstall [

	"Install Shoelace library into receiver"

	super postInstall.

	"Load library only once (ie not for subclasses)"
	self = SlElement
		ifTrue: [ self loadLibrary ; waitForLibrary ]
]

{ #category : #initialization }
SlElement class >> waitForLibrary [

	"Wait for library being loaded"

	| activeProcess resumed |

	activeProcess := Processor activeProcess.

	resumed := false.
	(CpTransition onBlock: [ :progress :time |

		"Resume Process if specific component is correctly registered or we timed out"
		(((self isRegistered: 'sl-button') or: [ progress >= 1.0 ]) and: [ resumed not ])
			ifTrue: [
				activeProcess resume.
				resumed := true ] ])
		duration: 2000 ;	"Wait at most 2 seconds"
		start.

	"Suspend receiver here (it will be resumed when library is loaded)"	
	activeProcess suspend.

	"After resume do final check"
	resumed ifFalse: [ self error: 'Failed to load Shoelace library' ]
]

{ #category : #'text input' }
SlElement >> focus: optionsArray [
	"Set the focus to the receiver (ie take focus) with @options
		e.g. { 'preventScroll' -> true } "

	self apply: #focus withArguments: optionsArray asDictionary
]
