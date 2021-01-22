Class {
	#name : #CpControl,
	#superclass : #CpView,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'state handling' }
CpControl >> disable [

	"Disable the receiver.
	
	Implementation:
	If receiver is not already disabled, also disable all children."

	(self attributeAt: #disabled)
		ifNotNil: [ :disabled |

			"Change disabled state from secundary to primary (assume children are already disabled secundary)"
			disabled = #parent
				ifTrue: [ self attributeAdd: #disabled ] ]
		ifNil: [
			self attributeAdd: #disabled.
			self children do: [ :each | each disableSecundary ] ]
]

{ #category : #private }
CpControl >> disableSecundary [

	"Disable the receiver because an ancestor is disabled.
	
	Implementation:
	If receiver is not already disabled, also disable all children."

	(self attributeAt: #disabled)
		ifNil: [
			self attributeAt: #disabled put: #parent.
			self children do: [ :each | each disableSecundary ] ]
]

{ #category : #'state handling' }
CpControl >> enable [

	"Enable the receiver.
	
	Implementation:
	If receiver is not already enabled, also enable all children which are
	themselves not disabled."

	(self attributeAt: #disabled)
		ifNotNil: [ :disabled |

			"Only allow enabling of primary disabled elements (instead of secundary disabled elements)"
			disabled = #parent
				ifFalse: [

					"Update disabled state depending on parent state"
					(self parent attributeAt: #disabled)
						ifNotNil: [ self attributeAt: #disabled put: #parent ]
						ifNil: [
							self removeAttributeAt: #disabled.
							self children do: [ :each | each enableSecundary ] ] ] ]
]

{ #category : #private }
CpControl >> enableSecundary [

	"Enable the receiver because an ancestor is enabled.
	
	Implementation:
	If receiver is not already enabled, also enable all children which are
	themselves not disabled."

	(self attributeAt: #disabled)
		ifNotNil: [ :disabled |

			"Only allow enabling of secundary disabled elements"
			disabled = #parent
				ifTrue: [
					self removeAttributeAt: #disabled.
					self children do: [ :each | each enableSecundary ] ] ]
]

{ #category : #'testing - conditionals' }
CpControl >> ifDisabled: aBlock [

	"Evaluate a Block if the receiver is in a disabled state"

	self ifEnabled: [ "intentionally empty" ] ifDisabled: aBlock
]

{ #category : #'testing - conditionals' }
CpControl >> ifEnabled: aBlock [

	"Evaluate a Block if the receiver is not in a disabled state"

	self ifEnabled: aBlock ifDisabled: [ "intentionally empty" ]
]

{ #category : #'testing - conditionals' }
CpControl >> ifEnabled: enabledBlock ifDisabled: disabledBlock [

	"Evaluate a Block depending on the receiver's disabled state"

	(self attributeAt: #disabled)
		ifNotNil: [ disabledBlock value ]
		ifNil: [ enabledBlock value ]
]
