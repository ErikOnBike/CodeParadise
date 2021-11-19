Class {
	#name : #SlInput,
	#superclass : #SlTextControl,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #'accessing style' }
SlInput >> beClearable [

	self clearable: true
]

{ #category : #'accessing type' }
SlInput >> beDate [

	"Causes a popup date selector, however the date type might not be supported on all browsers"
	
	self type: #date
]

{ #category : #'accessing type' }
SlInput >> beEmail [

	self type: #email
]

{ #category : #'accessing style' }
SlInput >> beNotClearable [

	self clearable: false
]

{ #category : #'accessing style' }
SlInput >> beNotPill [

	self pill: false
]

{ #category : #'accessing style' }
SlInput >> beNotTogglePassword [

	self togglePassword: false
]

{ #category : #'accessing type' }
SlInput >> beNumber [

	self type: #number
]

{ #category : #'accessing type' }
SlInput >> bePassword [

	self type: #password
]

{ #category : #'accessing style' }
SlInput >> bePill [

	self pill: true
]

{ #category : #'accessing type' }
SlInput >> beSearch [

	self type: #search
]

{ #category : #'accessing type' }
SlInput >> beTel [

	self type: #tel
]

{ #category : #'accessing type' }
SlInput >> beText [

	self type: #text
]

{ #category : #'accessing style' }
SlInput >> beTogglePassword [

	self togglePassword: true
]

{ #category : #'accessing type' }
SlInput >> beUrl [

	self type: #url
]

{ #category : #accessing }
SlInput >> clearIcon [

	self firstChildAtSlotNamed: #'clear-icon'
]

{ #category : #accessing }
SlInput >> clearIcon: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #'clear-icon'
]

{ #category : #accessing }
SlInput >> clearable: aBoolean [

	self propertyAt: #clearable put: aBoolean
]

{ #category : #accessing }
SlInput >> hidePasswordIcon [

	self firstChildAtSlotNamed: #'hide-password-icon'
]

{ #category : #accessing }
SlInput >> hidePasswordIcon: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #'hide-password-icon'
]

{ #category : #testing }
SlInput >> isClearable [

	^ self propertyAt: #clearable
]

{ #category : #testing }
SlInput >> isPill [

	^ self propertyAt: #pill
]

{ #category : #testing }
SlInput >> isTogglePassword [

	^ self propertyAt: #togglePassword
]

{ #category : #accessing }
SlInput >> max [

	^ self propertyAt: #max
]

{ #category : #accessing }
SlInput >> max: aNumberOrString [

	self propertyAt: #max put: aNumberOrString
]

{ #category : #accessing }
SlInput >> min [

	^ self propertyAt: #min
]

{ #category : #accessing }
SlInput >> min: aNumberOrString [

	self propertyAt: #min put: aNumberOrString
]

{ #category : #accessing }
SlInput >> pill: aBoolean [

	self propertyAt: #pill put: aBoolean
]

{ #category : #accessing }
SlInput >> prefix [

	^ self firstChildAtSlotNamed: #prefix
]

{ #category : #accessing }
SlInput >> prefix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #prefix
]

{ #category : #accessing }
SlInput >> showPasswordIcon [

	self firstChildAtSlotNamed: #'show-password-icon'
]

{ #category : #accessing }
SlInput >> showPasswordIcon: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #'show-password-icon'
]

{ #category : #accessing }
SlInput >> step [

	^ self propertyAt: #step
]

{ #category : #accessing }
SlInput >> step: aNumber [

	self propertyAt: #step put: aNumber
]

{ #category : #accessing }
SlInput >> suffix [

	^ self firstChildAtSlotNamed: #suffix
]

{ #category : #accessing }
SlInput >> suffix: anElement [

	self replaceAllChildrenWith: anElement atSlotNamed: #suffix
]

{ #category : #accessing }
SlInput >> togglePassword: aBoolean [

	self propertyAt: #togglePassword put: aBoolean
]

{ #category : #accessing }
SlInput >> type [

	^ self propertyAt: #type
]

{ #category : #accessing }
SlInput >> type: aString [

	self propertyAt: #type put: aString
]
