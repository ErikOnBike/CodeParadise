Class {
	#name : #IonBreadcrumbs,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonBreadcrumbs >> color [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	^ self propertyAt: #color
]

{ #category : #api }
IonBreadcrumbs >> color: aString [

	"The color to use from your application's color palette. Default options are: ''primary'', ''secondary'', ''tertiary'', ''success'', ''warning'', ''danger'', ''light'', ''medium'', and ''dark''. For more information on colors, see [theming](/docs/theming/basics).
	
	Type: Color"

	self propertyAt: #color put: aString
]

{ #category : #api }
IonBreadcrumbs >> itemsAfterCollapse [

	"The number of breadcrumbs to show after the collapsed indicator. If 'itemsBeforeCollapse' + 'itemsAfterCollapse' is greater than 'maxItems', the breadcrumbs will not be collapsed.
	
	Type: number"

	^ self propertyAt: #itemsAfterCollapse
]

{ #category : #api }
IonBreadcrumbs >> itemsAfterCollapse: aNumber [

	"The number of breadcrumbs to show after the collapsed indicator. If 'itemsBeforeCollapse' + 'itemsAfterCollapse' is greater than 'maxItems', the breadcrumbs will not be collapsed.
	
	Type: number"

	self propertyAt: #itemsAfterCollapse put: aNumber
]

{ #category : #api }
IonBreadcrumbs >> itemsBeforeCollapse [

	"The number of breadcrumbs to show before the collapsed indicator. If 'itemsBeforeCollapse' + 'itemsAfterCollapse' is greater than 'maxItems', the breadcrumbs will not be collapsed.
	
	Type: number"

	^ self propertyAt: #itemsBeforeCollapse
]

{ #category : #api }
IonBreadcrumbs >> itemsBeforeCollapse: aNumber [

	"The number of breadcrumbs to show before the collapsed indicator. If 'itemsBeforeCollapse' + 'itemsAfterCollapse' is greater than 'maxItems', the breadcrumbs will not be collapsed.
	
	Type: number"

	self propertyAt: #itemsBeforeCollapse put: aNumber
]

{ #category : #api }
IonBreadcrumbs >> maxItems [

	"The maximum number of breadcrumbs to show before collapsing.
	
	Type: number"

	^ self propertyAt: #maxItems
]

{ #category : #api }
IonBreadcrumbs >> maxItems: aNumber [

	"The maximum number of breadcrumbs to show before collapsing.
	
	Type: number"

	self propertyAt: #maxItems put: aNumber
]

{ #category : #api }
IonBreadcrumbs >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonBreadcrumbs >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]
