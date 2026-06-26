Class {
	#name : #WaCard,
	#superclass : #WaElement,
	#category : #'CodeParadise-WebApplication-WebAwesome-Elements'
}

{ #category : #accessing }
WaCard >> appearance [

	"The card's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	^ self propertyAt: #appearance
]

{ #category : #accessing }
WaCard >> appearance: aString [

	"The card's visual appearance.
	
	Type: String
	Default: 'outlined'
	Allowed: 'accent' | 'filled' | 'outlined' | 'filled-outlined' | 'plain'"

	self propertyAt: #appearance put: aString
]

{ #category : #convenience }
WaCard >> beAccent [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #accent
]

{ #category : #convenience }
WaCard >> beFilled [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #filled
]

{ #category : #convenience }
WaCard >> beFilledOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #'filled-outlined'
]

{ #category : #convenience }
WaCard >> beOutlined [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #outlined
]

{ #category : #convenience }
WaCard >> bePlain [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self appearance: #plain
]

{ #category : #convenience }
WaCard >> beWithFooter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooter: true
]

{ #category : #convenience }
WaCard >> beWithFooterActions [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooterActions: true
]

{ #category : #convenience }
WaCard >> beWithHeader [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHeader: true
]

{ #category : #convenience }
WaCard >> beWithHeaderActions [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHeaderActions: true
]

{ #category : #convenience }
WaCard >> beWithMedia [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withMedia: true
]

{ #category : #convenience }
WaCard >> beWithoutFooter [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooter: false
]

{ #category : #convenience }
WaCard >> beWithoutFooterActions [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withFooterActions: false
]

{ #category : #convenience }
WaCard >> beWithoutHeader [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHeader: false
]

{ #category : #convenience }
WaCard >> beWithoutHeaderActions [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withHeaderActions: false
]

{ #category : #convenience }
WaCard >> beWithoutMedia [

	"This is a convenience method to prevent having to provide arguments to a genric setter method"

	self withMedia: false
]

{ #category : #accessing }
WaCard >> orientation [

	"Renders the card's orientation *
	
	Type: String
	Default: 'vertical'
	Allowed: 'horizontal' | 'vertical'"

	^ self propertyAt: #orientation
]

{ #category : #accessing }
WaCard >> orientation: aString [

	"Renders the card's orientation *
	
	Type: String
	Default: 'vertical'
	Allowed: 'horizontal' | 'vertical'"

	self propertyAt: #orientation put: aString
]

{ #category : #accessing }
WaCard >> withFooter [

	"Only required for SSR. Set to `true` if you're slotting in a `footer` element so the server-rendered markup
	includes the footer before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withFooter
]

{ #category : #accessing }
WaCard >> withFooter: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `footer` element so the server-rendered markup
	includes the footer before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withFooter put: aBoolean
]

{ #category : #accessing }
WaCard >> withFooterActions [

	"Only required for SSR. Set to `true` if you're slotting in a `footer-actions` element so the server-rendered markup
	includes the media before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withFooterActions
]

{ #category : #accessing }
WaCard >> withFooterActions: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `footer-actions` element so the server-rendered markup
	includes the media before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withFooterActions put: aBoolean
]

{ #category : #accessing }
WaCard >> withHeader [

	"Only required for SSR. Set to `true` if you're slotting in a `header` element so the server-rendered markup
	includes the header before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHeader
]

{ #category : #accessing }
WaCard >> withHeader: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `header` element so the server-rendered markup
	includes the header before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHeader put: aBoolean
]

{ #category : #accessing }
WaCard >> withHeaderActions [

	"Only required for SSR. Set to `true` if you're slotting in a `header-actions` element so the server-rendered markup
	includes the media before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withHeaderActions
]

{ #category : #accessing }
WaCard >> withHeaderActions: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `header-actions` element so the server-rendered markup
	includes the media before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withHeaderActions put: aBoolean
]

{ #category : #accessing }
WaCard >> withMedia [

	"Only required for SSR. Set to `true` if you're slotting in a `media` element so the server-rendered markup
	includes the media before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	^ self propertyAt: #withMedia
]

{ #category : #accessing }
WaCard >> withMedia: aBoolean [

	"Only required for SSR. Set to `true` if you're slotting in a `media` element so the server-rendered markup
	includes the media before the component hydrates on the client.
	
	Type: Boolean
	Default: false"

	self propertyAt: #withMedia put: aBoolean
]
