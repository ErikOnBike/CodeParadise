Class {
	#name : #CpMvpWebClientBehavior,
	#superclass : #CpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-MVP-Core'
}

{ #category : #creating }
CpMvpWebClientBehavior class >> createPresenter: aPresenter in: aServerEnvironment [

	"Create a new Presenter in the ClientEnvironment belonging to the specified ServerEnvironment"

	aServerEnvironment
		addClass: aPresenter class ;

		clientPerform: #createPresenter:withId:
		withArguments: { aPresenter class name . aPresenter id }
		receiver: self clientId
]

{ #category : #creating }
CpMvpWebClientBehavior >> createPresenter: aPresenterClass withId: identifier [

	"Create a new Presenter with the specified identifier (a String).
	The View for the Presenter is also created.
	A proxy is created for the Model (which lives in the ServerEnvironment)."

	| presenter |

	presenter := CpClientEnvironment current createInstanceOf: aPresenterClass withId: identifier.
	^ presenter
		id: identifier ;
		model: CpModelProxy new ;
		createView ;
		yourself
]
