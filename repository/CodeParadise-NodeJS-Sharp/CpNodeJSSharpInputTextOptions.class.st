Class {
	#name : #CpNodeJSSharpInputTextOptions,
	#superclass : #CpAbstractOptions,
	#category : #'CodeParadise-NodeJS-Sharp-Support'
}

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> align [

	"Alignment style for multi-line text ('left', 'centre', 'center', 'right').

	Type: String
	Default: 'left'"

	^ options at: #align
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> align: aString [

	"Alignment style for multi-line text ('left', 'centre', 'center', 'right')."

	options at: #align put: aString
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> dpi [

	"The resolution (size) at which to render the text. Does not take effect if height is specified.

	Type: Integer
	Default: 72"

	^ options at: #dpi
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> dpi: anInteger [

	"The resolution (size) at which to render the text. Does not take effect if height is specified."

	options at: #dpi put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> font [

	"Font name to render with.

	Type: String"

	^ options at: #font
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> font: aString [

	"Font name to render with."

	options at: #font put: aString
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> fontFile [

	"Absolute filesystem path to a font file that can be used by font.

	Type: String"

	^ options at: #fontFile
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> fontFile: aString [

	"Absolute filesystem path to a font file that can be used by font."

	options at: #fontFile put: aString
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> height [

	"Maximum integral number of pixels high. When defined, dpi will be ignored and the text will automatically fit the pixel resolution defined by width and height. Will be ignored if width is not specified or set to 0.

	Type: Integer
	Default: 0"

	^ options at: #height
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> height: anInteger [

	"Maximum integral number of pixels high. When defined, dpi will be ignored and the text will automatically fit the pixel resolution defined by width and height. Will be ignored if width is not specified or set to 0."

	options at: #height put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> justify [

	"Set this to true to apply justification to the text.

	Type: Boolean
	Default: false"

	^ options at: #justify
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> justify: aBoolean [

	"Set this to true to apply justification to the text."

	options at: #justify put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> rgba [

	"Set this to true to enable RGBA output. This is useful for colour emoji rendering, or support for pango markup features like <span foreground=""red"">Red!</span>.

	Type: Boolean
	Default: false"

	^ options at: #rgba
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> rgba: aBoolean [

	"Set this to true to enable RGBA output. This is useful for colour emoji rendering, or support for pango markup features like <span foreground=""red"">Red!</span>."

	options at: #rgba put: aBoolean
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> spacing [

	"Text line height in points. Will use the font line height if none is specified.

	Type: Integer
	Default: 0"

	^ options at: #spacing
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> spacing: anInteger [

	"Text line height in points. Will use the font line height if none is specified."

	options at: #spacing put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> text [

	"Text to render as a UTF-8 string. It can contain Pango markup, for example <i>Le</i>Monde.

	Type: String"

	^ options at: #text
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> text: aString [

	"Text to render as a UTF-8 string. It can contain Pango markup, for example <i>Le</i>Monde."

	options at: #text put: aString
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> width [

	"Integral number of pixels to word-wrap at. Lines of text wider than this will be broken at word boundaries.

	Type: Integer
	Default: 0"

	^ options at: #width
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> width: anInteger [

	"Integral number of pixels to word-wrap at. Lines of text wider than this will be broken at word boundaries."

	options at: #width put: anInteger
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> wrap [

	"Word wrapping style when width is provided, one of: 'word', 'char', 'word-char' (prefer word, fallback to char) or 'none'.

	Type: String
	Default: 'word'"

	^ options at: #wrap
]

{ #category : #accessing }
CpNodeJSSharpInputTextOptions >> wrap: aString [

	"Word wrapping style when width is provided, one of: 'word', 'char', 'word-char' (prefer word, fallback to char) or 'none'.

	Type: String
	Default: 'word'"

	options at: #wrap put: aString
]
