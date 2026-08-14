Class {
	#name : #WaPagination,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaPagination >> appearance [

	"The pagination's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'outlined' | 'filled' | 'plain'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaPagination >> appearance: aString [

	"The pagination's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'outlined' | 'filled' | 'plain'"

	self propertyAt: #appearance put: aString
]

{ #category : #'accessing - convenience' }
WaPagination >> appearanceFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #'accessing - convenience' }
WaPagination >> appearanceOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #'accessing - convenience' }
WaPagination >> appearancePlain [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #plain
]

{ #category : #'accessing - convenience' }
WaPagination >> beDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: true
]

{ #category : #'accessing - convenience' }
WaPagination >> beHideSinglePage [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self hideSinglePage: true
]

{ #category : #'accessing - convenience' }
WaPagination >> beNotDisabled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self disabled: false
]

{ #category : #'accessing - convenience' }
WaPagination >> beNotHideSinglePage [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self hideSinglePage: false
]

{ #category : #'accessing - convenience' }
WaPagination >> beWithEdges [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withEdges: true
]

{ #category : #'accessing - convenience' }
WaPagination >> beWithNav [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutNav: false
]

{ #category : #'accessing - convenience' }
WaPagination >> beWithSummary [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withSummary: true
]

{ #category : #'accessing - convenience' }
WaPagination >> beWithoutEdges [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withEdges: false
]

{ #category : #'accessing - convenience' }
WaPagination >> beWithoutNav [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withoutNav: true
]

{ #category : #'accessing - convenience' }
WaPagination >> beWithoutSummary [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withSummary: false
]

{ #category : #accessing }
WaPagination >> boundaryCount [

	"The number of pages to always show at the start and end.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #boundaryCount
]

{ #category : #accessing }
WaPagination >> boundaryCount: aNumber [

	"The number of pages to always show at the start and end.
	
	Type: Number
	Default: 1"

	self propertyAt: #boundaryCount put: aNumber
]

{ #category : #accessing }
WaPagination >> disabled [

	"Disables the pagination.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #disabled
]

{ #category : #accessing }
WaPagination >> disabled: aBoolean [

	"Disables the pagination.
	
	Type: Boolean
	Default: false"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #'accessing - slots' }
WaPagination >> firstIconElement [

	"An icon to use in lieu of the default first icon."

	^ self firstChildAtSlotNamed: #'first-icon'
]

{ #category : #'accessing - slots' }
WaPagination >> firstIconElement: anElement [

	"An icon to use in lieu of the default first icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'first-icon'
]

{ #category : #accessing }
WaPagination >> format [

	"The pagination's layout. The default `standard` format shows the full page list with ellipses; `compact` collapses
	it into a short ""1 of 5"" label flanked by the previous and next buttons, useful in tight spaces like toolbars and
	cards.
	
	Type: String
	Default: 'standard'
	Allowed: 'standard' | 'compact'"

	^ self propertyAt: #format
]

{ #category : #accessing }
WaPagination >> format: aString [

	"The pagination's layout. The default `standard` format shows the full page list with ellipses; `compact` collapses
	it into a short ""1 of 5"" label flanked by the previous and next buttons, useful in tight spaces like toolbars and
	cards.
	
	Type: String
	Default: 'standard'
	Allowed: 'standard' | 'compact'"

	self propertyAt: #format put: aString
]

{ #category : #accessing }
WaPagination >> hideSinglePage [

	"Renders nothing when there's only one page.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #hideSinglePage
]

{ #category : #accessing }
WaPagination >> hideSinglePage: aBoolean [

	"Renders nothing when there's only one page.
	
	Type: Boolean
	Default: false"

	self propertyAt: #hideSinglePage put: aBoolean
]

{ #category : #accessing }
WaPagination >> hrefTemplate [

	"A URL template used to render page items as links instead of buttons. When set, items render as `<a>` elements for
	SSR, SEO, and no-JS support. Provide a string with `{page}` as a placeholder for the page number, e.g.
	`/products?page={page}`. In JavaScript, you can also assign a function that receives the page number and returns
	the URL, e.g. `el.hrefTemplate = page => \`/products?page=${page}\``.
	
	Type: BlockClosureOrString (string | ((page: number) => string))
	Default: ''"

	^ self propertyAt: #hrefTemplate
]

{ #category : #accessing }
WaPagination >> hrefTemplate: aBlockClosureOrString [

	"A URL template used to render page items as links instead of buttons. When set, items render as `<a>` elements for
	SSR, SEO, and no-JS support. Provide a string with `{page}` as a placeholder for the page number, e.g.
	`/products?page={page}`. In JavaScript, you can also assign a function that receives the page number and returns
	the URL, e.g. `el.hrefTemplate = page => \`/products?page=${page}\``.
	
	Type: BlockClosureOrString (string | ((page: number) => string))
	Default: ''"

	self propertyAt: #hrefTemplate put: aBlockClosureOrString
]

{ #category : #accessing }
WaPagination >> label [

	"A label that describes the pagination to assistive devices. This won't be shown on the screen, but it will be
	announced by screen readers. Especially useful when more than one pagination control exists on the same page.
	
	Type: String
	Default: ''"

	^ self propertyAt: #label
]

{ #category : #accessing }
WaPagination >> label: aString [

	"A label that describes the pagination to assistive devices. This won't be shown on the screen, but it will be
	announced by screen readers. Especially useful when more than one pagination control exists on the same page.
	
	Type: String
	Default: ''"

	self propertyAt: #label put: aString
]

{ #category : #'accessing - slots' }
WaPagination >> lastIconElement [

	"An icon to use in lieu of the default last icon."

	^ self firstChildAtSlotNamed: #'last-icon'
]

{ #category : #'accessing - slots' }
WaPagination >> lastIconElement: anElement [

	"An icon to use in lieu of the default last icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'last-icon'
]

{ #category : #'accessing - slots' }
WaPagination >> nextIconElement [

	"An icon to use in lieu of the default next icon."

	^ self firstChildAtSlotNamed: #'next-icon'
]

{ #category : #'accessing - slots' }
WaPagination >> nextIconElement: anElement [

	"An icon to use in lieu of the default next icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'next-icon'
]

{ #category : #accessing }
WaPagination >> page [

	"The current page, starting at 1.
	
	Type: Number
	Default: 1"

	^ self propertyAt: #page
]

{ #category : #accessing }
WaPagination >> page: aNumber [

	"The current page, starting at 1.
	
	Type: Number
	Default: 1"

	self propertyAt: #page put: aNumber
]

{ #category : #accessing }
WaPagination >> pageSize [

	"The number of items shown per page.
	
	Type: Number
	Default: 10"

	^ self propertyAt: #pageSize
]

{ #category : #accessing }
WaPagination >> pageSize: aNumber [

	"The number of items shown per page.
	
	Type: Number
	Default: 10"

	self propertyAt: #pageSize put: aNumber
]

{ #category : #'accessing - slots' }
WaPagination >> previousIconElement [

	"An icon to use in lieu of the default previous icon."

	^ self firstChildAtSlotNamed: #'previous-icon'
]

{ #category : #'accessing - slots' }
WaPagination >> previousIconElement: anElement [

	"An icon to use in lieu of the default previous icon."

	self replaceAllChildrenWith: anElement atSlotNamed: #'previous-icon'
]

{ #category : #accessing }
WaPagination >> siblingCount [

	"The number of pages to show on each side of the current page.
	
	Type: Number
	Default: 2"

	^ self propertyAt: #siblingCount
]

{ #category : #accessing }
WaPagination >> siblingCount: aNumber [

	"The number of pages to show on each side of the current page.
	
	Type: Number
	Default: 2"

	self propertyAt: #siblingCount put: aNumber
]

{ #category : #'accessing - convenience' }
WaPagination >> slotNames [

	^ #(#'previous-icon' #'next-icon' #'first-icon' #'last-icon')
]

{ #category : #accessing }
WaPagination >> total [

	"The total number of items to paginate.
	
	Type: Number
	Default: 0"

	^ self propertyAt: #total
]

{ #category : #accessing }
WaPagination >> total: aNumber [

	"The total number of items to paginate.
	
	Type: Number
	Default: 0"

	self propertyAt: #total put: aNumber
]

{ #category : #accessing }
WaPagination >> totalPages [

	"The total number of pages, derived from `total` and `pageSize`.
	
	Type: Number
	Read-only: true"

	^ self propertyAt: #totalPages
]

{ #category : #accessing }
WaPagination >> withEdges [

	"Shows buttons that jump to the first and last pages.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withEdges
]

{ #category : #accessing }
WaPagination >> withEdges: aBoolean [

	"Shows buttons that jump to the first and last pages.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withEdges put: aBoolean
]

{ #category : #accessing }
WaPagination >> withSummary [

	"Shows a summary of the items on the current page, e.g. ""1–10 of 237"".
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withSummary
]

{ #category : #accessing }
WaPagination >> withSummary: aBoolean [

	"Shows a summary of the items on the current page, e.g. ""1–10 of 237"".
	
	Type: Boolean
	Default: false"

	self propertyAt: #withSummary put: aBoolean
]

{ #category : #accessing }
WaPagination >> withoutNav [

	"Hides the previous and next buttons.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withoutNav
]

{ #category : #accessing }
WaPagination >> withoutNav: aBoolean [

	"Hides the previous and next buttons.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withoutNav put: aBoolean
]
