Class {
	#name : #IonAccordionGroup,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonAccordionGroup >> animated [

	"If 'true', all accordions inside of the accordion group will animate when expanding or collapsing.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonAccordionGroup >> animated: aBoolean [

	"If 'true', all accordions inside of the accordion group will animate when expanding or collapsing.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonAccordionGroup >> disabled [

	"If 'true', the accordion group cannot be interacted with.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonAccordionGroup >> disabled: aBoolean [

	"If 'true', the accordion group cannot be interacted with.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonAccordionGroup >> expand [

	"Describes the expansion behavior for each accordion. Possible values are ''compact'' and ''inset''. Defaults to ''compact''.
	
	Type: 'compact' | 'inset'"

	^ self propertyAt: #expand
]

{ #category : #api }
IonAccordionGroup >> expand: aString [

	"Describes the expansion behavior for each accordion. Possible values are ''compact'' and ''inset''. Defaults to ''compact''.
	
	Type: 'compact' | 'inset'"

	self propertyAt: #expand put: aString
]

{ #category : #api }
IonAccordionGroup >> getAccordions [

	"Type: Promise<HTMLIonAccordionElement[]>"

	^ self apply: #getAccordions resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAccordionGroup >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonAccordionGroup >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonAccordionGroup >> multiple [

	"If 'true', the accordion group can have multiple accordion components expanded at the same time.
	
	Type: boolean"

	^ self propertyAt: #multiple
]

{ #category : #api }
IonAccordionGroup >> multiple: aBoolean [

	"If 'true', the accordion group can have multiple accordion components expanded at the same time.
	
	Type: boolean"

	self propertyAt: #multiple put: aBoolean
]

{ #category : #api }
IonAccordionGroup >> readonly [

	"If 'true', the accordion group cannot be interacted with, but does not alter the opacity.
	
	Type: boolean"

	^ self propertyAt: #readonly
]

{ #category : #api }
IonAccordionGroup >> readonly: aBoolean [

	"If 'true', the accordion group cannot be interacted with, but does not alter the opacity.
	
	Type: boolean"

	self propertyAt: #readonly put: aBoolean
]

{ #category : #api }
IonAccordionGroup >> requestAccordionToggle: accordionValue accordionExpand: accordionExpand [

	"This method is used to ensure that the value of ion-accordion-group is being set in a valid way. This method should only be called in response to a user generated action.
	
	Type: (accordionValue: string | undefined, accordionExpand: boolean) => Promise<void>"

	^ self apply: #requestAccordionToggle withArguments: { accordionValue . accordionExpand } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonAccordionGroup >> value [

	"The value of the accordion group. This controls which accordions are expanded. This should be an array of strings only when 'multiple='true''
	
	Type: string | string[] | null"

	^ self propertyAt: #value
]

{ #category : #api }
IonAccordionGroup >> value: anObject [

	"The value of the accordion group. This controls which accordions are expanded. This should be an array of strings only when 'multiple='true''
	
	Type: string | string[] | null"

	self propertyAt: #value put: anObject
]
