Class {
	#name : #CpViewInspectorSaveStyleRequest,
	#superclass : #CpViewInspectorSaveRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #'as yet unclassified' }
CpViewInspectorSaveStyleRequest class >> viewTagName: tagNameString [

	self error: 'Incorrect use. Please use ', #viewTagName:style:
]

{ #category : #'as yet unclassified' }
CpViewInspectorSaveStyleRequest class >> viewTagName: tagNameString style: styleString [

	^ self basicNew
		initializeWithViewTagName: tagNameString style: styleString ;
		yourself
]

{ #category : #initialization }
CpViewInspectorSaveStyleRequest >> initializeWithViewTagName: tagNameString style: styleString [

	self initializeWithViewTagName: tagNameString sourceCode: styleString
]

{ #category : #accessing }
CpViewInspectorSaveStyleRequest >> sourceCodePrefix [

	"Answer the source code prefix, to check if format is correct and create new method.
	Currently very strict check."

	<serverEnvironment>

	^ 'style

	<webResource: #css>

	^ '''
]

{ #category : #accessing }
CpViewInspectorSaveStyleRequest >> sourceCodeSelector [

	<serverEnvironment>

	^ #style
]

{ #category : #accessing }
CpViewInspectorSaveStyleRequest >> sourceCodeSuffix [

	"Answer the source code suffix, to check if format is correct and create new method.
	Currently very strict check."

	<serverEnvironment>

	^ ''''
]
