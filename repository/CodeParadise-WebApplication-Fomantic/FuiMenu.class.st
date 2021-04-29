Class {
	#name : #FuiMenu,
	#superclass : #FuiElement,
	#category : #'CodeParadise-WebApplication-Fomantic-Elements'
}

{ #category : #accessing }
FuiMenu class >> allSizeVariations [

	^ #(#tiny #mini #small #large #huge #massive)
]

{ #category : #accessing }
FuiMenu class >> allTypes [

	^ #(#secundary #pointing #tabular #text #vertical #pagination)
]

{ #category : #accessing }
FuiMenu class >> allVariations [

	^ #(#fixed #stackable #inverted #icon #'labeled icon' #fluid #compact #'two item' #'three item' #'four item' #'five item' #'six item' #'seven item' #'eight item' #'nine item' #'ten item' #'eleven item' #'twelve item' #attached #'top attached' #'bottom attached' #tiny #mini #small #large #huge #massive #fitted #borderless)
]

{ #category : #accessing }
FuiMenu class >> baseElementTagName [

	^ #div
]

{ #category : #'accessing - variation' }
FuiMenu >> beAttached [

	self addVariation: #attached
]

{ #category : #'accessing - variation' }
FuiMenu >> beBorderless [

	self addVariation: #borderless
]

{ #category : #'accessing - variation' }
FuiMenu >> beBottomAttached [

	self addVariation: #'bottom attached'
]

{ #category : #'accessing - variation' }
FuiMenu >> beCompact [

	self addVariation: #compact
]

{ #category : #'accessing - variation' }
FuiMenu >> beDivided: anInteger [

	self addVariation: (#(#two #three #four #five #six #seven #eight #nine #ten #eleven #twelve) at: anInteger - 1), #' item'
]

{ #category : #'accessing - variation' }
FuiMenu >> beFitted [

	self addVariation: #fitted
]

{ #category : #'accessing - variation' }
FuiMenu >> beFixed [

	self addVariation: #fixed
]

{ #category : #'accessing - variation' }
FuiMenu >> beFluid [

	self addVariation: #fluid
]

{ #category : #'accessing - variation' }
FuiMenu >> beHorizontallyFitted [

	self addVariation: #'horizontally fitted'
]

{ #category : #'accessing - variation' }
FuiMenu >> beIcon [

	self addVariation: #icon
]

{ #category : #'accessing - variation' }
FuiMenu >> beInverted [

	self addVariation: #inverted
]

{ #category : #'accessing - variation' }
FuiMenu >> beLabeledIcon [

	self addVariation: #'labeled icon'
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotAttached [

	self removeVariations: #(#attached #'top attached' #'bottom attached')
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotBorderless [

	self removeVariation: #borderless
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotCompact [

	self removeVariation: #compact
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotDivided [

	self removeVariations: #(#'two item' #'three item' #'four item' #'five item' #'six item' #'seven item' #'eight item' #'nine item' #'ten item' #'eleven item' #'twelve item')
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotFitted [

	self removeVariations: #(#fitted #'horizontally fitted' #'vertically fitted')
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotFixed [

	self removeVariation: #fixed
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotFluid [

	self removeVariation: #fluid
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotIcon [

	self removeVariations: #(#icon #'labeled icon')
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotInverted [

	self removeVariation: #inverted
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotLabeledIcon [

	self removeVariation: #'labeled icon'
]

{ #category : #'accessing - variation' }
FuiMenu >> beNotStackable [

	self removeVariation: #stackable
]

{ #category : #'accessing - type' }
FuiMenu >> bePointing [

	self setType: #pointing ofTypes: self class allTypes
]

{ #category : #'accessing - type' }
FuiMenu >> beSecundary [

	self setType: #secundary ofTypes: self class allTypes
]

{ #category : #'accessing - variation' }
FuiMenu >> beSizeHuge [

	self setVariation: #huge ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiMenu >> beSizeLarge [

	self setVariation: #large ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiMenu >> beSizeMassive [

	self setVariation: #massive ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiMenu >> beSizeMini [

	self setVariation: #mini ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiMenu >> beSizeTiny [

	self setVariation: #tiny ofVariations: self class allSizeVariations
]

{ #category : #'accessing - variation' }
FuiMenu >> beStackable [

	self addVariation: #stackable
]

{ #category : #'accessing - type' }
FuiMenu >> beTabular [

	self setType: #tabular ofTypes: self class allTypes
]

{ #category : #'accessing - type' }
FuiMenu >> beText [

	self setType: #text ofTypes: self class allTypes
]

{ #category : #'accessing - variation' }
FuiMenu >> beTopAttached [

	self addVariation: #'top attached'
]

{ #category : #'accessing - type' }
FuiMenu >> beVertical [

	self setType: #vertical ofTypes: self class allTypes
]

{ #category : #'accessing - variation' }
FuiMenu >> beVerticallyFitted [

	self addVariation: #'vertically fitted'
]
