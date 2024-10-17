Class {
	#name : #CpViewInspectorSaveGlobalStyleRequest,
	#superclass : #CpViewInspectorSaveRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #'as yet unclassified' }
CpViewInspectorSaveGlobalStyleRequest class >> viewTagName: tagNameString [

	self error: 'Incorrect use. Please use ', #viewTagName:style:
]

{ #category : #'as yet unclassified' }
CpViewInspectorSaveGlobalStyleRequest class >> viewTagName: tagNameString style: styleString [

	^ self basicNew
		initializeWithViewTagName: tagNameString style: styleString ;
		yourself
]

{ #category : #initialization }
CpViewInspectorSaveGlobalStyleRequest >> initializeWithViewTagName: tagNameString style: styleString [

	self initializeWithViewTagName: tagNameString sourceCode: styleString
]

{ #category : #accessing }
CpViewInspectorSaveGlobalStyleRequest >> sourceCodeSelector [

	<serverEnvironment>

	^ #globalStyle
]
