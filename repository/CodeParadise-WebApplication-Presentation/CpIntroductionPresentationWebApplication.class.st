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
CpIntroductionPresentationWebApplication >> createExplainApplicationSlide [

	^ CpTitledSlide new
		title: 'Explanation: web applications' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'CodeParadise supports building web applications' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'Smalltalk code runs server-side and client-side (in browser)' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'Typically it consists of a server-side CpWebApplication (class)' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'And a client-side CpWebClientBehavior (class)' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'This combo delivers the required application functionality' ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'In the Pharo IDE an Inspector is opened' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'The Inspector shows the CpWebApplication instance' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The Application knows its Models and Presenters' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'The Presenters know their Views (and Models)' ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Interact with the application by executing (from Inspector)' ;
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
CpIntroductionPresentationWebApplication >> createExplainModelSlide [

	^ CpTitledSlide new
		title: 'Explanation: Model' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'The presentation (this slideshow) is a Model' ;
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
				text: 'You just asked it for its next slide' ;
				yourself) ;
			addBullet: (CpBulletedContent new
				addBullet: (CpTextContent new
					text: 'Because "self models first" refers to the Presentation model' ;
					yourself) ;
				addBullet: (CpTextContent new
					text: 'Sending the message #nextSlide made the Presentation advance' ;
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
					text: 'The Presenter is subscribed to announcements of the Model' ;
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
				text: '(Just press <Space> or <Right> to go to next slide)' ;
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
				text: 'It also acts as a small tutorial' ;
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
		addSlide: self createExplainApplicationSlide ;
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
