Class {
	#name : #CpWebAwesomeExamplesWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#instVars : [
		'current'
	],
	#category : #'CodeParadise-WebApplication-WebAwesome-Examples'
}

{ #category : #'class initialization' }
CpWebAwesomeExamplesWebClientBehavior class >> beLoaded [

	WaButton beLoaded.
	WaIcon beLoaded.
	WaDivider beLoaded.
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addAndShowSlide: anElement [

	| slides |

	slides := self slides.

	slides appendChild: (WaCarouselItem new
		appendChild: anElement ;
		yourself).

	"Update dialog label from new slide element"
	self addDialog
		label: (anElement propertyAt: #title).

	"Show the new slide"
	slides next.

	self slideBackButton beNotDisabled
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addBooleanProperty: nameString default: aBoolean comment: commentString do: aBlock [

	| element |

	(CpHtmlElement elementWithId: #properties)
		appendChild: (element := WaCheckbox new
			textContent: nameString ;
			defaultChecked: aBoolean ;
			when: CpChangeEvent do: [ :event | aBlock value: self visual value: event currentTarget checked ] for: self ;
			yourself).

	self addComment: commentString toElement: element

]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addComment: aString toElement: anElement [

	| id |

	id := 'tooltip', (CpHtmlElement documentBody allDescendantsMatching: WaTooltip asCssSelector) size printString.

	anElement id: id.

	anElement parent
		appendChild: (WaTooltip new
			attributeAt: #for put: id ;
			placementTopStart ;
			beWithoutArrow ;
			maxWidth: '80em' ;
			styleAt: #'white-space' put: 'pre-line' ;
			textContent: (String streamContents: [ :stream |
				stream
					nextPutAll: (aString replaceAll: Character cr with: Character lf) ;
					lf ;
					nextPutAll: '<Press ESC to remove this tooltip>' ]) ;
			yourself)
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addDialog [

	^ CpHtmlElement elementWithId: #addDialog
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> addEventHandlers [

	(CpHtmlElement elementWithId: #addButton)
		when: CpClickEvent basicPrimary send: #handleAddButtonClicked to: self.

	(CpHtmlElement elementWithId: #sourceButton)
		when: CpClickEvent basicPrimary send: #handleSourceButtonClicked to: self.

	(CpHtmlElement elementWithId: #resetButton)
		when: CpClickEvent basicPrimary send: #handleResetButtonClicked to: self.

	(CpHtmlElement elementWithId: #slideBackButton)
		when: CpClickEvent basicPrimary send: #handleSlideBackButtonClicked to: self.

	(CpHtmlElement elementWithId: #slideCloseButton)
		when: CpClickEvent basicPrimary send: #handleSlideCloseButtonClicked to: self.

	(CpHtmlElement elementWithId: #srcCloseButton)
		when: CpClickEvent basicPrimary send: #handleSourceCloseButtonClicked to: self.

	(CpHtmlElement elementWithId: #addParentButton)
		when: CpClickEvent basicPrimary send: #handleAddParentButtonClicked to: self.

	(CpHtmlElement elementWithId: #addChildButton)
		when: CpClickEvent basicPrimary send: #handleAddChildButtonClicked to: self
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addHtmlContent [

	| slide slot html element |

	slide := self lastSlide.
	slot := self selectedSlot.

	html := (slide firstDescendantMatching: WaTextarea asCssSelector) value.

	element := (CpHtmlElement newWithTag: #div)
		markupContent: html ;
		yourself.

	element children do: [ :each |
		self visual
			appendChild: each atSlotNamed: slot ].

	self addDialog beNotOpen
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addIconContent: aClickEvent [

	| slide slot |

	slide := self lastSlide.
	slot := self selectedSlot.

	self visual
		appendChild: (WaIcon new
			name: aClickEvent currentTarget name ;
			yourself)
		atSlotNamed: slot.

	self addDialog beNotOpen
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addMethod: aString do: aBlock [

	(CpHtmlElement elementWithId: #methods)
		appendChild: (WaButton new
			textContent: aString ;
			when: CpClickEvent basicPrimary do: [ :event | CpGlobalThis setTimeout: 200 thenDo: [ aBlock value: self visual ] ] for: self ;
			yourself)
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addNumberProperty: aString default: aNumber do: aBlock [

	(CpHtmlElement elementWithId: #properties)
		appendChild: (WaInput new
			label: aString ;
			type: #number ;
			value: aNumber ;
			when: CpKeyUpEvent enter do: [ :event | aBlock value: self visual value: event currentTarget value ] for: self ;
			yourself)
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addParentButton [

	^ CpHtmlElement elementWithId: #addParentButton
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addSelectionProperty: nameString options: aCollection default: defaultString comment: commentString do: aBlock [

	| selection |

	aCollection size > 5
		ifTrue: [
			selection := WaSelect new
				label: nameString ;
				when: CpChangeEvent do: [ :event | aBlock value: self visual value: event currentTarget value ] for: self ;
				yourself.

			aCollection do: [ :each |
				selection appendChild: (WaOption new
					value: each ;
					textContent: each ;
					defaultSelected: each = defaultString ;
					yourself) ] ]
		ifFalse: [
			selection := WaRadioGroup new
				label: nameString ;
				value: defaultString ;
				orientation: #horizontal ;
				when: CpChangeEvent do: [ :event | aBlock value: self visual value: event currentTarget value ] for: self ;
				yourself.

			aCollection do: [ :each |
				selection appendChild: (WaRadio new
					value: each ;
					textContent: each ;
					yourself) ] ].

	(CpHtmlElement elementWithId: #properties)
		appendChild: selection.

	self addComment: commentString toElement: selection
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addSelectionProperty: nameString options: aCollection default: defaultString do: aBlock [

	| selection |

	aCollection size > 5
		ifTrue: [
			selection := WaSelect new
				label: nameString ;
				when: CpChangeEvent do: [ :event | aBlock value: self visual value: event currentTarget value ] for: self ;
				yourself.

			aCollection do: [ :each |
				selection appendChild: (WaOption new
					value: each ;
					textContent: each ;
					defaultSelected: each = defaultString ;
					yourself) ] ]
		ifFalse: [
			selection := WaRadioGroup new
				label: nameString ;
				value: defaultString ;
				orientation: #horizontal ;
				when: CpChangeEvent do: [ :event | aBlock value: self visual value: event currentTarget value ] for: self ;
				yourself.

			aCollection do: [ :each |
				selection appendChild: (WaRadio new
					value: each ;
					textContent: each ;
					yourself) ] ].

	(CpHtmlElement elementWithId: #properties)
		appendChild: selection
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addStringProperty: nameString default: defaultString do: aBlock [

	(CpHtmlElement elementWithId: #properties)
		appendChild: (WaInput new
			label: nameString ;
			value: defaultString ;
			when: CpKeyUpEvent enter do: [ :event | aBlock value: self visual value: event currentTarget value ] for: self ;
			yourself)
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> addTextContent [

	| slide slot text |

	slide := self lastSlide.
	slot := self selectedSlot.

	text := (slide firstDescendantMatching: WaInput asCssSelector) value.

	self visual
		appendChild: text asHtmlElement
		atSlotNamed: slot.

	self addDialog beNotOpen
]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaAccordion [

	self visual: WaAccordion new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined' 'plain') default: 'outlined' comment: 'The accordion''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined'' | ''plain''
' do: [ :element :value | element appearance: value ].
	self addStringProperty: #headingLevel default: '3' do: [ :element :value | element headingLevel: value ].
	self addSelectionProperty: #iconPlacement options: #('start' 'end') default: 'end' comment: 'The location of the expand/collapse icon in child items.

Type: String
Default: ''end''
Allowed: ''start'' | ''end''
' do: [ :element :value | element iconPlacement: value ].
	self addSelectionProperty: #mode options: #('single' 'single-collapsible' 'multiple') default: 'multiple' comment: 'Controls how items can be expanded. `multiple` (the default) allows any number of items to be open at
once. `single` allows only one item to be open at a time; opening a new item collapses the previously
open one, and clicking an open item does not collapse it. `single-collapsible` is the same as `single`
except that clicking the open item collapses it, so zero open items is a valid state.

Type: String
Default: ''multiple''
Allowed: ''single'' | ''single-collapsible'' | ''multiple''
' do: [ :element :value | element mode: value ].
	self addMethod: #collapseAll do: [ :element | element perform: #collapseAll ].
	self addMethod: #expandAll do: [ :element | element perform: #expandAll ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaAccordionItem [

	self visual: WaAccordionItem new.

	self addBooleanProperty: #disabled default: false comment: 'Disables the accordion item so it can''t be toggled.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addBooleanProperty: #expanded default: false comment: 'Expands the accordion item.

Type: Boolean
Default: false
' do: [ :element :value | element expanded: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addMethod: #toggle do: [ :element | element perform: #toggle ].
	self addMethod: #expand do: [ :element | element perform: #expand ].
	self addMethod: #collapse do: [ :element | element perform: #collapse ].
	self addMethod: #focus do: [ :element | element perform: #focus ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaAnimatedImage [

	self visual: WaAnimatedImage new.

	self addStringProperty: #alt default: nil do: [ :element :value | element alt: value ].
	self addBooleanProperty: #play default: false comment: 'Plays the animation. When this attribute is remove, the animation will pause.

Type: Boolean
' do: [ :element :value | element play: value ].
	self addStringProperty: #src default: nil do: [ :element :value | element src: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaAnimation [

	self visual: WaAnimation new.

	self addNumberProperty: #currentTime default: nil do: [ :element :value | element currentTime: value ].
	self addNumberProperty: #delay default: 0 do: [ :element :value | element delay: value ].
	self addStringProperty: #direction default: 'normal' do: [ :element :value | element direction: value ].
	self addNumberProperty: #duration default: 1000 do: [ :element :value | element duration: value ].
	self addStringProperty: #easing default: 'linear' do: [ :element :value | element easing: value ].
	self addNumberProperty: #endDelay default: 0 do: [ :element :value | element endDelay: value ].
	self addStringProperty: #fill default: 'auto' do: [ :element :value | element fill: value ].
	self addNumberProperty: #iterationStart default: 0 do: [ :element :value | element iterationStart: value ].
	self addNumberProperty: #iterations default: Float infinity do: [ :element :value | element iterations: value ].
	self addStringProperty: #name default: 'none' do: [ :element :value | element name: value ].
	self addBooleanProperty: #play default: false comment: 'Plays the animation. When omitted, the animation will be paused. This attribute will be automatically removed when
the animation finishes or gets canceled.

Type: Boolean
Default: false
' do: [ :element :value | element play: value ].
	self addNumberProperty: #playbackRate default: 1 do: [ :element :value | element playbackRate: value ].
	self addMethod: #finish do: [ :element | element perform: #finish ].
	self addMethod: #cancel do: [ :element | element perform: #cancel ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaAvatar [

	self visual: WaAvatar new.

	self addStringProperty: #image default: '' do: [ :element :value | element image: value ].
	self addStringProperty: #initials default: '' do: [ :element :value | element initials: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addSelectionProperty: #loading options: #('eager' 'lazy') default: 'eager' comment: 'Indicates how the browser should load the image.

Type: String
Default: ''eager''
Allowed: ''eager'' | ''lazy''
' do: [ :element :value | element loading: value ].
	self addSelectionProperty: #shape options: #('circle' 'square' 'rounded') default: 'circle' comment: 'The shape of the avatar.

Type: String
Default: ''circle''
Allowed: ''circle'' | ''square'' | ''rounded''
' do: [ :element :value | element shape: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaBadge [

	self visual: WaBadge new.

	self addSelectionProperty: #appearance options: #('accent' 'filled' 'outlined' 'filled-outlined') default: 'accent' comment: 'The badge''s visual appearance.

Type: String
Default: ''accent''
Allowed: ''accent'' | ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addSelectionProperty: #attention options: #('none' 'pulse' 'bounce') default: 'none' comment: 'Adds an animation to draw attention to the badge.

Type: String
Default: ''none''
Allowed: ''none'' | ''pulse'' | ''bounce''
' do: [ :element :value | element attention: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style badge with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addSelectionProperty: #variant options: #('brand' 'neutral' 'success' 'warning' 'danger') default: 'brand' comment: 'The badge''s theme variant. Defaults to `brand` if not within another element with a variant.

Type: String
Default: ''brand''
Allowed: ''brand'' | ''neutral'' | ''success'' | ''warning'' | ''danger''
' do: [ :element :value | element variant: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaBreadcrumb [

	self visual: WaBreadcrumb new.

	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaBreadcrumbItem [

	self visual: WaBreadcrumbItem new.

	self addStringProperty: #href default: nil do: [ :element :value | element href: value ].
	self addStringProperty: #rel default: 'noreferrer noopener' do: [ :element :value | element rel: value ].
	self addSelectionProperty: #target options: #('_blank' '_parent' '_self' '_top') default: '_blank' comment: 'Tells the browser where to open the link. Only used when `href` is set.

Type: String
Allowed: ''_blank'' | ''_parent'' | ''_self'' | ''_top''
' do: [ :element :value | element target: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaButton [

	self visual: WaButton new.

	self addSelectionProperty: #appearance options: #('accent' 'filled' 'outlined' 'filled-outlined' 'plain') default: 'accent' comment: 'The button''s visual appearance.

Type: String
Default: ''accent''
Allowed: ''accent'' | ''filled'' | ''outlined'' | ''filled-outlined'' | ''plain''
' do: [ :element :value | element appearance: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the button.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #download default: nil do: [ :element :value | element download: value ].
	self addStringProperty: #formAction default: nil do: [ :element :value | element formAction: value ].
	self addSelectionProperty: #formEnctype options: #('application/x-www-form-urlencoded' 'multipart/form-data' 'text/plain') default: 'application/x-www-form-urlencoded' comment: 'Used to override the form owner''s `enctype` attribute.

Type: String
Allowed: ''application/x-www-form-urlencoded'' | ''multipart/form-data'' | ''text/plain''
' do: [ :element :value | element formEnctype: value ].
	self addSelectionProperty: #formMethod options: #('post' 'get') default: 'post' comment: 'Used to override the form owner''s `method` attribute.

Type: String
Allowed: ''post'' | ''get''
' do: [ :element :value | element formMethod: value ].
	self addBooleanProperty: #formNoValidate default: false comment: 'Used to override the form owner''s `novalidate` attribute.

Type: Boolean
' do: [ :element :value | element formNoValidate: value ].
	self addSelectionProperty: #formTarget options: #('_self' '_blank' '_parent' '_top') default: '_self' comment: 'Used to override the form owner''s `target` attribute.

Type: String
Allowed: ''_self'' | ''_blank'' | ''_parent'' | ''_top''
' do: [ :element :value | element formTarget: value ].
	self addStringProperty: #href default: nil do: [ :element :value | element href: value ].
	self addBooleanProperty: #loading default: false comment: 'Draws the button in a loading state.

Type: Boolean
Default: false
' do: [ :element :value | element loading: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style button with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addStringProperty: #rel default: nil do: [ :element :value | element rel: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The button''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addSelectionProperty: #target options: #('_blank' '_parent' '_self' '_top') default: '_blank' comment: 'Tells the browser where to open the link. Only used when `href` is present.

Type: String
Allowed: ''_blank'' | ''_parent'' | ''_self'' | ''_top''
' do: [ :element :value | element target: value ].
	self addSelectionProperty: #type options: #('button' 'submit' 'reset') default: 'button' comment: 'The type of button. Note that the default value is `button` instead of `submit`, which is opposite of how native
`<button>` elements behave. When the type is `submit`, the button will submit the surrounding form.

Type: String
Default: ''button''
Allowed: ''button'' | ''submit'' | ''reset''
' do: [ :element :value | element type: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addSelectionProperty: #variant options: #('neutral' 'brand' 'success' 'warning' 'danger') default: 'neutral' comment: 'The button''s theme variant. Defaults to `neutral` if not within another element with a variant.

Type: String
Default: ''neutral''
Allowed: ''neutral'' | ''brand'' | ''success'' | ''warning'' | ''danger''
' do: [ :element :value | element variant: value ].
	self addBooleanProperty: #withCaret default: false comment: 'Draws the button with a caret. Used to indicate that the button triggers a dropdown menu or similar behavior.

Type: Boolean
Default: false
' do: [ :element :value | element withCaret: value ].
	self addBooleanProperty: #withEnd default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in an `end` element so the server-rendered markup
includes the end slot before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withEnd: value ].
	self addBooleanProperty: #withStart default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `start` element so the server-rendered markup
includes the start slot before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withStart: value ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #click do: [ :element | element perform: #click ].
	self addMethod: #focus do: [ :element | element perform: #focus ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaButtonGroup [

	self visual: WaButtonGroup new.

	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'horizontal' comment: 'The button group''s orientation.

Type: String
Default: ''horizontal''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCallout [

	self visual: WaCallout new.

	self addSelectionProperty: #appearance options: #('accent' 'filled' 'outlined' 'plain' 'filled-outlined') default: 'accent' comment: 'The callout''s visual appearance.

Type: String
Allowed: ''accent'' | ''filled'' | ''outlined'' | ''plain'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The callout''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addSelectionProperty: #variant options: #('brand' 'neutral' 'success' 'warning' 'danger') default: 'brand' comment: 'The callout''s theme variant. Defaults to `brand` if not within another element with a variant.

Type: String
Default: ''brand''
Allowed: ''brand'' | ''neutral'' | ''success'' | ''warning'' | ''danger''
' do: [ :element :value | element variant: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCard [

	self visual: WaCard new.

	self addSelectionProperty: #appearance options: #('accent' 'filled' 'outlined' 'filled-outlined' 'plain') default: 'outlined' comment: 'The card''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''accent'' | ''filled'' | ''outlined'' | ''filled-outlined'' | ''plain''
' do: [ :element :value | element appearance: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'vertical' comment: 'Renders the card''s orientation *

Type: String
Default: ''vertical''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addBooleanProperty: #withFooter default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `footer` element so the server-rendered markup
includes the footer before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withFooter: value ].
	self addBooleanProperty: #withFooterActions default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `footer-actions` element so the server-rendered markup
includes the media before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withFooterActions: value ].
	self addBooleanProperty: #withHeader default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `header` element so the server-rendered markup
includes the header before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHeader: value ].
	self addBooleanProperty: #withHeaderActions default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `header-actions` element so the server-rendered markup
includes the media before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHeaderActions: value ].
	self addBooleanProperty: #withMedia default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `media` element so the server-rendered markup
includes the media before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withMedia: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCarousel [

	self visual: WaCarousel new.

	self addBooleanProperty: #autoplay default: false comment: 'When set, the slides will scroll automatically when the user is not interacting with them.

Type: Boolean
Default: false
' do: [ :element :value | element autoplay: value ].
	self addNumberProperty: #autoplayInterval default: 3000 do: [ :element :value | element autoplayInterval: value ].
	self addBooleanProperty: #loop default: false comment: 'When set, allows the user to navigate the carousel in the same direction indefinitely.

Type: Boolean
Default: false
' do: [ :element :value | element loop: value ].
	self addBooleanProperty: #mouseDragging default: false comment: 'When set, it is possible to scroll through the slides by dragging them with the mouse.

Type: Boolean
Default: false
' do: [ :element :value | element mouseDragging: value ].
	self addBooleanProperty: #navigation default: false comment: 'When set, show the carousel''s navigation.

Type: Boolean
Default: false
' do: [ :element :value | element navigation: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'horizontal' comment: 'Specifies the orientation in which the carousel will lay out.

Type: String
Default: ''horizontal''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addBooleanProperty: #pagination default: false comment: 'When set, show the carousel''s pagination indicators.

Type: Boolean
Default: false
' do: [ :element :value | element pagination: value ].
	self addNumberProperty: #slidesPerMove default: 1 do: [ :element :value | element slidesPerMove: value ].
	self addNumberProperty: #slidesPerPage default: 1 do: [ :element :value | element slidesPerPage: value ].
	self addMethod: #previous do: [ :element | element perform: #previous ].
	self addMethod: #next do: [ :element | element perform: #next ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCarouselItem [

	self visual: WaCarouselItem new.


]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCheckbox [

	self visual: WaCheckbox new.

	self addBooleanProperty: #checked default: false comment: 'The default value of the form control. Primarily used for resetting the form control.

Type: Boolean
' do: [ :element :value | element checked: value ].
	self addBooleanProperty: #defaultChecked default: false comment: 'The default value of the form control. Primarily used for resetting the form control.

Type: Boolean
' do: [ :element :value | element defaultChecked: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the checkbox.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addBooleanProperty: #indeterminate default: false comment: 'Draws the checkbox in an indeterminate state. This is usually applied to checkboxes that represents a "select
all/none" behavior when associated checkboxes have a mix of checked and unchecked states.

Type: Boolean
Default: false
' do: [ :element :value | element indeterminate: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the checkbox a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The checkbox''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addMethod: #click do: [ :element | element perform: #click ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #blur do: [ :element | element perform: #blur ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCheckboxGroup [

	self visual: WaCheckboxGroup new.

	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'vertical' comment: 'The orientation in which to show grouped checkboxes.

Type: String
Default: ''vertical''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addBooleanProperty: #required default: false comment: 'Indicates that at least one option should be selected. This only adds a visual indicator to the label. To enforce
the requirement, use the `required` attribute on the individual checkboxes and/or their `setCustomValidity()`
method.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'xs' comment: 'The group''s size. When present, this size will be applied to all `<wa-checkbox>` and `<wa-switch>` items inside.

Type: String
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup includes
the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup includes
the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaColorPicker [

	self visual: WaColorPicker new.

	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the color picker.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #format options: #('hex' 'rgb' 'hsl' 'hsv') default: 'hex' comment: 'The format to use. If opacity is enabled, these will translate to HEXA, RGBA, HSLA, and HSVA respectively. The color
picker will accept user input in any format (including CSS color names) and convert it to the desired format.

Type: String
Default: ''hex''
Allowed: ''hex'' | ''rgb'' | ''hsl'' | ''hsv''
' do: [ :element :value | element format: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #opacity default: false comment: 'Shows the opacity slider. Enabling this will cause the formatted value to be HEXA, RGBA, or HSLA.

Type: Boolean
Default: false
' do: [ :element :value | element opacity: value ].
	self addBooleanProperty: #open default: false comment: 'Indicates whether or not the popup is open. You can toggle this attribute to show and hide the popup, or you
can use the `show()` and `hide()` methods and this attribute will reflect the popup''s open state.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addSelectionProperty: #placement options: #('top' 'top-start' 'top-end' 'bottom' 'bottom-start' 'bottom-end' 'right' 'right-start' 'right-end' 'left' 'left-start' 'left-end') default: 'bottom-start' comment: 'The preferred placement of the color picker''s popup. Note that the actual placement will vary as configured to
keep the panel inside of the viewport.

Type: String
Default: ''bottom-start''
Allowed: ''top'' | ''top-start'' | ''top-end'' | ''bottom'' | ''bottom-start'' | ''bottom-end'' | ''right'' | ''right-start'' | ''right-end'' | ''left'' | ''left-start'' | ''left-end''
' do: [ :element :value | element placement: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the color picker a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'Determines the size of the color picker''s trigger

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #swatches default: '' do: [ :element :value | element swatches: value ].
	self addBooleanProperty: #uppercase default: false comment: 'By default, values are lowercase. With this attribute, values will be uppercase instead.

Type: Boolean
Default: false
' do: [ :element :value | element uppercase: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addBooleanProperty: #withoutFormatToggle default: false comment: 'Removes the button that lets users toggle between format.

Type: Boolean
Default: false
' do: [ :element :value | element withoutFormatToggle: value ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #show do: [ :element | element perform: #show ].
	self addMethod: #reportValidity do: [ :element | element perform: #reportValidity ].
	self addMethod: #getFormattedValue do: [ :element | element perform: #getFormattedValue ].
	self addMethod: #hide do: [ :element | element perform: #hide ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #focus do: [ :element | element perform: #focus ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaComparison [

	self visual: WaComparison new.

	self addNumberProperty: #position default: 50 do: [ :element :value | element position: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaCopyButton [

	self visual: WaCopyButton new.

	self addStringProperty: #copyLabel default: '' do: [ :element :value | element copyLabel: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the copy button.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #errorLabel default: '' do: [ :element :value | element errorLabel: value ].
	self addNumberProperty: #feedbackDuration default: 1000 do: [ :element :value | element feedbackDuration: value ].
	self addStringProperty: #from default: '' do: [ :element :value | element from: value ].
	self addStringProperty: #successLabel default: '' do: [ :element :value | element successLabel: value ].
	self addSelectionProperty: #tooltip options: #('full' 'copy' 'none') default: 'full' comment: 'Controls the built-in tooltip. `full` (default) shows the tooltip on hover and focus and during copy feedback.
`copy` keeps the tooltip silent on hover/focus and only shows it briefly to confirm a successful or failed copy.
`none` disables the tooltip entirely. Applies to both the default and custom triggers.

Type: String
Default: ''full''
Allowed: ''full'' | ''copy'' | ''none''
' do: [ :element :value | element tooltip: value ].
	self addSelectionProperty: #tooltipPlacement options: #('top' 'right' 'bottom' 'left') default: 'top' comment: 'The preferred placement of the tooltip.

Type: String
Default: ''top''
Allowed: ''top'' | ''right'' | ''bottom'' | ''left''
' do: [ :element :value | element tooltipPlacement: value ].
	self addStringProperty: #value default: '' do: [ :element :value | element value: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaDetails [

	self visual: WaDetails new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined' 'plain') default: 'outlined' comment: 'The element''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined'' | ''plain''
' do: [ :element :value | element appearance: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the details so it can''t be toggled.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #iconPlacement options: #('start' 'end') default: 'end' comment: 'The location of the expand/collapse icon.

Type: String
Default: ''end''
Allowed: ''start'' | ''end''
' do: [ :element :value | element iconPlacement: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #open default: false comment: 'Indicates whether or not the details is open. You can toggle this attribute to show and hide the details, or you
can use the `show()` and `hide()` methods and this attribute will reflect the details'' open state.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addStringProperty: #summary default: nil do: [ :element :value | element summary: value ].
	self addMethod: #show do: [ :element | element perform: #show ].
	self addMethod: #hide do: [ :element | element perform: #hide ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaDialog [

	self visual: WaDialog new.

	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addBooleanProperty: #lightDismiss default: false comment: 'When enabled, the dialog will be closed when the user clicks outside of it.

Type: Boolean
Default: false
' do: [ :element :value | element lightDismiss: value ].
	self addBooleanProperty: #open default: false comment: 'Indicates whether or not the dialog is open. Toggle this attribute to show and hide the dialog.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addBooleanProperty: #withFooter default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `footer` element so the server-rendered markup
includes the footer before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withFooter: value ].
	self addBooleanProperty: #withoutHeader default: false comment: 'Disables the header. This will also remove the default close button.

Type: Boolean
Default: false
' do: [ :element :value | element withoutHeader: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaDivider [

	self visual: WaDivider new.

	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'horizontal' comment: 'Sets the divider''s orientation.

Type: String
Default: ''horizontal''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaDrawer [

	self visual: WaDrawer new.

	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addBooleanProperty: #lightDismiss default: false comment: 'When enabled, the drawer will be closed when the user clicks outside of it.

Type: Boolean
Default: false
' do: [ :element :value | element lightDismiss: value ].
	self addBooleanProperty: #open default: false comment: 'Indicates whether or not the drawer is open. Toggle this attribute to show and hide the drawer.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addSelectionProperty: #placement options: #('top' 'end' 'bottom' 'start') default: 'end' comment: 'The direction from which the drawer will open.

Type: String
Default: ''end''
Allowed: ''top'' | ''end'' | ''bottom'' | ''start''
' do: [ :element :value | element placement: value ].
	self addBooleanProperty: #withFooter default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `footer` element so the server-rendered markup
includes the footer before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withFooter: value ].
	self addBooleanProperty: #withoutHeader default: false comment: 'Disables the header. This will also remove the default close button.

Type: Boolean
Default: false
' do: [ :element :value | element withoutHeader: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaDropdown [

	self visual: WaDropdown new.

	self addNumberProperty: #distance default: 0 do: [ :element :value | element distance: value ].
	self addBooleanProperty: #open default: false comment: 'Opens or closes the dropdown.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addSelectionProperty: #placement options: #('top' 'top-start' 'top-end' 'bottom' 'bottom-start' 'bottom-end' 'right' 'right-start' 'right-end' 'left' 'left-start' 'left-end') default: 'bottom-start' comment: 'The placement of the dropdown menu in reference to the trigger. The menu will shift to a more optimal location if
the preferred placement doesn''t have enough room.

Type: String
Default: ''bottom-start''
Allowed: ''top'' | ''top-start'' | ''top-end'' | ''bottom'' | ''bottom-start'' | ''bottom-end'' | ''right'' | ''right-start'' | ''right-end'' | ''left'' | ''left-start'' | ''left-end''
' do: [ :element :value | element placement: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The dropdown''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addNumberProperty: #skidding default: 0 do: [ :element :value | element skidding: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaDropdownItem [

	self visual: WaDropdownItem new.

	self addBooleanProperty: #checked default: false comment: 'Set to true to check the dropdown item. Only valid when `type` is `checkbox`.

Type: Boolean
Default: false
' do: [ :element :value | element checked: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the dropdown item.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addBooleanProperty: #submenuOpen default: false comment: 'Whether the submenu is currently open.

Type: Boolean
Default: false
' do: [ :element :value | element submenuOpen: value ].
	self addSelectionProperty: #type options: #('normal' 'checkbox') default: 'normal' comment: 'Set to `checkbox` to make the item a checkbox.

Type: String
Default: ''normal''
Allowed: ''normal'' | ''checkbox''
' do: [ :element :value | element type: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addSelectionProperty: #variant options: #('danger' 'default') default: 'default' comment: 'The type of menu item to render.

Type: String
Default: ''default''
Allowed: ''danger'' | ''default''
' do: [ :element :value | element variant: value ].
	self addMethod: #openSubmenu do: [ :element | element perform: #openSubmenu ].
	self addMethod: #closeSubmenu do: [ :element | element perform: #closeSubmenu ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaFormatBytes [

	self visual: WaFormatBytes new.

	self addSelectionProperty: #display options: #('long' 'short' 'narrow') default: 'short' comment: 'Determines how to display the result, e.g. "100 bytes", "100 b", or "100b".

Type: String
Default: ''short''
Allowed: ''long'' | ''short'' | ''narrow''
' do: [ :element :value | element display: value ].
	self addSelectionProperty: #unit options: #('byte' 'bit') default: 'byte' comment: 'The type of unit to display.

Type: String
Default: ''byte''
Allowed: ''byte'' | ''bit''
' do: [ :element :value | element unit: value ].
	self addNumberProperty: #value default: 0 do: [ :element :value | element value: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaFormatDate [

	self visual: WaFormatDate new.

	self addSelectionProperty: #day options: #('numeric' '2-digit') default: 'numeric' comment: 'The format for displaying the day.

Type: String
Allowed: ''numeric'' | ''2-digit''
' do: [ :element :value | element day: value ].
	self addSelectionProperty: #era options: #('narrow' 'short' 'long') default: 'narrow' comment: 'The format for displaying the era.

Type: String
Allowed: ''narrow'' | ''short'' | ''long''
' do: [ :element :value | element era: value ].
	self addSelectionProperty: #hour options: #('numeric' '2-digit') default: 'numeric' comment: 'The format for displaying the hour.

Type: String
Allowed: ''numeric'' | ''2-digit''
' do: [ :element :value | element hour: value ].
	self addSelectionProperty: #hourFormat options: #('auto' '12' '24') default: 'auto' comment: 'The format for displaying the hour.

Type: String
Default: ''auto''
Allowed: ''auto'' | ''12'' | ''24''
' do: [ :element :value | element hourFormat: value ].
	self addSelectionProperty: #minute options: #('numeric' '2-digit') default: 'numeric' comment: 'The format for displaying the minute.

Type: String
Allowed: ''numeric'' | ''2-digit''
' do: [ :element :value | element minute: value ].
	self addSelectionProperty: #month options: #('numeric' '2-digit' 'narrow' 'short' 'long') default: 'numeric' comment: 'The format for displaying the month.

Type: String
Allowed: ''numeric'' | ''2-digit'' | ''narrow'' | ''short'' | ''long''
' do: [ :element :value | element month: value ].
	self addSelectionProperty: #second options: #('numeric' '2-digit') default: 'numeric' comment: 'The format for displaying the second.

Type: String
Allowed: ''numeric'' | ''2-digit''
' do: [ :element :value | element second: value ].
	self addStringProperty: #timeZone default: nil do: [ :element :value | element timeZone: value ].
	self addSelectionProperty: #timeZoneName options: #('short' 'long') default: 'short' comment: 'The format for displaying the time.

Type: String
Allowed: ''short'' | ''long''
' do: [ :element :value | element timeZoneName: value ].
	self addSelectionProperty: #weekday options: #('narrow' 'short' 'long') default: 'narrow' comment: 'The format for displaying the weekday.

Type: String
Allowed: ''narrow'' | ''short'' | ''long''
' do: [ :element :value | element weekday: value ].
	self addSelectionProperty: #year options: #('numeric' '2-digit') default: 'numeric' comment: 'The format for displaying the year.

Type: String
Allowed: ''numeric'' | ''2-digit''
' do: [ :element :value | element year: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaFormatNumber [

	self visual: WaFormatNumber new.

	self addStringProperty: #currency default: 'USD' do: [ :element :value | element currency: value ].
	self addSelectionProperty: #currencyDisplay options: #('symbol' 'narrowSymbol' 'code' 'name') default: 'symbol' comment: 'How to display the currency.

Type: String
Default: ''symbol''
Allowed: ''symbol'' | ''narrowSymbol'' | ''code'' | ''name''
' do: [ :element :value | element currencyDisplay: value ].
	self addNumberProperty: #maximumFractionDigits default: nil do: [ :element :value | element maximumFractionDigits: value ].
	self addNumberProperty: #maximumSignificantDigits default: nil do: [ :element :value | element maximumSignificantDigits: value ].
	self addNumberProperty: #minimumFractionDigits default: nil do: [ :element :value | element minimumFractionDigits: value ].
	self addNumberProperty: #minimumIntegerDigits default: nil do: [ :element :value | element minimumIntegerDigits: value ].
	self addNumberProperty: #minimumSignificantDigits default: nil do: [ :element :value | element minimumSignificantDigits: value ].
	self addSelectionProperty: #type options: #('currency' 'decimal' 'percent') default: 'decimal' comment: 'The formatting style to use.

Type: String
Default: ''decimal''
Allowed: ''currency'' | ''decimal'' | ''percent''
' do: [ :element :value | element type: value ].
	self addNumberProperty: #value default: 0 do: [ :element :value | element value: value ].
	self addBooleanProperty: #withoutGrouping default: false comment: 'Turns off grouping separators.

Type: Boolean
Default: false
' do: [ :element :value | element withoutGrouping: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaIcon [

	self visual: WaIcon new.

	self addSelectionProperty: #animation options: #('beat' 'fade' 'beat-fade' 'bounce' 'flip' 'flip-360' 'shake' 'spin' 'spin-pulse' 'spin-reverse' 'spin-snap' 'spin-snap-4' 'spin-snap-8' 'buzz' 'wag' 'float' 'swing' 'jello') default: 'beat' comment: 'Sets the animation for the icon

Type: String
Allowed: ''beat'' | ''fade'' | ''beat-fade'' | ''bounce'' | ''flip'' | ''flip-360'' | ''shake'' | ''spin'' | ''spin-pulse'' | ''spin-reverse'' | ''spin-snap'' | ''spin-snap-4'' | ''spin-snap-8'' | ''buzz'' | ''wag'' | ''float'' | ''swing'' | ''jello''
' do: [ :element :value | element animation: value ].
	self addBooleanProperty: #autoWidth default: false comment: 'Sets the width of the icon to match the cropped SVG viewBox. This operates like the Font `fa-width-auto` class.

Type: Boolean
Default: false
' do: [ :element :value | element autoWidth: value ].
	self addSelectionProperty: #canvas options: #('fixed' 'auto' 'square' 'roomy') default: 'fixed' comment: 'Sets the icon canvas — the box the icon is centered within. Unset renders as `fixed` (1.25em × 1em); `auto` hugs the
icon''s width; `square` is 1.25em × 1.25em; `roomy` is 1.5em × 1.5em. Mirrors Font Awesome''s `fa-fixed-width`,
`fa-width-auto`, `fa-canvas-square`, and `fa-canvas-roomy`. Scales with `font-size`.

Type: String
Allowed: ''fixed'' | ''auto'' | ''square'' | ''roomy''
' do: [ :element :value | element canvas: value ].
	self addStringProperty: #family default: nil do: [ :element :value | element family: value ].
	self addSelectionProperty: #flip options: #('x' 'y' 'both') default: 'x' comment: 'Sets the flip direction of the icon along the ''x'' (horizontal), ''y'' (vertical), or ''both'' axes.

Type: String
Allowed: ''x'' | ''y'' | ''both''
' do: [ :element :value | element flip: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addStringProperty: #library default: 'default' do: [ :element :value | element library: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addNumberProperty: #rotate default: 0 do: [ :element :value | element rotate: value ].
	self addStringProperty: #src default: nil do: [ :element :value | element src: value ].
	self addBooleanProperty: #swapOpacity default: false comment: 'Swaps the opacity of duotone icons.

Type: Boolean
Default: false
' do: [ :element :value | element swapOpacity: value ].
	self addStringProperty: #variant default: nil do: [ :element :value | element variant: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaInclude [

	self visual: WaInclude new.

	self addBooleanProperty: #allowScripts default: false comment: 'Allows included scripts to be executed. Be sure you trust the content you are including as it will be executed as
code and can result in XSS attacks.

Type: Boolean
Default: false
' do: [ :element :value | element allowScripts: value ].
	self addSelectionProperty: #mode options: #('cors' 'no-cors' 'same-origin') default: 'cors' comment: 'The fetch mode to use.

Type: String
Default: ''cors''
Allowed: ''cors'' | ''no-cors'' | ''same-origin''
' do: [ :element :value | element mode: value ].
	self addStringProperty: #src default: nil do: [ :element :value | element src: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaInput [

	self visual: WaInput new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined') default: 'outlined' comment: 'The input''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addSelectionProperty: #autocapitalize options: #('off' 'none' 'on' 'sentences' 'words' 'characters') default: 'off' comment: 'Controls whether and how text input is automatically capitalized as it is entered by the user.

Type: String
Allowed: ''off'' | ''none'' | ''on'' | ''sentences'' | ''words'' | ''characters''
' do: [ :element :value | element autocapitalize: value ].
	self addStringProperty: #autocomplete default: nil do: [ :element :value | element autocomplete: value ].
	self addBooleanProperty: #autocorrect default: false comment: 'Indicates whether the browser''s autocorrect feature is on or off. When set as an attribute, use `"off"` or `"on"`.
When set as a property, use `true` or `false`.

Type: Boolean
' do: [ :element :value | element autocorrect: value ].
	self addBooleanProperty: #autofocus default: false comment: 'Indicates that the input should receive focus on page load.

Type: Boolean
' do: [ :element :value | element autofocus: value ].
	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the form control.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #enterkeyhint options: #('enter' 'done' 'go' 'next' 'previous' 'search' 'send') default: 'enter' comment: 'Used to customize the label or icon of the Enter key on virtual keyboards.

Type: String
Allowed: ''enter'' | ''done'' | ''go'' | ''next'' | ''previous'' | ''search'' | ''send''
' do: [ :element :value | element enterkeyhint: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addSelectionProperty: #inputmode options: #('none' 'text' 'decimal' 'numeric' 'tel' 'search' 'email' 'url') default: 'none' comment: 'Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
keyboard on supportive devices.

Type: String
Allowed: ''none'' | ''text'' | ''decimal'' | ''numeric'' | ''tel'' | ''search'' | ''email'' | ''url''
' do: [ :element :value | element inputmode: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #maxlength default: nil do: [ :element :value | element maxlength: value ].
	self addNumberProperty: #minlength default: nil do: [ :element :value | element minlength: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #passwordToggle default: false comment: 'Adds a button to toggle the password''s visibility. Only applies to password types.

Type: Boolean
Default: false
' do: [ :element :value | element passwordToggle: value ].
	self addBooleanProperty: #passwordVisible default: false comment: 'Determines whether or not the password is currently visible. Only applies to password input types.

Type: Boolean
Default: false
' do: [ :element :value | element passwordVisible: value ].
	self addStringProperty: #pattern default: nil do: [ :element :value | element pattern: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style input with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addStringProperty: #placeholder default: '' do: [ :element :value | element placeholder: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the input readonly.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the input a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The input''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addBooleanProperty: #spellcheck default: true comment: 'Enables spell checking on the input.

Type: Boolean
Default: true
' do: [ :element :value | element spellcheck: value ].
	self addSelectionProperty: #type options: #('date' 'datetime-local' 'email' 'number' 'password' 'search' 'tel' 'text' 'time' 'url') default: 'text' comment: 'The type of input. Works the same as a native `<input>` element, but only a subset of types are supported. Defaults
to `text`.

Type: String
Default: ''text''
Allowed: ''date'' | ''datetime-local'' | ''email'' | ''number'' | ''password'' | ''search'' | ''tel'' | ''text'' | ''time'' | ''url''
' do: [ :element :value | element type: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withClear default: false comment: 'Adds a clear button when the input is not empty.

Type: Boolean
Default: false
' do: [ :element :value | element withClear: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addBooleanProperty: #withoutSpinButtons default: false comment: 'Hides the browser''s built-in increment/decrement spin buttons for number inputs.

Type: Boolean
Default: false
' do: [ :element :value | element withoutSpinButtons: value ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #stepUp do: [ :element | element perform: #stepUp ].
	self addMethod: #stepDown do: [ :element | element perform: #stepDown ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #showPicker do: [ :element | element perform: #showPicker ].
	self addMethod: #select do: [ :element | element perform: #select ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaIntersectionObserver [

	self visual: WaIntersectionObserver new.

	self addBooleanProperty: #disabled default: false comment: 'Deactivates the intersection observer functionality.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #intersectClass default: '' do: [ :element :value | element intersectClass: value ].
	self addBooleanProperty: #once default: false comment: 'If enabled, observation ceases after initial intersection.

Type: Boolean
Default: false
' do: [ :element :value | element once: value ].
	self addStringProperty: #root default: nil do: [ :element :value | element root: value ].
	self addStringProperty: #rootMargin default: '0px' do: [ :element :value | element rootMargin: value ].
	self addStringProperty: #threshold default: '0' do: [ :element :value | element threshold: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaKnownDate [

	self visual: WaKnownDate new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined') default: 'outlined' comment: 'The known date''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addStringProperty: #autocomplete default: '' do: [ :element :value | element autocomplete: value ].
	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the known date.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addStringProperty: #locale default: '' do: [ :element :value | element locale: value ].
	self addStringProperty: #max default: '' do: [ :element :value | element max: value ].
	self addStringProperty: #min default: '' do: [ :element :value | element min: value ].
	self addStringProperty: #name default: '' do: [ :element :value | element name: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws pill-style fields with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the fields non-editable.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the known date required for form submission.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('s' 'xs' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The known date''s size.

Type: String
Default: ''m''
Allowed: ''s'' | ''xs'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaMarkdown [

	self visual: WaMarkdown new.

	self addNumberProperty: #tabSize default: 4 do: [ :element :value | element tabSize: value ].
	self addMethod: #getMarked do: [ :element | element perform: #getMarked ].
	self addMethod: #renderMarkdown do: [ :element | element perform: #renderMarkdown ].
	self addMethod: #updateAll do: [ :element | element perform: #updateAll ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaMutationObserver [

	self visual: WaMutationObserver new.

	self addStringProperty: #attr default: nil do: [ :element :value | element attr: value ].
	self addBooleanProperty: #attrOldValue default: false comment: 'Indicates whether or not the attribute''s previous value should be recorded when monitoring changes.

Type: Boolean
Default: false
' do: [ :element :value | element attrOldValue: value ].
	self addBooleanProperty: #charData default: false comment: 'Watches for changes to the character data contained within the node.

Type: Boolean
Default: false
' do: [ :element :value | element charData: value ].
	self addBooleanProperty: #charDataOldValue default: false comment: 'Indicates whether or not the previous value of the node''s text should be recorded.

Type: Boolean
Default: false
' do: [ :element :value | element charDataOldValue: value ].
	self addBooleanProperty: #childList default: false comment: 'Watches for the addition or removal of new child nodes.

Type: Boolean
Default: false
' do: [ :element :value | element childList: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the observer.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaNumberInput [

	self visual: WaNumberInput new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined') default: 'outlined' comment: 'The input''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addStringProperty: #autocomplete default: nil do: [ :element :value | element autocomplete: value ].
	self addBooleanProperty: #autofocus default: false comment: 'Indicates that the input should receive focus on page load.

Type: Boolean
' do: [ :element :value | element autofocus: value ].
	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the form control.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #enterkeyhint options: #('enter' 'done' 'go' 'next' 'previous' 'search' 'send') default: 'enter' comment: 'Used to customize the label or icon of the Enter key on virtual keyboards.

Type: String
Allowed: ''enter'' | ''done'' | ''go'' | ''next'' | ''previous'' | ''search'' | ''send''
' do: [ :element :value | element enterkeyhint: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addSelectionProperty: #inputmode options: #('numeric' 'decimal') default: 'numeric' comment: 'Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
keyboard on supportive devices.

Type: String
Default: ''numeric''
Allowed: ''numeric'' | ''decimal''
' do: [ :element :value | element inputmode: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #max default: nil do: [ :element :value | element max: value ].
	self addNumberProperty: #min default: nil do: [ :element :value | element min: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style input with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addStringProperty: #placeholder default: '' do: [ :element :value | element placeholder: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the input readonly.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the input a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The input''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addBooleanProperty: #withoutSteppers default: false comment: 'Hides the increment/decrement stepper buttons.

Type: Boolean
Default: false
' do: [ :element :value | element withoutSteppers: value ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #stepUp do: [ :element | element perform: #stepUp ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #stepDown do: [ :element | element perform: #stepDown ].
	self addMethod: #select do: [ :element | element perform: #select ].
	self addMethod: #focus do: [ :element | element perform: #focus ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaOption [

	self visual: WaOption new.

	self addBooleanProperty: #defaultSelected default: false comment: 'Selects an option initially.

Type: Boolean
Default: false
' do: [ :element :value | element defaultSelected: value ].
	self addBooleanProperty: #disabled default: false comment: 'Draws the option in a disabled state, preventing selection.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #label default: nil do: [ :element :value | element label: value ].
	self addStringProperty: #value default: '' do: [ :element :value | element value: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaOtpInput [

	self visual: WaOtpInput new.

	self addSelectionProperty: #appearance options: #('outlined' 'filled' 'filled-outlined' 'contained') default: 'outlined' comment: 'Visual appearance of the segments.

Type: String
Default: ''outlined''
Allowed: ''outlined'' | ''filled'' | ''filled-outlined'' | ''contained''
' do: [ :element :value | element appearance: value ].
	self addStringProperty: #autocomplete default: 'one-time-code' do: [ :element :value | element autocomplete: value ].
	self addBooleanProperty: #autofocus default: false comment: 'Automatically focuses the field when the page loads.

Type: Boolean
Default: false
' do: [ :element :value | element autofocus: value ].
	self addBooleanProperty: #autosubmit default: false comment: 'When true, the form is submitted automatically once all segments are filled.

Type: Boolean
Default: false
' do: [ :element :value | element autosubmit: value ].
	self addSelectionProperty: #case options: #('preserve' 'upper' 'lower') default: 'preserve' comment: 'Case transformation applied to entered characters.

Type: String
Default: ''preserve''
Allowed: ''preserve'' | ''upper'' | ''lower''
' do: [ :element :value | element case: value ].
	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the form control.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #format default: '' do: [ :element :value | element format: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #length default: 6 do: [ :element :value | element length: value ].
	self addBooleanProperty: #mask default: false comment: 'When true, entered characters are displayed as `--mask-char` instead of their real value.

Type: Boolean
Default: false
' do: [ :element :value | element mask: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the field readonly — the value displays but cannot be edited by the user.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the field required. A partially-filled field is always invalid regardless of this attribute.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The size of each segment.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addSelectionProperty: #type options: #('numeric' 'alpha' 'alphanumeric') default: 'numeric' comment: 'Allowed character class.

Type: String
Default: ''numeric''
Allowed: ''numeric'' | ''alpha'' | ''alphanumeric''
' do: [ :element :value | element type: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withMask default: false comment: 'When true, empty segments show `--mask-char` as a hint instead of appearing blank, similar to
how a password field communicates its expected length before anything is typed.

Type: Boolean
Default: false
' do: [ :element :value | element withMask: value ].
	self addMethod: #clear do: [ :element | element perform: #clear ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #select do: [ :element | element perform: #select ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaPage [

	self visual: WaPage new.

	self addBooleanProperty: #disableNavigationToggle default: false comment: 'Determines whether or not to hide the default hamburger button.
This will automatically flip to "true" if you add an element with `data-toggle-nav` anywhere in the element light DOM.
Generally this will be set for you and you don''t need to do anything, unless you''re using SSR, in which case you should set this manually for initial page loads.

Type: Boolean
Default: false
' do: [ :element :value | element disableNavigationToggle: value ].
	self addStringProperty: #mobileBreakpoint default: '768px' do: [ :element :value | element mobileBreakpoint: value ].
	self addBooleanProperty: #navOpen default: false comment: 'Whether or not the navigation drawer is open. Note, the navigation drawer is only "open" on mobile views.

Type: Boolean
Default: false
' do: [ :element :value | element navOpen: value ].
	self addSelectionProperty: #navigationPlacement options: #('start' 'end') default: 'start' comment: 'Where to place the navigation when in the mobile viewport.

Type: String
Default: ''start''
Allowed: ''start'' | ''end''
' do: [ :element :value | element navigationPlacement: value ].
	self addSelectionProperty: #view options: #('mobile' 'desktop') default: 'desktop' comment: 'The view is a reflection of the "mobileBreakpoint", when the page is larger than the `mobile-breakpoint` (768px by
default), it is considered to be a "desktop" view. The view is merely a way to distinguish when to show/hide the
navigation. You can use additional media queries to make other adjustments to content as necessary.
The default is "desktop" because the "mobile navigation drawer" isn''t accessible via SSR due to drawer requiring JS.

Type: String
Default: ''desktop''
Allowed: ''mobile'' | ''desktop''
' do: [ :element :value | element view: value ].
	self addMethod: #showNavigation do: [ :element | element perform: #showNavigation ].
	self addMethod: #hideNavigation do: [ :element | element perform: #hideNavigation ].
	self addMethod: #toggleNavigation do: [ :element | element perform: #toggleNavigation ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaPagination [

	self visual: WaPagination new.

	self addSelectionProperty: #appearance options: #('outlined' 'filled' 'plain') default: 'outlined' comment: 'The pagination''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''outlined'' | ''filled'' | ''plain''
' do: [ :element :value | element appearance: value ].
	self addNumberProperty: #boundaryCount default: 1 do: [ :element :value | element boundaryCount: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the pagination.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #format options: #('standard' 'compact') default: 'standard' comment: 'The pagination''s layout. The default `standard` format shows the full page list with ellipses; `compact` collapses
it into a short "1 of 5" label flanked by the previous and next buttons, useful in tight spaces like toolbars and
cards.

Type: String
Default: ''standard''
Allowed: ''standard'' | ''compact''
' do: [ :element :value | element format: value ].
	self addBooleanProperty: #hideSinglePage default: false comment: 'Renders nothing when there''s only one page.

Type: Boolean
Default: false
' do: [ :element :value | element hideSinglePage: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #page default: 1 do: [ :element :value | element page: value ].
	self addNumberProperty: #pageSize default: 10 do: [ :element :value | element pageSize: value ].
	self addNumberProperty: #siblingCount default: 2 do: [ :element :value | element siblingCount: value ].
	self addNumberProperty: #total default: 0 do: [ :element :value | element total: value ].
	self addBooleanProperty: #withEdges default: false comment: 'Shows buttons that jump to the first and last pages.

Type: Boolean
Default: false
' do: [ :element :value | element withEdges: value ].
	self addBooleanProperty: #withSummary default: false comment: 'Shows a summary of the items on the current page, e.g. "1–10 of 237".

Type: Boolean
Default: false
' do: [ :element :value | element withSummary: value ].
	self addBooleanProperty: #withoutNav default: false comment: 'Hides the previous and next buttons.

Type: Boolean
Default: false
' do: [ :element :value | element withoutNav: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaPopover [

	self visual: WaPopover new.

	self addNumberProperty: #distance default: 8 do: [ :element :value | element distance: value ].
	self addStringProperty: #for default: nil do: [ :element :value | element for: value ].
	self addBooleanProperty: #open default: false comment: 'Shows or hides the popover.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addSelectionProperty: #placement options: #('top' 'top-start' 'top-end' 'right' 'right-start' 'right-end' 'bottom' 'bottom-start' 'bottom-end' 'left' 'left-start' 'left-end') default: 'top' comment: 'The preferred placement of the popover. Note that the actual placement may vary as needed to keep the popover
inside of the viewport.

Type: String
Default: ''top''
Allowed: ''top'' | ''top-start'' | ''top-end'' | ''right'' | ''right-start'' | ''right-end'' | ''bottom'' | ''bottom-start'' | ''bottom-end'' | ''left'' | ''left-start'' | ''left-end''
' do: [ :element :value | element placement: value ].
	self addNumberProperty: #skidding default: 0 do: [ :element :value | element skidding: value ].
	self addBooleanProperty: #withoutArrow default: false comment: 'Removes the arrow from the popover.

Type: Boolean
Default: false
' do: [ :element :value | element withoutArrow: value ].
	self addMethod: #hide do: [ :element | element perform: #hide ].
	self addMethod: #show do: [ :element | element perform: #show ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaPopup [

	self visual: WaPopup new.

	self addBooleanProperty: #active default: false comment: 'Activates the positioning logic and shows the popup. When this attribute is removed, the positioning logic is torn
down and the popup will be hidden.

Type: Boolean
Default: false
' do: [ :element :value | element active: value ].
	self addBooleanProperty: #arrow default: false comment: 'Attaches an arrow to the popup. The arrow''s size and color can be customized using the `--arrow-size` and
`--arrow-color` custom properties. For additional customizations, you can also target the arrow using
`::part(arrow)` in your stylesheet.

Type: Boolean
Default: false
' do: [ :element :value | element arrow: value ].
	self addNumberProperty: #arrowPadding default: 10 do: [ :element :value | element arrowPadding: value ].
	self addSelectionProperty: #arrowPlacement options: #('start' 'end' 'center' 'anchor') default: 'anchor' comment: 'The placement of the arrow. The default is `anchor`, which will align the arrow as close to the center of the
anchor as possible, considering available space and `arrow-padding`. A value of `start`, `end`, or `center` will
align the arrow to the start, end, or center of the popover instead.

Type: String
Default: ''anchor''
Allowed: ''start'' | ''end'' | ''center'' | ''anchor''
' do: [ :element :value | element arrowPlacement: value ].
	self addSelectionProperty: #autoSize options: #('horizontal' 'vertical' 'both') default: 'horizontal' comment: 'When set, this will cause the popup to automatically resize itself to prevent it from overflowing.

Type: String
Allowed: ''horizontal'' | ''vertical'' | ''both''
' do: [ :element :value | element autoSize: value ].
	self addNumberProperty: #autoSizePadding default: 0 do: [ :element :value | element autoSizePadding: value ].
	self addSelectionProperty: #boundary options: #('viewport' 'scroll') default: 'viewport' comment: 'The bounding box to use for flipping, shifting, and auto-sizing.

Type: String
Default: ''viewport''
Allowed: ''viewport'' | ''scroll''
' do: [ :element :value | element boundary: value ].
	self addNumberProperty: #distance default: 0 do: [ :element :value | element distance: value ].
	self addBooleanProperty: #flip default: false comment: 'When set, placement of the popup will flip to the opposite site to keep it in view. You can use
`flipFallbackPlacements` to further configure how the fallback placement is determined.

Type: Boolean
Default: false
' do: [ :element :value | element flip: value ].
	self addStringProperty: #flipFallbackPlacements default: '' do: [ :element :value | element flipFallbackPlacements: value ].
	self addSelectionProperty: #flipFallbackStrategy options: #('best-fit' 'initial') default: 'best-fit' comment: 'When neither the preferred placement nor the fallback placements fit, this value will be used to determine whether
the popup should be positioned using the best available fit based on available space or as it was initially
preferred.

Type: String
Default: ''best-fit''
Allowed: ''best-fit'' | ''initial''
' do: [ :element :value | element flipFallbackStrategy: value ].
	self addNumberProperty: #flipPadding default: 0 do: [ :element :value | element flipPadding: value ].
	self addBooleanProperty: #hoverBridge default: false comment: 'When a gap exists between the anchor and the popup element, this option will add a "hover bridge" that fills the
gap using an invisible element. This makes listening for events such as `mouseenter` and `mouseleave` more sane
because the pointer never technically leaves the element. The hover bridge will only be drawn when the popover is
active.

Type: Boolean
Default: false
' do: [ :element :value | element hoverBridge: value ].
	self addSelectionProperty: #placement options: #('top' 'top-start' 'top-end' 'bottom' 'bottom-start' 'bottom-end' 'right' 'right-start' 'right-end' 'left' 'left-start' 'left-end') default: 'top' comment: 'The preferred placement of the popup. Note that the actual placement will vary as configured to keep the
panel inside of the viewport.

Type: String
Default: ''top''
Allowed: ''top'' | ''top-start'' | ''top-end'' | ''bottom'' | ''bottom-start'' | ''bottom-end'' | ''right'' | ''right-start'' | ''right-end'' | ''left'' | ''left-start'' | ''left-end''
' do: [ :element :value | element placement: value ].
	self addBooleanProperty: #shift default: false comment: 'Moves the popup along the axis to keep it in view when clipped.

Type: Boolean
Default: false
' do: [ :element :value | element shift: value ].
	self addNumberProperty: #shiftPadding default: 0 do: [ :element :value | element shiftPadding: value ].
	self addNumberProperty: #skidding default: 0 do: [ :element :value | element skidding: value ].
	self addSelectionProperty: #sync options: #('width' 'height' 'both') default: 'width' comment: 'Syncs the popup''s width or height to that of the anchor element.

Type: String
Allowed: ''width'' | ''height'' | ''both''
' do: [ :element :value | element sync: value ].
	self addMethod: #reposition do: [ :element | element perform: #reposition ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaProgressBar [

	self visual: WaProgressBar new.

	self addBooleanProperty: #indeterminate default: false comment: 'When true, percentage is ignored, the label is hidden, and the progress bar is drawn in an indeterminate state.

Type: Boolean
Default: false
' do: [ :element :value | element indeterminate: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #value default: 0 do: [ :element :value | element value: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaProgressRing [

	self visual: WaProgressRing new.

	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #value default: 0 do: [ :element :value | element value: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaQrCode [

	self visual: WaQrCode new.

	self addStringProperty: #background default: '' do: [ :element :value | element background: value ].
	self addSelectionProperty: #errorCorrection options: #('L' 'M' 'Q' 'H') default: 'H' comment: 'The level of error correction to use. [Learn more](https://www.qrcode.com/en/about/error_correction.html)

Type: String
Default: ''H''
Allowed: ''L'' | ''M'' | ''Q'' | ''H''
' do: [ :element :value | element errorCorrection: value ].
	self addStringProperty: #fill default: '' do: [ :element :value | element fill: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #radius default: 0 do: [ :element :value | element radius: value ].
	self addNumberProperty: #size default: 128 do: [ :element :value | element size: value ].
	self addStringProperty: #value default: '' do: [ :element :value | element value: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaRadio [

	self visual: WaRadio new.

	self addSelectionProperty: #appearance options: #('default' 'button') default: 'default' comment: 'The radio''s visual appearance.

Type: String
Default: ''default''
Allowed: ''default'' | ''button''
' do: [ :element :value | element appearance: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the radio.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'xs' comment: 'The radio''s size. When used inside a radio group, the size will be determined by the radio group''s size, which will
override this attribute.

Type: String
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaRadioGroup [

	self visual: WaRadioGroup new.

	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the radio group and all child radios.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'vertical' comment: 'The orientation in which to show radio items.

Type: String
Default: ''vertical''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addBooleanProperty: #required default: false comment: 'Ensures a child radio is checked before allowing the containing form to submit.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'xs' comment: 'The radio group''s size. When present, this size will be applied to all `<wa-radio>` items inside.

Type: String
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaRandomContent [

	self visual: WaRandomContent new.

	self addSelectionProperty: #animation options: #('none' 'fade' 'fade-up' 'fade-down' 'fade-left' 'fade-right') default: 'none' comment: 'Entrance animation for newly shown children.

Type: String
Default: ''none''
Allowed: ''none'' | ''fade'' | ''fade-up'' | ''fade-down'' | ''fade-left'' | ''fade-right''
' do: [ :element :value | element animation: value ].
	self addBooleanProperty: #autoplay default: false comment: 'Rotate the content automatically. Set the cadence with `autoplay-interval`.

Type: Boolean
Default: false
' do: [ :element :value | element autoplay: value ].
	self addNumberProperty: #autoplayInterval default: 3000 do: [ :element :value | element autoplayInterval: value ].
	self addNumberProperty: #items default: 1 do: [ :element :value | element items: value ].
	self addSelectionProperty: #mode options: #('random' 'unique' 'sequence') default: 'unique' comment: 'Selection strategy: `unique` (default), `random`, or `sequence`.

Type: String
Default: ''unique''
Allowed: ''random'' | ''unique'' | ''sequence''
' do: [ :element :value | element mode: value ].
	self addMethod: #randomize do: [ :element | element perform: #randomize ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaRating [

	self visual: WaRating new.

	self addNumberProperty: #defaultValue default: 0 do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the rating.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #max default: 5 do: [ :element :value | element max: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addNumberProperty: #precision default: 1 do: [ :element :value | element precision: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the rating readonly.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the rating a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The component''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addNumberProperty: #value default: 0 do: [ :element :value | element value: value ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaRelativeTime [

	self visual: WaRelativeTime new.

	self addSelectionProperty: #format options: #('long' 'short' 'narrow') default: 'long' comment: 'The formatting style to use.

Type: String
Default: ''long''
Allowed: ''long'' | ''short'' | ''narrow''
' do: [ :element :value | element format: value ].
	self addSelectionProperty: #numeric options: #('always' 'auto') default: 'auto' comment: 'When `auto`, values such as "yesterday" and "tomorrow" will be shown when possible. When `always`, values such as
"1 day ago" and "in 1 day" will be shown.

Type: String
Default: ''auto''
Allowed: ''always'' | ''auto''
' do: [ :element :value | element numeric: value ].
	self addBooleanProperty: #sync default: false comment: 'Keep the displayed value up to date as time passes.

Type: Boolean
Default: false
' do: [ :element :value | element sync: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaResizeObserver [

	self visual: WaResizeObserver new.

	self addBooleanProperty: #disabled default: false comment: 'Disables the observer.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaScroller [

	self visual: WaScroller new.

	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'horizontal' comment: 'The scroller''s orientation.

Type: String
Default: ''horizontal''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addBooleanProperty: #withoutScrollbar default: false comment: 'Removes the visible scrollbar.

Type: Boolean
Default: false
' do: [ :element :value | element withoutScrollbar: value ].
	self addBooleanProperty: #withoutShadow default: false comment: 'Removes the shadows.

Type: Boolean
Default: false
' do: [ :element :value | element withoutShadow: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaSelect [

	self visual: WaSelect new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined') default: 'outlined' comment: 'The select''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the select control.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #maxOptionsVisible default: 3 do: [ :element :value | element maxOptionsVisible: value ].
	self addBooleanProperty: #multiple default: false comment: 'Allows more than one option to be selected.

Type: Boolean
Default: false
' do: [ :element :value | element multiple: value ].
	self addStringProperty: #name default: '' do: [ :element :value | element name: value ].
	self addBooleanProperty: #open default: false comment: 'Indicates whether or not the select is open. You can toggle this attribute to show and hide the menu, or you can
use the `show()` and `hide()` methods and this attribute will reflect the select''s open state.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style select with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addStringProperty: #placeholder default: '' do: [ :element :value | element placeholder: value ].
	self addSelectionProperty: #placement options: #('top' 'bottom') default: 'bottom' comment: 'The preferred placement of the select''s menu. Note that the actual placement may vary as needed to keep the listbox
inside of the viewport.

Type: String
Default: ''bottom''
Allowed: ''top'' | ''bottom''
' do: [ :element :value | element placement: value ].
	self addBooleanProperty: #required default: false comment: 'The select''s required attribute.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The select''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withClear default: false comment: 'Adds a clear button when the select is not empty.

Type: Boolean
Default: false
' do: [ :element :value | element withClear: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #show do: [ :element | element perform: #show ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #hide do: [ :element | element perform: #hide ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaSkeleton [

	self visual: WaSkeleton new.

	self addSelectionProperty: #effect options: #('pulse' 'sheen' 'none') default: 'none' comment: 'Determines which effect the skeleton will use.

Type: String
Default: ''none''
Allowed: ''pulse'' | ''sheen'' | ''none''
' do: [ :element :value | element effect: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaSlider [

	self visual: WaSlider new.

	self addBooleanProperty: #autofocus default: false comment: 'Tells the browser to focus the slider when the page loads or a dialog is shown.

Type: Boolean
' do: [ :element :value | element autofocus: value ].
	self addNumberProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the slider.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addNumberProperty: #indicatorOffset default: nil do: [ :element :value | element indicatorOffset: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #max default: 100 do: [ :element :value | element max: value ].
	self addNumberProperty: #maxValue default: 50 do: [ :element :value | element maxValue: value ].
	self addNumberProperty: #min default: 0 do: [ :element :value | element min: value ].
	self addNumberProperty: #minValue default: 0 do: [ :element :value | element minValue: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'horizontal' comment: 'The orientation of the slider.

Type: String
Default: ''horizontal''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addBooleanProperty: #range default: false comment: 'Converts the slider to a range slider with two thumbs.

Type: Boolean
Default: false
' do: [ :element :value | element range: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the slider a read-only field.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The slider''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addNumberProperty: #step default: 1 do: [ :element :value | element step: value ].
	self addNumberProperty: #tooltipDistance default: 8 do: [ :element :value | element tooltipDistance: value ].
	self addSelectionProperty: #tooltipPlacement options: #('top' 'right' 'bottom' 'left') default: 'top' comment: 'The placement of the tooltip in reference to the slider''s thumb.

Type: String
Default: ''top''
Allowed: ''top'' | ''right'' | ''bottom'' | ''left''
' do: [ :element :value | element tooltipPlacement: value ].
	self addNumberProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addBooleanProperty: #withMarkers default: false comment: 'Draws markers at each step along the slider.

Type: Boolean
Default: false
' do: [ :element :value | element withMarkers: value ].
	self addBooleanProperty: #withTooltip default: false comment: 'Draws a tooltip above the thumb when the control has focus or is dragged.

Type: Boolean
Default: false
' do: [ :element :value | element withTooltip: value ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #stepDown do: [ :element | element perform: #stepDown ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #stepUp do: [ :element | element perform: #stepUp ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaSpinner [

	self visual: WaSpinner new.


]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaSplitPanel [

	self visual: WaSplitPanel new.

	self addBooleanProperty: #disabled default: false comment: 'Disables resizing. Note that the position may still change as a result of resizing the host element.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #orientation options: #('horizontal' 'vertical') default: 'horizontal' comment: 'Sets the split panel''s orientation.

Type: String
Default: ''horizontal''
Allowed: ''horizontal'' | ''vertical''
' do: [ :element :value | element orientation: value ].
	self addNumberProperty: #position default: 50 do: [ :element :value | element position: value ].
	self addNumberProperty: #positionInPixels default: nil do: [ :element :value | element positionInPixels: value ].
	self addSelectionProperty: #primary options: #('start' 'end') default: 'start' comment: 'If no primary panel is designated, both panels will resize proportionally when the host element is resized. If a
primary panel is designated, it will maintain its size and the other panel will grow or shrink as needed when the
host element is resized.

Type: String
Allowed: ''start'' | ''end''
' do: [ :element :value | element primary: value ].
	self addStringProperty: #snap default: nil do: [ :element :value | element snap: value ].
	self addNumberProperty: #snapThreshold default: 12 do: [ :element :value | element snapThreshold: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaSwitch [

	self visual: WaSwitch new.

	self addBooleanProperty: #checked default: false comment: 'The default value of the form control. Primarily used for resetting the form control.

Type: Boolean
' do: [ :element :value | element checked: value ].
	self addBooleanProperty: #defaultChecked default: false comment: 'The default value of the form control. Primarily used for resetting the form control.

Type: Boolean
' do: [ :element :value | element defaultChecked: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the switch.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the switch a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The switch''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #click do: [ :element | element perform: #click ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTab [

	self visual: WaTab new.

	self addBooleanProperty: #disabled default: false comment: 'Disables the tab and prevents selection.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addStringProperty: #panel default: '' do: [ :element :value | element panel: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTabGroup [

	self visual: WaTabGroup new.

	self addSelectionProperty: #activation options: #('auto' 'manual') default: 'auto' comment: 'When set to auto, navigating tabs with the arrow keys will instantly show the corresponding tab panel. When set to
manual, the tab will receive focus but will not show until the user presses spacebar or enter.

Type: String
Default: ''auto''
Allowed: ''auto'' | ''manual''
' do: [ :element :value | element activation: value ].
	self addStringProperty: #active default: '' do: [ :element :value | element active: value ].
	self addSelectionProperty: #placement options: #('top' 'bottom' 'start' 'end') default: 'top' comment: 'The placement of the tabs.

Type: String
Default: ''top''
Allowed: ''top'' | ''bottom'' | ''start'' | ''end''
' do: [ :element :value | element placement: value ].
	self addBooleanProperty: #withoutScrollControls default: false comment: 'Disables the scroll arrows that appear when tabs overflow.

Type: Boolean
Default: false
' do: [ :element :value | element withoutScrollControls: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTabPanel [

	self visual: WaTabPanel new.

	self addBooleanProperty: #active default: false comment: 'When true, the tab panel will be shown.

Type: Boolean
Default: false
' do: [ :element :value | element active: value ].
	self addStringProperty: #name default: '' do: [ :element :value | element name: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTag [

	self visual: WaTag new.

	self addSelectionProperty: #appearance options: #('accent' 'filled' 'outlined' 'filled-outlined') default: 'filled-outlined' comment: 'The tag''s visual appearance.

Type: String
Default: ''filled-outlined''
Allowed: ''accent'' | ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style tag with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The tag''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addSelectionProperty: #variant options: #('brand' 'neutral' 'success' 'warning' 'danger') default: 'neutral' comment: 'The tag''s theme variant. Defaults to `neutral` if not within another element with a variant.

Type: String
Default: ''neutral''
Allowed: ''brand'' | ''neutral'' | ''success'' | ''warning'' | ''danger''
' do: [ :element :value | element variant: value ].
	self addBooleanProperty: #withRemove default: false comment: 'Makes the tag removable and shows a remove button.

Type: Boolean
Default: false
' do: [ :element :value | element withRemove: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTextarea [

	self visual: WaTextarea new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined') default: 'outlined' comment: 'The textarea''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addSelectionProperty: #autocapitalize options: #('off' 'none' 'on' 'sentences' 'words' 'characters') default: 'off' comment: 'Controls whether and how text input is automatically capitalized as it is entered by the user.

Type: String
Allowed: ''off'' | ''none'' | ''on'' | ''sentences'' | ''words'' | ''characters''
' do: [ :element :value | element autocapitalize: value ].
	self addStringProperty: #autocomplete default: nil do: [ :element :value | element autocomplete: value ].
	self addBooleanProperty: #autocorrect default: false comment: 'Indicates whether the browser''s autocorrect feature is on or off. When set as an attribute, use `"off"` or `"on"`.
When set as a property, use `true` or `false`.

Type: Boolean
' do: [ :element :value | element autocorrect: value ].
	self addBooleanProperty: #autofocus default: false comment: 'Indicates that the input should receive focus on page load.

Type: Boolean
' do: [ :element :value | element autofocus: value ].
	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the textarea.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addSelectionProperty: #enterkeyhint options: #('enter' 'done' 'go' 'next' 'previous' 'search' 'send') default: 'enter' comment: 'Used to customize the label or icon of the Enter key on virtual keyboards.

Type: String
Allowed: ''enter'' | ''done'' | ''go'' | ''next'' | ''previous'' | ''search'' | ''send''
' do: [ :element :value | element enterkeyhint: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addSelectionProperty: #inputmode options: #('none' 'text' 'decimal' 'numeric' 'tel' 'search' 'email' 'url') default: 'none' comment: 'Tells the browser what type of data will be entered by the user, allowing it to display the appropriate virtual
keyboard on supportive devices.

Type: String
Allowed: ''none'' | ''text'' | ''decimal'' | ''numeric'' | ''tel'' | ''search'' | ''email'' | ''url''
' do: [ :element :value | element inputmode: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addNumberProperty: #maxlength default: nil do: [ :element :value | element maxlength: value ].
	self addNumberProperty: #minlength default: nil do: [ :element :value | element minlength: value ].
	self addStringProperty: #name default: nil do: [ :element :value | element name: value ].
	self addStringProperty: #placeholder default: '' do: [ :element :value | element placeholder: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the textarea readonly.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the textarea a required field.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #resize options: #('none' 'vertical' 'horizontal' 'both' 'auto') default: 'vertical' comment: 'Controls how the textarea can be resized.

Type: String
Default: ''vertical''
Allowed: ''none'' | ''vertical'' | ''horizontal'' | ''both'' | ''auto''
' do: [ :element :value | element resize: value ].
	self addNumberProperty: #rows default: 4 do: [ :element :value | element rows: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The textarea''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addBooleanProperty: #spellcheck default: true comment: 'Enables spell checking on the textarea.

Type: Boolean
Default: true
' do: [ :element :value | element spellcheck: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withCount default: false comment: 'Shows a character count below the textarea. When `maxlength` is set, shows remaining characters instead.

Type: Boolean
Default: false
' do: [ :element :value | element withCount: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element so the server-rendered markup
includes the hint before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element so the server-rendered markup
includes the label before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #scrollPosition do: [ :element | element perform: #scrollPosition ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].
	self addMethod: #select do: [ :element | element perform: #select ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTimeInput [

	self visual: WaTimeInput new.

	self addSelectionProperty: #appearance options: #('filled' 'outlined' 'filled-outlined') default: 'outlined' comment: 'The time picker''s visual appearance.

Type: String
Default: ''outlined''
Allowed: ''filled'' | ''outlined'' | ''filled-outlined''
' do: [ :element :value | element appearance: value ].
	self addStringProperty: #autocomplete default: '' do: [ :element :value | element autocomplete: value ].
	self addStringProperty: #defaultValue default: nil do: [ :element :value | element defaultValue: value ].
	self addBooleanProperty: #disabled default: false comment: 'Disables the time picker.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addNumberProperty: #distance default: 0 do: [ :element :value | element distance: value ].
	self addStringProperty: #hint default: '' do: [ :element :value | element hint: value ].
	self addSelectionProperty: #hourFormat options: #('auto' '12' '24') default: 'auto' comment: 'Whether the UI uses a 12-hour or 24-hour clock. `auto` follows the resolved locale.

Type: String
Default: ''auto''
Allowed: ''auto'' | ''12'' | ''24''
' do: [ :element :value | element hourFormat: value ].
	self addStringProperty: #label default: '' do: [ :element :value | element label: value ].
	self addStringProperty: #max default: '' do: [ :element :value | element max: value ].
	self addStringProperty: #min default: '' do: [ :element :value | element min: value ].
	self addStringProperty: #name default: '' do: [ :element :value | element name: value ].
	self addBooleanProperty: #open default: false comment: 'Whether the popup is open.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addBooleanProperty: #pill default: false comment: 'Draws a pill-style time picker with rounded edges.

Type: Boolean
Default: false
' do: [ :element :value | element pill: value ].
	self addSelectionProperty: #placement options: #('top' 'top-start' 'top-end' 'bottom' 'bottom-start' 'bottom-end') default: 'bottom-start' comment: 'Preferred popup placement.

Type: String
Default: ''bottom-start''
Allowed: ''top'' | ''top-start'' | ''top-end'' | ''bottom'' | ''bottom-start'' | ''bottom-end''
' do: [ :element :value | element placement: value ].
	self addBooleanProperty: #readonly default: false comment: 'Makes the input non-editable. The popup still opens for browsing.

Type: Boolean
Default: false
' do: [ :element :value | element readonly: value ].
	self addBooleanProperty: #required default: false comment: 'Makes the time picker required for form submission.

Type: Boolean
Default: false
' do: [ :element :value | element required: value ].
	self addSelectionProperty: #size options: #('s' 'xs' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The time picker''s size.

Type: String
Default: ''m''
Allowed: ''s'' | ''xs'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addStringProperty: #value default: nil do: [ :element :value | element value: value ].
	self addBooleanProperty: #withClear default: false comment: 'Shows a clear button when the time picker has a value.

Type: Boolean
Default: false
' do: [ :element :value | element withClear: value ].
	self addBooleanProperty: #withHint default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `hint` element.

Type: Boolean
Default: false
' do: [ :element :value | element withHint: value ].
	self addBooleanProperty: #withLabel default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in a `label` element.

Type: Boolean
Default: false
' do: [ :element :value | element withLabel: value ].
	self addBooleanProperty: #withNow default: false comment: 'Renders a "Now" button in the popup footer.

Type: Boolean
Default: false
' do: [ :element :value | element withNow: value ].
	self addMethod: #focus do: [ :element | element perform: #focus ].
	self addMethod: #show do: [ :element | element perform: #show ].
	self addMethod: #blur do: [ :element | element perform: #blur ].
	self addMethod: #hide do: [ :element | element perform: #hide ].
	self addMethod: #resetValidity do: [ :element | element perform: #resetValidity ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaToast [

	self visual: WaToast new.

	self addSelectionProperty: #placement options: #('top-start' 'top-center' 'top-end' 'bottom-start' 'bottom-center' 'bottom-end') default: 'top-end' comment: 'The placement of the toast stack on the screen.

Type: String
Default: ''top-end''
Allowed: ''top-start'' | ''top-center'' | ''top-end'' | ''bottom-start'' | ''bottom-center'' | ''bottom-end''
' do: [ :element :value | element placement: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaToastItem [

	self visual: WaToastItem new.

	self addNumberProperty: #duration default: 5000 do: [ :element :value | element duration: value ].
	self addSelectionProperty: #size options: #('xs' 's' 'm' 'l' 'xl' 'small' 'medium' 'large') default: 'm' comment: 'The toast item''s size.

Type: String
Default: ''m''
Allowed: ''xs'' | ''s'' | ''m'' | ''l'' | ''xl'' | ''small'' | ''medium'' | ''large''
' do: [ :element :value | element size: value ].
	self addSelectionProperty: #variant options: #('brand' 'success' 'warning' 'danger' 'neutral') default: 'neutral' comment: 'The toast item''s variant.

Type: String
Default: ''neutral''
Allowed: ''brand'' | ''success'' | ''warning'' | ''danger'' | ''neutral''
' do: [ :element :value | element variant: value ].
	self addBooleanProperty: #withIcon default: false comment: 'Only required for SSR. Set to `true` if you''re slotting in an `icon` element so the server-rendered markup
includes the icon before the component hydrates on the client.

Type: Boolean
Default: false
' do: [ :element :value | element withIcon: value ].
	self addMethod: #hide do: [ :element | element perform: #hide ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTooltip [

	self visual: WaTooltip new.

	self addBooleanProperty: #disabled default: false comment: 'Disables the tooltip so it won''t show when triggered.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addNumberProperty: #distance default: 8 do: [ :element :value | element distance: value ].
	self addNumberProperty: #hideDelay default: 0 do: [ :element :value | element hideDelay: value ].
	self addBooleanProperty: #open default: false comment: 'Indicates whether or not the tooltip is open. You can use this in lieu of the show/hide methods.

Type: Boolean
Default: false
' do: [ :element :value | element open: value ].
	self addSelectionProperty: #placement options: #('top' 'top-start' 'top-end' 'right' 'right-start' 'right-end' 'bottom' 'bottom-start' 'bottom-end' 'left' 'left-start' 'left-end') default: 'top' comment: 'The preferred placement of the tooltip. Note that the actual placement may vary as needed to keep the tooltip
inside of the viewport.

Type: String
Default: ''top''
Allowed: ''top'' | ''top-start'' | ''top-end'' | ''right'' | ''right-start'' | ''right-end'' | ''bottom'' | ''bottom-start'' | ''bottom-end'' | ''left'' | ''left-start'' | ''left-end''
' do: [ :element :value | element placement: value ].
	self addNumberProperty: #showDelay default: 150 do: [ :element :value | element showDelay: value ].
	self addNumberProperty: #skidding default: 0 do: [ :element :value | element skidding: value ].
	self addStringProperty: #trigger default: 'hover focus' do: [ :element :value | element trigger: value ].
	self addBooleanProperty: #withoutArrow default: false comment: 'Removes the arrow from the tooltip.

Type: Boolean
Default: false
' do: [ :element :value | element withoutArrow: value ].
	self addMethod: #hide do: [ :element | element perform: #hide ].
	self addMethod: #show do: [ :element | element perform: #show ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTree [

	self visual: WaTree new.

	self addSelectionProperty: #selection options: #('single' 'multiple' 'leaf' 'leaf-multiple') default: 'single' comment: 'The selection behavior of the tree. Single selection allows only one node to be selected at a time. Multiple
displays checkboxes and allows more than one node to be selected. Leaf allows only leaf nodes to be selected.
Leaf-multiple allows multiple leaf nodes to be selected while parent nodes only expand and collapse.

Type: String
Default: ''single''
Allowed: ''single'' | ''multiple'' | ''leaf'' | ''leaf-multiple''
' do: [ :element :value | element selection: value ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaTreeItem [

	self visual: WaTreeItem new.

	self addBooleanProperty: #disabled default: false comment: 'Disables the tree item.

Type: Boolean
Default: false
' do: [ :element :value | element disabled: value ].
	self addBooleanProperty: #expanded default: false comment: 'Expands the tree item.

Type: Boolean
Default: false
' do: [ :element :value | element expanded: value ].
	self addBooleanProperty: #lazy default: false comment: 'Enables lazy loading behavior.

Type: Boolean
Default: false
' do: [ :element :value | element lazy: value ].
	self addBooleanProperty: #selected default: false comment: 'Draws the tree item in a selected state.

Type: Boolean
Default: false
' do: [ :element :value | element selected: value ].
	self addMethod: #getChildrenItems do: [ :element | element perform: #getChildrenItems ].

]

{ #category : #examples }
CpWebAwesomeExamplesWebClientBehavior >> exampleWaZoomableFrame [

	self visual: WaZoomableFrame new.

	self addBooleanProperty: #allowfullscreen default: false comment: 'Allows fullscreen mode.

Type: Boolean
Default: false
' do: [ :element :value | element allowfullscreen: value ].
	self addSelectionProperty: #loading options: #('eager' 'lazy') default: 'eager' comment: 'Controls iframe loading behavior.

Type: String
Default: ''eager''
Allowed: ''eager'' | ''lazy''
' do: [ :element :value | element loading: value ].
	self addStringProperty: #referrerpolicy default: nil do: [ :element :value | element referrerpolicy: value ].
	self addStringProperty: #sandbox default: nil do: [ :element :value | element sandbox: value ].
	self addStringProperty: #src default: nil do: [ :element :value | element src: value ].
	self addStringProperty: #srcdoc default: nil do: [ :element :value | element srcdoc: value ].
	self addBooleanProperty: #withThemeSync default: false comment: 'Enables automatic theme syncing (light/dark mode and theme selector classes) from the host document to the iframe.

Type: Boolean
Default: false
' do: [ :element :value | element withThemeSync: value ].
	self addBooleanProperty: #withoutControls default: false comment: 'Removes the zoom controls.

Type: Boolean
Default: false
' do: [ :element :value | element withoutControls: value ].
	self addBooleanProperty: #withoutInteraction default: false comment: 'Disables interaction when present.

Type: Boolean
Default: false
' do: [ :element :value | element withoutInteraction: value ].
	self addNumberProperty: #zoom default: 1 do: [ :element :value | element zoom: value ].
	self addStringProperty: #zoomLevels default: '25% 50% 75% 100% 125% 150% 175% 200%' do: [ :element :value | element zoomLevels: value ].
	self addMethod: #zoomIn do: [ :element | element perform: #zoomIn ].
	self addMethod: #zoomOut do: [ :element | element perform: #zoomOut ].

]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleAddButtonClicked [

	| slidePages |

	self visual ifNil: [ ^ self ].

	"Remove all slides, except first"
	[ (slidePages := self slides children) size > 1 ] whileTrue: [
		slidePages last destroy ].

	self slideBackButton beDisabled.

	self addDialog beOpen.

	"Ensure we remove the keyboard handler in the Carousel of the Add dialog"
	(CpHtmlElement documentBody isClassed: #init)
		ifFalse: [
			CpHtmlElement documentHead
				appendChild: ((CpHtmlElement newWithTag: #script)
					textContent: 'document.getElementById("slides").shadowRoot.addEventListener("keydown", function(e) { e.stopPropagation(); e.stopImmediatePropagation(); }, { capture: true });' ;
					yourself).
			CpHtmlElement documentBody addClass: #init ].

	self addParentButton
		disabled: (self visualCanHaveParent not or: [ self visualHasParent ])
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleAddChildButtonClicked [

	self selectSlot
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleAddParentButtonClicked [

	| parentClass visual |

	parentClass := self visualParentClass ifNil: [ ^ self ].

	visual := self visual.

	(CpHtmlElement elementWithId: #visual)
		addClass: #hasParent ;
		appendChild: (parentClass new
			appendChild: visual remove ;
			appendChild: (visual clone
				textContent: 'example2' ;
				ifNotNil: [ :child | (child isKindOf: WaFormControl) ifTrue: [ child value: #example2 ] ] ;
				yourself) ;
			appendChild: (visual clone
				textContent: 'example3' ;
				ifNotNil: [ :child | (child isKindOf: WaFormControl) ifTrue: [ child value: #example3 ] ] ;
				yourself) ;
			yourself).

	self addDialog beNotOpen
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleItemClicked: anAssociation [

	self perform: (current := anAssociation key)
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleResetButtonClicked [

	current ifNotNil: [ self perform: current ]
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleSlideBackButtonClicked [

	| slides children |

	slides := self slides.

	children := slides children.

	children size = 1
		ifTrue: [ ^ self ].

	slides previous.
	children last destroy.

	"Check for size 2 (before removal)"
	children size = 2
		ifTrue: [self slideBackButton beDisabled ].

	"Update the dialog title"
	self addDialog label: ((children at: children size - 1) firstChild propertyAt: #title)
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleSlideCloseButtonClicked [

	self addDialog beNotOpen
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleSourceButtonClicked [

	self visual ifNil: [ ^ self ].

	(CpHtmlElement elementWithId: #srcTextarea)
		value: (CpBrowserWindow current apply: #prettyHTML withArguments: { self visual }).

	self srcDialog beOpen
]

{ #category : #'event handling' }
CpWebAwesomeExamplesWebClientBehavior >> handleSourceCloseButtonClicked [

	self srcDialog beNotOpen
]

{ #category : #initialization }
CpWebAwesomeExamplesWebClientBehavior >> initialize [

	super initialize.

	self installHtmlBeautify.

	self showIndex
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> installHtmlBeautify [

	CpHtmlElement documentHead
		appendChild: ((CpHtmlElement newWithTag: #script)
			textContent: self installHtmlBeautifyScript ;
			yourself)
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> installHtmlBeautifyScript [

	^ 'window.prettyHTML = function(node, indent = "  ") {
  const fmt = (n, depth = 0) => {
    const pad = indent.repeat(depth);

    if (n.nodeType === Node.TEXT_NODE) {
      const text = n.textContent.trim();
      return text ? pad + text : "";
    }

    if (n.nodeType !== Node.ELEMENT_NODE) return "";

    const attrs = [...n.attributes]
      .map(a => ` ${a.name}="${a.value}"`)
      .join("");

    const children = [...n.childNodes]
      .map(c => fmt(c, depth + 1))
      .filter(Boolean);

    if (!children.length) {
      return `${pad}<${n.tagName.toLowerCase()}${attrs}></${n.tagName.toLowerCase()}>`;
    }

    return `${pad}<${n.tagName.toLowerCase()}${attrs}>\n` +
           children.join("\n") +
           `\n${pad}</${n.tagName.toLowerCase()}>`;
  };

  return fmt(node);
}'
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> lastSlide [

	"Answe last slide"
	
	"slides lastChild gives carousel, additional firstChild gives access to slide content"
	^ self slides lastChild firstChild
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> pageHtml [

	<webResource: #html>

	^ '<div id="page">
	<div id="menu">
	</div>
	<div id="content">
		<div id="component">
			<h1 id="name"></h1>
			<div id="visual">
			</div>
			<div id="controls">
				<wa-button id="addButton" appearance="outlined" title="Add parent or child element">
					<wa-icon name="plus"></wa-icon>
				</wa-button>
				<wa-button id="sourceButton" appearance="outlined" title="Show HTML source">
					<wa-icon name="code"></wa-icon>
				</wa-button>
				<wa-button id="resetButton" appearance="outlined" title="Reset to empty component">
					<wa-icon name="arrow-rotate-left"></wa-icon>
				</wa-button>
			</div>
		</div>
		<wa-divider></wa-divider>
		<div id="settings">
			<h1>Properties</h1>
			<div id="properties">
			</div>
			<wa-divider></wa-divider>
			<h1>Methods</h1>
			<div id="methods">
			</div>
		</div>
	</div>
</div>
<wa-dialog id="addDialog" label="Add element">
	<wa-carousel id="slides">
		<wa-carousel-item>
			<div title="Add element" class="horizontal">
				<wa-button id="addParentButton">Parent</wa-button>
				<wa-button id="addChildButton">Child</wa-button>
			</div>
		</wa-carousel-item>
	</wa-carousel>
	<wa-button id="slideBackButton" slot="footer">Back</wa-button>
	<wa-button id="slideCloseButton" slot="footer">Close</wa-button>
</wa-dialog>
<wa-dialog id="srcDialog" label="HTML source">
	<p>Be aware: The HTML code will only show the properties which reflect as attribute.</p>
	<wa-textarea id="srcTextarea"></wa-textarea>
	<wa-button id="srcCloseButton" slot="footer">Close</wa-button>
</wa-dialog>'
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> pageStyle [

	<webResource: #css>

	^ '*, *:before, *:after {
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
}
html, body {
	padding: 0;
	margin: 0;
	height: 100%;
}
#page {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
#menu {
	flex-shrink: 0;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: stretch;
	row-gap: 20px;
	padding: 16px;
	overflow-y: scroll;
}
#content {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	padding: 16px;
}
#component {
	position: relative;
	flex-shrink: 0;
	flex-grow: 1;
	min-height: 30%;
}
#name {
	position: absolute;
	top: 1em;
	left: 1em;
	color: #ccc;
	font-size: 3rem;
}
#name::before {
	content: "<";
}
#name::after {
	content: ">";
}
#visual {
	position: relative;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100%;
	padding: 20px;
}
#controls {
	position: absolute;
	bottom: 16px;
	right: 16px;
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	align-items: center;
	column-gap: 12px;
}
#settings {
	flex-grow: 1;
	overflow-y: scroll;
}
#properties,
#methods {
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	row-gap: 16px;
}
#properties {
	align-items: stretch;
}
#methods {
	align-items: flex-start;
}
#methods:empty::before {
	display: inline-block;
	content: "<No (parameterless) methods>";
}
#srcDialog::part(dialog) {
	width: 80em;
}
h1 {
	font-size: 1.4rem;
}
.horizontal,
.vertical {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 16px;
}
.horizontal {
	flex-direction: row;
}
.vertical {
	flex-direction: column;
}'
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> rawVisual [

	^ (CpHtmlElement elementWithId: #visual)
		firstChild
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> resetMethods [

	(CpHtmlElement elementWithId: #methods)
		removeChildren
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> resetProperties [

	(CpHtmlElement elementWithId: #properties)
		removeChildren
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectChildContent [

	| slide type |

	slide := self lastSlide.

	type := (slide firstDescendantMatching: WaRadioGroup asCssSelector) value.

	type = #text
		ifTrue: [ ^ self selectChildContentText ].

	type = #icon
		ifTrue: [ ^ self selectChildContentIcon ].

	type = #html
		ifTrue: [ ^ self selectChildContentHtml ]
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectChildContentHtml [

	| slide |

	slide := (CpHtmlElement newWithTag: #div)
		propertyAt: #purpose put: #htmlContent ;
		propertyAt: #title put: 'Which html content?' ;
		addClass: #vertical ;
		appendChild: (WaTextarea new
			label: 'HTML' ;
			beNotAutocorrect ;
			beNotSpellcheck ;
			autocapitalize: #off ;
			yourself) ;
		appendChild: (WaButton new
			textContent: 'Add' ; 
			when: CpClickEvent basicPrimary send: #addHtmlContent to: self ;
			yourself) ;
		yourself.

	self addAndShowSlide: slide
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectChildContentIcon [

	| slide |

	slide := (CpHtmlElement newWithTag: #div)
		propertyAt: #purpose put: #iconContent ;
		propertyAt: #title put: 'Which icon?' ;
		addClass: #horizontal ;
		yourself.

	#(heart plus 'thumbs-up' rocket) do: [ :each |
		slide
			appendChild: (WaIcon new
				name: each ;
				when: CpClickEvent basicPrimary send: #addIconContent: to: self ;
				yourself) ].

	self addAndShowSlide: slide
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectChildContentText [

	| slide |

	slide := (CpHtmlElement newWithTag: #div)
		propertyAt: #purpose put: #textContent ;
		propertyAt: #title put: 'Which text content?' ;
		addClass: #horizontal ;
		appendChild: (WaInput new
			label: 'Text' ;
			when: CpKeyUpEvent enter send: #addTextContent to: self ;
			hint: 'Press enter to set the content' ;
			yourself) ;
		yourself.

	self addAndShowSlide: slide
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectChildType [

	| slide selection |

	slide := (CpHtmlElement newWithTag: #div)
		propertyAt: #purpose put: #childType ;
		propertyAt: #title put: 'Type of child?' ;
		addClass: #horizontal ;
		appendChild: (selection := (WaRadioGroup new
			orientation: #horizontal ;
			when: CpChangeEvent send: #selectChildContent to: self ;
			yourself)) ;
		yourself.

	#(text icon html) do: [ :each |
		selection appendChild: (WaRadio new
			value: each asString ;
			textContent: each ;
			yourself) ].

	selection value: nil.

	self addAndShowSlide: slide
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectSlot [

	| slotNames slide selection |

	slotNames := self visual slotNames.

	slotNames ifEmpty: [ ^ self selectChildType ].

	slide := (CpHtmlElement newWithTag: #div)
		propertyAt: #purpose put: #slot ;
		propertyAt: #title put: 'In which slot?' ;
		addClass: #horizontal ;
		appendChild: (selection := (WaRadioGroup new
			orientation: #horizontal ;
			when: CpChangeEvent send: #selectChildType to: self ;
			yourself)) ;
		yourself.

	slotNames := { nil }, slotNames.

	slotNames do: [ :each |
		selection appendChild: (WaRadio new
			value: each ;
			textContent: (each ifNil: [ #default ]) ;
			yourself) ].

	selection value: #doesNotExist.

	self addAndShowSlide: slide
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectedLocation [

	self slides children do: [ :each |
		(each firstChild propertyAt: #purpose) = #childType
			ifTrue: [ ^ #child ] ].

	^ #parent
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> selectedSlot [

	self slides children do: [ :each |
		(each firstChild propertyAt: #purpose) = #slot
			ifTrue: [ ^ each firstChild firstChild value ] ].

	^ nil
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> showIndex [

	"Beware: this method is NOT to be taken as exemplar for creating a UI.
	This class is just a collection of examples of UI possibilities."

	| menu items |

	"Remove existing body and add page HTML"
	CpHtmlElement documentBody
		removeChildren ;
		markupContent: self pageHtml.

	self addEventHandlers.

	"Remove existing styling and add page CSS"
	(CpHtmlElement documentHead firstDescendantMatching: '#pageStyle')
		ifNotNil: [ :style | style remove ].
	(CpHtmlElement documentAddStyle: self pageStyle)
		id: #pageStyle.

	"Fill menu"
	menu := CpHtmlElement elementWithId: #menu.

	"Collect items from example methods"
	items := (self class selectors
		select: [ :each | each beginsWith: #example ])
			collect: [ :selector | selector -> (selector withoutPrefix: #example) ].

	"Sort items (alphabetically on component name)"
	items sort: [ :a :b | a value < b value ].

	"Render items onto DOM"
	items do: [ :item |

		menu appendChild: (WaButton new
			endElement: 'arrow-right' asWebAwesomeIcon ;
			textContent: (item value withoutPrefix: 'Wa') ;
			when: CpClickEvent basicPrimary do: [ self handleItemClicked: item ] for: self ;
			yourself) ].

	"Add reload button"
	menu
		appendChild: ((CpHtmlElement newWithTag: #div)
			appendChild: (WaButton new
				appendChild: (WaIcon new
					name: #'arrow-rotate-left' ;
					yourself) ;
				yourself) ;
				when: CpClickEvent basicPrimary send: #showIndex to: self ;
			yourself).

	"Let's start somewhere"
	self exampleWaButton
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> slideBackButton [

	^ CpHtmlElement elementWithId: #slideBackButton
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> slides [

	^ CpHtmlElement elementWithId: #slides
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> srcDialog [

	^ CpHtmlElement elementWithId: #srcDialog
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> visual [

	| visual |

	visual := self rawVisual.

	^ self visualHasParent
		ifTrue: [ visual firstChild ]
		ifFalse: [ visual ]
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> visual: anElement [

	(CpHtmlElement elementWithId: #name)
		textContent: anElement tagName.

	(CpHtmlElement elementWithId: #visual)
		removeClass: #hasParent ;
		replaceAllChildrenWith: anElement.

	self
		resetProperties ;
		resetMethods
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> visualCanHaveParent [

	^ self visualParentClass isNotNil
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> visualHasParent [

	^ (CpHtmlElement elementWithId: #visual)
		isClassed: #hasParent
]

{ #category : #view }
CpWebAwesomeExamplesWebClientBehavior >> visualParentClass [

	"Answer the class for the parent of the visual
	or nil if the visual does not have a (default) parent"

	| visual className |

	visual := self rawVisual ifNil: [ ^ nil ].

	className := visual class name.

	(Smalltalk classNamed: className, #Group)
		ifNotNil: [ :parentClass | ^ parentClass ].

	(className endsWith: #Item)
		ifTrue: [
			(Smalltalk classNamed: (className withoutSuffix: #Item))
				ifNotNil: [ :parentClass | ^ parentClass ] ].

	^ nil
]
