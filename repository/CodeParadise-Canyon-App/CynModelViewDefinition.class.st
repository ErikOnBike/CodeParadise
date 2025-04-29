Class {
	#name : #CynModelViewDefinition,
	#superclass : #Object,
	#instVars : [
		'model',
		'view',
		'slotName'
	],
	#category : #'CodeParadise-Canyon-App-View'
}

{ #category : #'instance creation' }
CynModelViewDefinition class >> model: modelObject view: viewObject [

	^ self model: modelObject view: viewObject slotName: nil
]

{ #category : #'instance creation' }
CynModelViewDefinition class >> model: modelObject view: viewObject onCondition: aBlock [

	^ self
		model: modelObject
		view: viewObject
		slotName: nil
		onCondition: aBlock
]

{ #category : #'instance creation' }
CynModelViewDefinition class >> model: modelObject view: viewObject slotName: aString [

	"Answer a new instance of the receiver with the specified model, view and slot name.

	I am used in a CynModelView (typically a CynPage but not restricted as such) to define
	any child views.

	The modelObject can be either a Block or a Symbol. When using my instance to retrieve
	the model, it will send #cull: to the modelObject with the parent's model as argument.
	The evaluation should result in the actual Model object. By specifying a Symbol, the
	model is requested to perform the related method which answers a related Model object.
	For example, the following definition could be used if the parent's model is an
	Employee which has an accessor #projects to answer the Project models which the
	employee is working on.
	```
		CynModelViewDefinition model: #projects view: MyProjectsView slotName: #projects
	```

	The viewObject can be either a Block or a View Class (as in the example above). When
	using my instance to retrieve the View class, it will send #cull: to the viewObject.
	For convenience any CpWebComponent subclass (incl. CynModelView) will answer the
	class itself.
	IF the View Class answered (by a Block) is nil, the child view is assumed to be
	not present (any previously installed one will be removed in the parent). There
	is also the instance creation method #model:view:slotName:onCondition: to achieve
	this effect more explicitly.

	The slot name may be nil (empty is considered nil as well) to indicate the default
	slot should be used (i.e. an unnnamed slot)."

	^ self basicNew
		initializeWithModel: modelObject view: viewObject slotName: aString ;
		yourself
]

{ #category : #'instance creation' }
CynModelViewDefinition class >> model: modelObject view: viewObject slotName: aString onCondition: aBlock [

	"Answer an instance of the receiver which is only shown conditionally.
	The condition is a Block which is evaluated using #cull: to provide a
	Boolean answer whether the receiver should be shown/used."

	^ self
		model: modelObject
		view: [ :model |
			(aBlock cull: model)
				ifTrue: [ viewObject cull: model ] ]
		slotName: aString
]

{ #category : #initialization }
CynModelViewDefinition >> initializeWithModel: modelObject view: viewObject slotName: aString [

	self initialize.

	model := modelObject.
	view := viewObject.

	"Replace an empty slot name with nil"
	slotName := aString ifNotNil: [ aString ifEmpty: [ nil ] ]
]

{ #category : #accessing }
CynModelViewDefinition >> modelFromModel: aModel [

	^ model cull: aModel
]

{ #category : #accessing }
CynModelViewDefinition >> slotName [

	^ slotName
]

{ #category : #accessing }
CynModelViewDefinition >> viewClassForModel: aModel [

	^ view cull: aModel
]
