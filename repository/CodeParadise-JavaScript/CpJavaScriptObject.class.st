"
I am a Proxy class for JavaScript objects.
I have a very limited set of capabilities, because I am a generic class which
tries to access JavaScript properties and functions in a single way (sending
a message). This has at least one caveat: accessing JavaScript classes is
hard to distinguish from accessing JavaScript functions (a JavaScript class
is represented by its constructor method/function). Therefore accessing a
JavaScript property which happens to be a reference to a JavaScript class,
will fail in the 'default' single way (because the constructor function will
be called, since my behavior assumes the intention was to call the function
instead of answering it). For this situation a special method #getClassRefFrom:
exists which will answer an instance of CpJavaScriptClass which can then be
used to instantiate JavaScript objects from or call static functions (ie Class
methods) on.

To distinguish between regular Smalltalk objects and proxied JavaScript
objects, performing a message is called 'apply' for JavaScript objects
(because JavaScript functions have a method 'apply()' this name is chosen).
There are a few variants like #apply:, #apply:withArguments:, #apply:resultAs:
and #apply:withArguments:resultAs:. The variants with #resultAs: proxy the
result in the specified Proxy Class. This allows subclasses to be created
with a more meaningful interface. See for example CpJavaScriptPromise.

Please do not use me on JavaScript 'primitives' like numbers or strings.
These are, by default, already mapped to Smalltalk classes and will be
converted automagically (two ways).

When creating subclasses, please use the same naming as in JavaScript.
These names should be publicly available (i.e. reachable from global scope).
A prefix and additionally 'JavaScript', 'Browser' and 'NodeJS' are
allowed before the actual Class name. For example:
	CpBrowserClipboard => Clipboard
	MyJavaScriptChart = Chart

When a JavaScript object is proxied using me, I can send messages to the
JavaScript object to:
- get/set properties (which have explicit get/set functions)
- get/set attributes (which do not have explicit get/set functions)
- call functions

If a message with selector #something is sent to an instance of me, the
following steps are taken:
- Check if property exists with the specified name
    - If so, check if zero arguments are present and perform getter
    - If so, check if one argument is present and perform setter
- Check if function exists with the specified name
    - If so, perform it with the supplied arguments (zero or more)
- Check if attribute exists with the specified name
    - If so, check if zero arguments are present and answer value
    - If so, check if one argument is present and assign it to attribute

This means that if a message is sent with multiple arguments and the
selector refers to a property or an attribute, a regular DNU error will
be raised. There is no check for the number of arguments on a function,
since the number of required arguments can't be retrieved from a
JavaScript function.

The known element names (selectors) can be retrieved from the proxied
JavaScript object in my instances using: #getSelectorNames. To get the
type of element use :#getSelectorType: which will answer a symbol (see
the method comment for possible values).

For convenience a DNU handler is installed which will perform the
message on the proxied JavaScript object. This might result in selectors
like #setTimeout:duration: to be send to the JavaScript object. In most
cases this will fail (although JavaScript functions can have colons in
their name, but you have to install these functions a little differently).
If no element is found using the provided selector AND the selector
contains a colon, the selector is trimmed to this colon (excluding it).
So in the above example #setTimeout is used (and the remainder is
ignored).

Implementation:
Since function calls are probably used more often, the described mechanism
above also has a 'fast path' which checks for a function with the specified
selector and if it exists executes it immediately. This fast path does not
take selectors with colons into account. The fast path is for methods we
explicitly call like in CpJavaScriptPromise >> #then:onRejected:

"
Class {
	#name : #CpJavaScriptObject,
	#superclass : #Object,
	#category : #'CodeParadise-JavaScript-Core'
}

