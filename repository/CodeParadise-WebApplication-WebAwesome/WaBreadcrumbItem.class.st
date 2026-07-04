Class {
	#name : #WaBreadcrumbItem,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #'accessing - slots' }
WaBreadcrumbItem >> endElement [

	"An element, such as `<wa-icon>`, placed after the label."

	^ self firstChildAtSlotNamed: #end
]

{ #category : #'accessing - slots' }
WaBreadcrumbItem >> endElement: anElement [

	"An element, such as `<wa-icon>`, placed after the label."

	self replaceAllChildrenWith: anElement atSlotNamed: #end
]

{ #category : #accessing }
WaBreadcrumbItem >> href [

	"Optional URL to direct the user to when the breadcrumb item is activated. When set, a link will be rendered
	internally. When unset, a button will be rendered instead.
	
	Type: String"

	^ self propertyAt: #href
]

{ #category : #accessing }
WaBreadcrumbItem >> href: aString [

	"Optional URL to direct the user to when the breadcrumb item is activated. When set, a link will be rendered
	internally. When unset, a button will be rendered instead.
	
	Type: String"

	self propertyAt: #href put: aString
]

{ #category : #accessing }
WaBreadcrumbItem >> rel [

	"The `rel` attribute to use on the link. Only used when `href` is set.
	
	Type: String
	Default: 'noreferrer noopener'"

	^ self propertyAt: #rel
]

{ #category : #accessing }
WaBreadcrumbItem >> rel: aString [

	"The `rel` attribute to use on the link. Only used when `href` is set.
	
	Type: String
	Default: 'noreferrer noopener'"

	self propertyAt: #rel put: aString
]

{ #category : #'accessing - slots' }
WaBreadcrumbItem >> separatorElement [

	"The separator to use for the breadcrumb item. This will only change the separator for this item. If you want to change it for all items in the group, set the separator on `<wa-breadcrumb>` instead."

	^ self firstChildAtSlotNamed: #separator
]

{ #category : #'accessing - slots' }
WaBreadcrumbItem >> separatorElement: anElement [

	"The separator to use for the breadcrumb item. This will only change the separator for this item. If you want to change it for all items in the group, set the separator on `<wa-breadcrumb>` instead."

	self replaceAllChildrenWith: anElement atSlotNamed: #separator
]

{ #category : #'accessing - slots' }
WaBreadcrumbItem >> startElement [

	"An element, such as `<wa-icon>`, placed before the label."

	^ self firstChildAtSlotNamed: #start
]

{ #category : #'accessing - slots' }
WaBreadcrumbItem >> startElement: anElement [

	"An element, such as `<wa-icon>`, placed before the label."

	self replaceAllChildrenWith: anElement atSlotNamed: #start
]

{ #category : #accessing }
WaBreadcrumbItem >> target [

	"Tells the browser where to open the link. Only used when `href` is set.
	
	Type: String
	Allowed: '_blank' | '_parent' | '_self' | '_top'"

	^ self propertyAt: #target
]

{ #category : #accessing }
WaBreadcrumbItem >> target: aString [

	"Tells the browser where to open the link. Only used when `href` is set.
	
	Type: String
	Allowed: '_blank' | '_parent' | '_self' | '_top'"

	self propertyAt: #target put: aString
]
