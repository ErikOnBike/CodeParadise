Class {
	#name : #CpIntroductionPresentationWebApplication,
	#superclass : #CpPresentationWebApplication,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #accessing }
CpIntroductionPresentationWebApplication class >> app [

	^ #presentation
]

{ #category : #model }
CpIntroductionPresentationWebApplication >> createExplainModelSlide [

	^ CpTitledSlide new
		title: 'Explanation: Model' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'The presentation is a Model' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'An object with behavior and state' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'Representing a real world presentation' ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It is built using the Model View Presenter pattern' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'You can interact with the model from the IDE' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'An Inspector should be opened on the current application' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Try executing the following line (in the Inspector)' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'self models first nextSlide' ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #model }
CpIntroductionPresentationWebApplication >> createExplainModelSuccessSlide [

	^ CpTitledSlide new
		title: 'Explanation: Model updated' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'Very good! The model is updated' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'And because MVP is applied the view updated too' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'The Model changed state' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The Model announced this change' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The Presenter was subscribed to announcements of the Model' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The Presenter therefore received the announcement' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The Presenter rendered the (new) current slide on its View' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The View received relevant information like title and content' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The View updated the HTML in the browser' ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Try executing the following line again (in the Inspector)' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'self models first nextSlide' ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #model }
CpIntroductionPresentationWebApplication >> createExplanationSlide [

	^ CpTitledSlide new
		title: 'Explanation' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'This presentation is an example application' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It is built using the Model View Presenter pattern' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It also acts as a tutorial' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Just follow the instructions on the next slides' ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #model }
CpIntroductionPresentationWebApplication >> createFinalSlide [

	^ CpTitledSlide new
		title: 'The End' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'This is the end of the presentation' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Thanks for joining in' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'I hope you enjoyed playing with it' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'And learned a bit about the MVP pattern' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'As it is applied within CodeParadise' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Happy coding!' ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #model }
CpIntroductionPresentationWebApplication >> createIntroductionSlide [

	^ CpFullPageSlide new
		content: (CpImageContent new
			url: '/static/resources/presentation-opening-slide.svg' ;
			width: '100%' ;
			yourself) ;
		yourself
]

{ #category : #model }
CpIntroductionPresentationWebApplication >> createPresentationModel [

	"Create and answer the PresentationModel for the presentation"

	^ (CpPresentation titled: 'CodeParadise')
		addSlide: self createIntroductionSlide ;
		addSlide: self createExplanationSlide ;
		addSlide: self createExplainModelSlide ;
		addSlide: self createExplainModelSuccessSlide ;
		addSlide: self createFinalSlide ;
		yourself
]

{ #category : #actions }
CpIntroductionPresentationWebApplication >> load [

	"Convenience implementation to show the receiver (ie Application)
	in an Inspector. From this Inspector the receiver's Presenters,
	Models and the ServerEnvironment can be accessed. This allows the
	manipulation of the receiver from the development environment.
	This should not be used in production environments."

	super load.

	self inspect
]
