"
I am a Model in a Model-View-Presenter pattern.
I announce when my value changed.

"
Class {
	#name : #CpModel,
	#superclass : #CpBaseModel,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #accessing }
CpModel >> application [

	"Answer the application in which the receiver is running.

	Implementation:
	The current application (ie session) is stored in an application context (dynamic variable)."

	^ CpCurrentApplicationContext application

]

{ #category : #presenter }
CpModel >> display [

	^ self displayIn: self application applicationPresenter
]

{ #category : #presenter }
CpModel >> displayIn: aPresenter [

	^ aPresenter createChildPresenterForModel: self
]

{ #category : #presenter }
CpModel >> preferredPresenterClass [

	"Answer the preferred Presenter class for the receiver (in its current state).
	By default the class with a matching name will be used (if present in the image).
	The matching name is created by postfixing #Presenter (optionally replacing an
	existing postfix #Model).
	Otherwise an error is raised to make clear a presenter class should be implemented
	or a subclass should override this method to answer a specific presenter class."

	| className presenterClass |

	className := (self class name withoutSuffix: #Model) asSymbol , #Presenter.
	presenterClass := Smalltalk classNamed: className.

	"If no Presenter class is found, raise an error to indicate the class should be created
	or the subclass should implement #preferredPresenterClass"
	presenterClass
		ifNil: [ self error: ('The Presenter class {1} does not exist. Either create it or implement {2} >> #preferredPresenterClass to answer a specific class' format: { className . self class name }) ].

	^ presenterClass
]
