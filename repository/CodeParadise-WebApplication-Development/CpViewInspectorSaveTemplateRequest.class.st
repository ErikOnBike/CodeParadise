Class {
	#name : #CpViewInspectorSaveTemplateRequest,
	#superclass : #CpViewInspectorSaveRequest,
	#category : #'CodeParadise-WebApplication-Development-Announcements'
}

{ #category : #'as yet unclassified' }
CpViewInspectorSaveTemplateRequest class >> viewTagName: tagNameString [

	self error: 'Incorrect use. Please use ', #viewTagName:template:
]

{ #category : #'as yet unclassified' }
CpViewInspectorSaveTemplateRequest class >> viewTagName: tagNameString template: templateString [

	^ self basicNew
		initializeWithViewTagName: tagNameString template: templateString ;
		yourself
]

{ #category : #initialization }
CpViewInspectorSaveTemplateRequest >> initializeWithViewTagName: tagNameString template: templateString [

	self initializeWithViewTagName: tagNameString sourceCode: templateString
]

{ #category : #accessing }
CpViewInspectorSaveTemplateRequest >> sourceCodeSelector [

	<serverEnvironment>

	^ #template
]