{ #category : #accessing }
CpJavaScriptObject class >> apply: aSymbol [

	"Apply the specified selector on the proxied JavaScript object's class side.
	For better performance use #apply:resultAs: if the result Class is known."

	^ self getClass
		apply: aSymbol withArguments: nil resultAs: nil
]

{ #category : #accessing }
CpJavaScriptObject class >> apply: aSymbol resultAs: aProxyClass [

	"Apply the specified selector on the proxied JavaScript object's class side
	and answer the result as an instance of the proxy class specified or answer
	a default object if aProxyClass is nil."

	^ self getClass
		apply: aSymbol withArguments: nil resultAs: aProxyClass
]

{ #category : #accessing }
CpJavaScriptObject class >> apply: aSymbol withArguments: anArray [

	"Apply the specified selector on the proxied JavaScript object's class side
	using the specified arguments (nil means no arguments).
	For better performance use #apply:resultAs: if the result Class is known."

	^ self getClass
		apply: aSymbol withArguments: anArray resultAs: nil
]

{ #category : #accessing }
CpJavaScriptObject class >> apply: aSymbol withArguments: anArray resultAs: aProxyClass [

	"Apply the specified selector on the proxied JavaScript object's class side
	using the specified arguments (nil means no arguments). And answer the result
	as an instance of the proxy class specified or answer a default object
	if aProxyClass is nil."

	^ self getClass
		apply: aSymbol withArguments: anArray resultAs: aProxyClass
]

{ #category : #accessing }
CpJavaScriptObject class >> getClass [

	"Answer the class side Object for the receiver to allow calling class side methods"

	^ CpJavaScriptClass forName: self getClassName
]

{ #category : #accessing }
CpJavaScriptObject class >> getClassName [

	"Answer the name of the JavaScript class.

	Implementation:
	Already taking Browser and Node.js support into account to
	prevent having to implement this on many layers/in many classes.
	Classes in Node.js modules are assumed to have the module class
	name as prefix (be aware: 'module name' is the module class name
	whereas 'moduleName' is a JavaScript module name/identifier)."

	^ self module
		ifNotNil: [ :module | self name withoutPrefix: module name ]
		ifNil: [
			((self nameWithoutPrefix
				withoutPrefix: 'JavaScript')
				withoutPrefix: 'Browser')
				withoutPrefix: 'NodeJS' ]
]

{ #category : #accessing }
CpJavaScriptObject class >> global [

	"Answer a Proxy for the global object/global scope
	(i.e. 'window' object in a web browser and 'global' object in Node.js)"

	^ CpClientEnvironment current
		globalApply: #identity withArguments: nil
]

{ #category : #accessing }
CpJavaScriptObject class >> module [

	"Answer the module the receiver is part of.
	By default JavaScript objects are not part of a module (i.e. they are global)."

	^ nil
]

{ #category : #accessing }
CpJavaScriptObject class >> moduleName [

	"Answer name of the module the receiver is part of (or nil for no module)"

	^ self module
		ifNotNil: [ :module | module moduleName ]
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> new [

	"New instances of the receiver should not be created 'manually'"

	self errorNewReplacedBy: #newInstance
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstance [

	^ self newInstanceWithArguments: nil resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceFor: aString [

	^ self newInstanceFor: aString withArguments: nil resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceFor: aString resultAs: aProxyClass [

	^ self newInstanceFor: aString withArguments: nil resultAs: aProxyClass
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceFor: aString withArguments: anArray [

	^ self newInstanceFor: aString withArguments: anArray resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceFor: aString withArguments: anArray resultAs: aProxyClass [

	"Answer a new proxied instance of the globally defined JavaScript class name
	specified using the specified (optional) arguments when calling the constructor.
	If no Proxy Class is specified, use the default Proxy Class."

	^ (CpJavaScriptClass forName: aString)
		newInstanceWithArguments: anArray resultAs: aProxyClass
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceResultAs: aProxyClass [

	^ self newInstanceWithArguments: nil resultAs: aProxyClass
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceWithArguments: anArray [

	^ self newInstanceWithArguments: anArray resultAs: self
]

{ #category : #'instance creation' }
CpJavaScriptObject class >> newInstanceWithArguments: anArray resultAs: aProxyClass [

	"Answer a new proxied instance of the receiver's JavaScript class
	using the specified (optional) arguments when calling the constructor.
	If no Proxy Class is specified, use the default Proxy Class."

	^ self getClass
		newInstanceWithArguments: anArray resultAs: aProxyClass
]

{ #category : #'class initialization' }
CpJavaScriptObject class >> postInstall [

	self registerProxyClass.

	super postInstall
]

{ #category : #'class initialization' }
CpJavaScriptObject class >> postSnapshot [

	"Re-register class after snapshot (has no effect if already registered)"

	self registerProxyClass.

	super postSnapshot
]

{ #category : #accessing }
CpJavaScriptObject class >> proxyClassName [

	"Answer the (fully qualified) name of the JavaScript class the receiver is proxying.

	Implementation:
	The 'fully qualified' class name consists of: [<module-name>.]<class-name>"
	
	^ self moduleName
		ifNotNil: [ :moduleName | moduleName, '.', self getClassName ]
		ifNil: [ self getClassName ]
]

{ #category : #'class initialization' }
CpJavaScriptObject class >> registerProxyClass [

	"Register the receiver as Proxy class for JavaScript objects"

	self registerProxyClass: self forClassName: self proxyClassName
]

{ #category : #'class initialization' }
CpJavaScriptObject class >> registerProxyClass: aClass forClassName: aString [

	"Register the specified class which acts as a proxy for JavaScript objects with
	the given class name (should be public on global scope)"

	<primitive: 'primitiveJavaScriptObjectRegisterProxyClass:forClassName:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #converting }
CpJavaScriptObject class >> wrap: anObject [

	"Wrap the specified (Smalltalk) Object into the receiver (a JavaScriptObject proxy class)"

	^ self wrap: anObject in: self
]

{ #category : #converting }
CpJavaScriptObject class >> wrap: anObject in: aProxyClass [

	"Wrap the specified (Smalltalk) Object into a JavaScriptObject proxy"

	^ self global
		apply: #identity withArguments: { anObject } resultAs: aProxyClass
]

{ #category : #accessing }
CpJavaScriptObject >> apply: aSymbol [

	"Apply the specified selector on the proxied JavaScript object.
	For better performance use #apply:resultAs: if the result Class is known.

	The selector can refer to properties, attributes or functions. When the selector refers
	to a property a get operation is assumed (since no arguments are specified, please use
	#apply:withAhArguments: for setters).

	To retrieve all selector names allowed, use: #getSelectorNames
	To retrieve the type of a selector use: #getSelectorType:"

	^ self apply: aSymbol withArguments: nil resultAs: nil
]

{ #category : #accessing }
CpJavaScriptObject >> apply: aSymbol resultAs: aProxyClass [

	"Apply the specified selector on the proxied JavaScript object and answer the result as an
	instance of the proxy class specified or answer a default object if aProxyClass is nil.
	The default object will either be a Smalltalk instance if a Smalltalk to JavaScript
	conversion exists and otherwise the default proxy class CpJavaScriptProxy is used.
	If the JavaScript result is 'undefined' or 'null' a nil value is answered (and aProxyClass
	is ignored)."

	^ self apply: aSymbol withArguments: nil resultAs: aProxyClass
]

{ #category : #accessing }
CpJavaScriptObject >> apply: aSymbol withArguments: anArray [

	"Apply the specified selector on the proxied JavaScript object using the specified arguments
	 (nil means no arguments).
	For better performance use #apply:withArguments:resultAs: if the result Class is known.

	The selector can refer to properties, attributes or functions. When the selector refers
	to a property or an attribute zero or one arguments are allowed for get respectively set.
	The set might fail on read-only properties.
	To retrieve all selector names allowed, use: #getSelectorNames
	To retrieve the type of a selector use: #getSelectorType:

	Since JavaScript functions, by default, do not use colons (to create keyword messages)
	there is a naming mismatch. To allow a more Smalltalk like usage (from our #doesNotUnderstand:
	method for example), the specified selector is tried exactly, but if it fails AND it does
	contain one or more colons, a function is tried which consists of the part before the
	first colon. So for examply: #setTimeout:duration: could be used for the window.setTimeout
	function which expects 2 arguments."

	^ self apply: aSymbol withArguments: anArray resultAs: nil
]

{ #category : #accessing }
CpJavaScriptObject >> apply: aSymbol withArguments: anArray resultAs: aProxyClass [

	"Apply the specified selector on the proxied JavaScript object using the specified arguments
	(nil means no arguments). And answer the result as an instance of the proxy class specified
	or answer a default object if aProxyClass is nil. The default object will either be a Smalltalk
	instance if a Smalltalk to JavaScript conversion exists and otherwise the default proxy class
	CpJavaScriptProxy is used.
	If the JavaScript result is 'undefined' or 'null' a nil value is answered (and aProxyClass
	is ignored).

	Implementation:
	Convert Smalltalk Blocks to JavaScript functions if necessary.
	See also CpJavaScriptFunction class >> #wrap:"

	| arguments |

	arguments := anArray ifNotNil: [
		anArray
			detect: [ :each | each isBlock ]
			ifFound: [
				anArray collect: [ :each |
					each isBlock
						ifTrue: [ CpJavaScriptFunction wrap: each ]
						ifFalse: [ each ] ] ]
			ifNone: [ anArray ] ].

	^ self primApply: aSymbol withArguments: arguments resultAs: aProxyClass
]

{ #category : #converting }
CpJavaScriptObject >> as: aProxyClass [

	"Answer the receiver as the specified Proxy class (kindof like casting ;-).

	If aProxyClass is nil, a default Smalltalk conversion is tried. If that
	fails the default Proxy Class is used."

	^ self class wrap: self in: aProxyClass
]

{ #category : #converting }
CpJavaScriptObject >> asSmalltalkObject [

	"Answer the receiver as a Smalltalk object (if this is possible, nil otherwise)"

	| instance |

	"By default a conversion to a Smalltalk object is tried if no Proxy Class is specified"
	instance := self as: nil.

	instance isJavaScriptObject
		ifTrue: [ ^ nil ].

	^ instance
]

{ #category : #printing }
CpJavaScriptObject >> consoleError [

	self consoleLevel: #error
]

{ #category : #printing }
CpJavaScriptObject >> consoleLevel: aSymbol [

	"Log the receiver using the specified log level (#log, #trace, #debug, #info, #warn or #error) to the console"

	(CpJavaScriptObject global propertyAt: #console resultAs: CpJavaScriptObject)
		apply: aSymbol withArguments: { self } resultAs: nil
]

{ #category : #printing }
CpJavaScriptObject >> consoleLog [

	self consoleLevel: #log
]

{ #category : #printing }
CpJavaScriptObject >> consoleTrace [

	"Log the receiver to the console, inclusing stack trace"

	self consoleLevel: #trace
]

{ #category : #printing }
CpJavaScriptObject >> consoleWarn [

	self consoleLevel: #warn
]

{ #category : #'reflective operations' }
CpJavaScriptObject >> doesNotUnderstand: aMessage [

	"Convenience method to allow messages to be sent to a Proxy object directly"

	^ self apply: aMessage selector withArguments: aMessage arguments
]

{ #category : #'apply primitives' }
CpJavaScriptObject >> exceptionClass [

	"Answer the JavaScript exception class which could be thrown by the receiver's methods.
	By default a search is made for a matching Exception class (from the known classes
	installed in the ClientEnvironment). If no such class is found, the Class answered
	here is used (as fallback)."

	^ CpJavaScriptError
]

{ #category : #accessing }
CpJavaScriptObject >> getClass [

	"Answer the class of the proxied JavaScript object"

	^ self propertyAt: #constructor resultAs: CpJavaScriptClass
]

{ #category : #accessing }
CpJavaScriptObject >> getClassRefFrom: aSymbol [

	^ self getClassRefFrom: aSymbol resultAs: CpJavaScriptClass
]

{ #category : #accessing }
CpJavaScriptObject >> getClassRefFrom: aSymbol resultAs: aClass [

	"Answer the JavaScript class which is stored in either a property or
	attribute of the proxied JavaScript object of the receiver using the
	specified class as JavaScript class representation.

	This method will fail if no such element is available. Since the
	distinction between a Class and a function in JavaScript is very
	difficult to make, no checks are performed here.
	
	See also:
	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/prototype#description"

	<primitive: 'primitiveJavaScriptObjectGetClassRefFrom:resultAs:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpJavaScriptObject >> getSelectorNames [

	"Answer the selector names of the proxied JavaScript object (as an Array of Strings).

	Implementation:
	Selector names are answered for actual properties (which have a getter and/or setter),
	attributes (which can be read-only or read-write) and functions."

	<primitive: 'primitiveJavaScriptObjectGetSelectorNames' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpJavaScriptObject >> getSelectorType: aSymbol [

	"Answer a Symbol representing the specified selector's type
	or nil if the specified selector does not exist in the proxied JavaScript object.

	One of the following will be answered:
		#'read-write-prop'
		#'read-prop'
		#'write-prop'
		#'read-write-attr'
		#'read-attr'
		#function
		#unknown

	It is unsure if #unknown will ever be answered (it should not)."

	<primitive: 'primitiveJavaScriptObjectGetSelectorType:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #testing }
CpJavaScriptObject >> isJavaScriptObject [

	^ true
]

{ #category : #enumerating }
CpJavaScriptObject >> keysAndValuesDo: aBlock [

	"Evaluate the specified Block for all properties (not being JS Functions) and their values.

	This is a convenience method to allow Dictionaries and JavaScript Objects to be treated similarly.

	Implementation:
	Property names starting with an underscore are skipped, because it is assumed to be private."

	self getSelectorNames do: [ :each |
		((self getSelectorType: each) ~= #function and: [ each first ~= $_ ])
			ifTrue: [ aBlock value: each value: (self propertyAt: each) ] ]
]

{ #category : #'apply primitives' }
CpJavaScriptObject >> primApply: aSymbol withArguments: anArray resultAs: aProxyClass [

	"Apply the specified selector on the proxied JavaScript object using the specified arguments
	(nil means no arguments). And answer the result as an instance of the proxy class specified
	or answer a default object if aProxyClass is nil. The default object will either be a Smalltalk
	instance if a Smalltalk to JavaScript conversion exists and otherwise the default proxy class
	CpJavaScriptProxy is used.
	If the JavaScript result is 'undefined' or 'null' a nil value is answered (and aProxyClass
	is ignored)."

	| type |

	<primitive: 'primitiveJavaScriptObjectApply:withArguments:resultAs:' module: 'CpSystemPlugin'>

	"Check if an exception was thrown"
	(self primLastExceptionAs: self exceptionClass)
		ifNotNil: [ :exception | ^ exception rootException signal ].

	"Check if selector exists by using #getSelectorType: (if that fails, do not do a DNU)"
	[ type := self getSelectorType: aSymbol ] on: Error do: [ #skipDNU ].

	type ifNil: [ ^ super doesNotUnderstand: (Message selector: aSymbol arguments: anArray) ].

	"Log (generic) error"
	self errorCr: 'Error when calling ', aSymbol, '() on:'.
	self consoleError.

	self primitiveFailed
]

{ #category : #'apply primitives' }
CpJavaScriptObject >> primLastExceptionAs: aProxyClass [

	"Answer the last JavaScript exception thrown.

	Implementation:
	This call will remove the exception value, so it should not be called repeatedly."

	<primitive: 'primitiveJavaScriptObjectLastExceptionAs:' module: 'CpSystemPlugin'>

	^ nil
]

{ #category : #accessing }
CpJavaScriptObject >> primPropertyAt: aSymbol put: anObject [

	"Set the property from the proxied JavaScript object with the specified value.
	In line with regular JavaScript this will set or create a property with the
	given value.

	This method is more forgiving than #apply:witArguments: since it will just
	add a property if not present, instead of raising an error."

	<primitive: 'primitiveJavaScriptObjectPropertyAt:put:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #printing }
CpJavaScriptObject >> printOn: aStream [

	"Print a representation of the receiver onto the specified Stream"

	aStream nextPutAll: self toString
]

{ #category : #accessing }
CpJavaScriptObject >> propertyAt: aSymbol [

	"Get the property from the proxied JavaScript object.
	In line with regular JavaScript this will either answer the
	property value or nil if such a property does not exist or
	its value is null or undefined.

	This method is more forgiving than #apply: since it will just
	answer nil if not present, instead of raising an error."

	^ self propertyAt: aSymbol resultAs: nil
]

{ #category : #accessing }
CpJavaScriptObject >> propertyAt: aSymbol put: anObject [

	"Set the property of the proxied JavaScript object to the specified value.
	In line with regular JavaScript this will set or create a property with the
	given value.

	This method is more forgiving than #apply:witArguments: since it will just
	add a property if not present, instead of raising an error.

	Implementation:
	Convert Smalltalk Blocks to JavaScript functions if necessary.
	See also CpJavaScriptFunction class >> #wrap:"

	self primPropertyAt: aSymbol put: (anObject isBlock
		ifTrue: [ CpJavaScriptFunction wrap: anObject ]
		ifFalse: [ anObject ])
]

{ #category : #accessing }
CpJavaScriptObject >> propertyAt: aSymbol resultAs: aProxyClass [

	"Get the property from the proxied JavaScript object.
	In line with regular JavaScript this will either answer the
	property value or nil if such a property does not exist or
	its value is null or undefined.

	This method is more forgiving than #apply: since it will just
	answer nil if not present, instead of raising an error.
	
	If a proxy Class is specified and the result is an object
	(i.e. not undefined or null) it will be proxied."

	<primitive: 'primitiveJavaScriptObjectPropertyAt:resultAs:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpJavaScriptObject >> rawPropertyAt: aSymbol [

	"Answer the raw property value (i.e. without JavaScript conversion).
	If the property has no value, nil will be answered.
	If the specified property is not a Smalltalk object, the primitive
	will fail."

	<primitive: 'primitiveJavaScriptObjectRawPropertyAt:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #accessing }
CpJavaScriptObject >> rawPropertyAt: aSymbol put: anObject [

	"Set the property with the specified raw value (i.e. without JavaScript conversion)"

	<primitive: 'primitiveJavaScriptObjectRawPropertyAt:put:' module: 'CpSystemPlugin'>
	self primitiveFailed
]

{ #category : #converting }
CpJavaScriptObject >> toString [

	^ self apply: #toString
]
