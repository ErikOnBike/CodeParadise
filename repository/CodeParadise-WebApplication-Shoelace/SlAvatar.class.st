Class {
	#name : #SlAvatar,
	#superclass : #SlElement,
	#category : #'CodeParadise-WebApplication-Shoelace-Elements'
}

{ #category : #accessing }
SlAvatar >> image [

	^ self propertyAt: #image
]

{ #category : #accessing }
SlAvatar >> image: aString [

	self propertyAt: #image put: aString
]

{ #category : #accessing }
SlAvatar >> initials [

	^ self propertyAt: #initials
]

{ #category : #accessing }
SlAvatar >> initials: aString [

	self propertyAt: #initials put: aString
]

{ #category : #accessing }
SlAvatar >> label [

	^ self propertyAt: #label
]

{ #category : #accessing }
SlAvatar >> label: aString [

	self propertyAt: #label put: aString
]

{ #category : #accessing }
SlAvatar >> loading [

	^ self propertyAt: #loading
]

{ #category : #accessing }
SlAvatar >> loading: aString [

	self propertyAt: #loading put: aString
]

{ #category : #accessing }
SlAvatar >> shape [

	^ self propertyAt: #shape
]

{ #category : #accessing }
SlAvatar >> shape: aString [

	self propertyAt: #shape put: aString
]

{ #category : #accessing }
SlAvatar >> size [

	^ self customPropertyAt: #size
]

{ #category : #accessing }
SlAvatar >> size: aString [

	self customPropertyAt: #size put: aString
]
