Class {
	#name : #CpBrowserCSSStyleDeclaration,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-Browser-Support-CSS'
}

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> cssText [

	"Textual representation of the declaration block, if and only if it is exposed via HTMLElement.style. Setting this attribute changes the inline style. If you want a text representation of a computed declaration block, you can get it with JSON.stringify()."

	^ self propertyAt: #cssText
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> cssText: aString [

	"Textual representation of the declaration block, if and only if it is exposed via HTMLElement.style. Setting this attribute changes the inline style. If you want a text representation of a computed declaration block, you can get it with JSON.stringify()."

	self propertyAt: #cssText put: aString
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> getPropertyPriority: aString [

	"Returns the optional priority, 'important'."

	^ self apply: #getPropertyPriority withArguments: { aString }
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> getPropertyValue: aString [

	"Returns the property value (a String) given a property name."

	^ self apply: #getPropertyValue withArguments: { aString }
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> itemAt: anInteger [

	"Returns a CSS property name by its index, or the empty string if the index is out-of-bounds."

	^ self apply: #item withArguments: { anInteger }
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> length [

	"The number of properties. See the item() method below."

	^ self propertyAt: #length
]

{ #category : #convenience }
CpBrowserCSSStyleDeclaration >> nameAt: anInteger [

	"Returns a CSS property name by its index, or the empty string if the index is out-of-bounds."

	^ self itemAt: anInteger
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> removeProperty: aString [

	"Removes a property from the CSS declaration block."

	^ self apply: #removeProperty withArguments: { aString }
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> setProperty: nameString to: valueString [

	"Modifies an existing CSS property or creates a new CSS property in the declaration block."

	^ self setProperty: nameString to: valueString priority: ''
]

{ #category : #accessing }
CpBrowserCSSStyleDeclaration >> setProperty: nameString to: valueString priority: priorityString [

	"Modifies an existing CSS property or creates a new CSS property in the declaration block."

	^ self apply: #setProperty withArguments: { nameString . valueString . priorityString }
]
