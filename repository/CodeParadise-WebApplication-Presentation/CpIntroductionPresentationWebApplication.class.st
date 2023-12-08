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
CpIntroductionPresentationWebApplication >> createPresentationModel [

	"Create and answer the PresentationModel for the presentation"

	^ (CpPresentation titled: 'CodeParadise')
		addSlide: self introductionSlide ;
		addSlide: self explanationSlide ;
		addSlide: self explainApplicationSlide ;
		addSlide: self explainMvpApplicationSlide ;
		addSlide: self webApplicationClassSlide ;
		addSlide: self mvpWebApplicationClassSlide ;
		addSlide: self mvpWebClientBehaviorClassSlide ;
		addSlide: self viewClassSlide ;
		addSlide: self modelClassSlide ;
		addSlide: self presenterClassSlide ;
		addSlide: self slideIndexSlide ;
		addSlide: self finalSlide ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> explainApplicationSlide [

	^ CpTitledSlide new
		title: 'Web applications' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'CodeParadise supports building web applications' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Using Smalltalk only' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Web applications are created using' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'A server-side CpWebApplication class (or subclass)' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'A client-side CpWebClientBehavior class (or subclass)' ;
						yourself) ;
					yourself) ;
				yourself) ;
			addBullet:  (CpMultiContent new
				addContent: (CpTextContent new
					text: 'The client-side code runs in the browser' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpHtmlContent new
						html: 'Using SqueakJS VM - <a href="https://squeak.js.org" target="_target">https://squeak.js.org</a>' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'In a tiny Smalltalk image' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Where code is installed dynamically' ;
						yourself) ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> explainMvpApplicationSlide [

	^ CpTitledSlide new
		title: 'Web applications with MVP' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'Model View Presenter (with Passive View)' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'For the MVP pattern specific classes are present' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Server-side' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'CpMvpWebApplication' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'CpModel (or plain Model)' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'CpPresenter' ;
						yourself) ;
					yourself) ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Client-side (running in the browser)' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'CpMvpWebClientBehavior' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'CpView' ;
						yourself) ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Let''s look at these in turn' ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> explanationSlide [

	^ CpTitledSlide new
		title: 'Explanation' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'This presentation is an example web application' ;
				yourself) ;
			addBullet: (CpHtmlContent new
				html: 'It is built using the <a href="https://www.martinfowler.com/eaaDev/PassiveScreen.html" target="_blank">Model View Presenter</a> pattern' ;
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

{ #category : #slides }
CpIntroductionPresentationWebApplication >> finalSlide [

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

{ #category : #slides }
CpIntroductionPresentationWebApplication >> introductionSlide [

	^ CpFullPageSlide new
		content: (CpImageContent new
			url: '/static/resources/presentation-opening-slide.svg' ;
			width: '100%' ;
			yourself) ;
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

{ #category : #slides }
CpIntroductionPresentationWebApplication >> modelClassSlide [

	^ CpTitledSlide new
		title: 'CpModel class' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'Normally you update a model' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Which will announce a change' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Presenters will have subscribed to these announcements' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'And will update their view accordingly' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Let''s update the presentation model' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'From the application Inspector' ;
					yourself) ;
				addContent: (CpDemoApplicationCodeContent new
					code: 'self presentation currentSlide title: ''Change!''' ;
					yourself) ;
				addContent: (CpDemoApplicationCodeContent new
					code: ('self presentation currentSlide content
	addBullet: (CpTextContent text: ''Added dynamically'')' copyReplaceAll: String cr with: String lf) ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> mvpWebApplicationClassSlide [

	^ CpTitledSlide new
		title: 'CpMvpWebApplication class' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'Yes, the next slide is shown!' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'This demo application is derived from CpMvpWebApplication' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'Which keeps track of its models' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'And its presenters' ;
						yourself) ;
					yourself) ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Try again (from the Inspector)' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpDemoApplicationCodeContent new
						code: 'self showNextSlide' ;
						yourself) ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> mvpWebClientBehaviorClassSlide [

	^ CpTitledSlide new
		title: 'CpMvpWebClientBehavior class' ;
		content: (CpBulletedContent new
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'This browser runs an instance of CpMvpWebClientBehavior' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'Which installs an event handler' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'And creates/instantiates views' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'The views receive the events triggered on them' ;
						yourself) ;
					addBullet: (CpHtmlContent new
						html: 'The views are WebComponents - <a href="https://www.webcomponents.org/introduction" target="_blank">https://www.webcomponents.org</a>' ;
						yourself) ;
					yourself) ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Let''s update a view live' ;
					yourself) ;
				addContent: (CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'Open a Browser on CpTitledSlideView' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Go to the class method #style' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'It contains a CSS definition' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Try changing font-size or color' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'As soon as you save the change the browser will update!' ;
						yourself) ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #actions }
CpIntroductionPresentationWebApplication >> openInspector [

	"Open an Inspector on the receiver and answer it"

	^ self inspector
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> presenterClassSlide [

	^ CpTitledSlide new
		title: 'CpPresenter class' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'The Presenter is our man in the middle' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It handles announcements from the Model' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It handles announcements from the View' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It asks the Model to update' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'It asks the View to render information' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Don''t make it too smart!' ;
					yourself) ;
				addContent:(CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'Don''t add business logic' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Delegate as much as possible' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'To the Model or the View' ;
						yourself) ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #actions }
CpIntroductionPresentationWebApplication >> showNextSlide [

	self presentation nextSlide
]

{ #category : #actions }
CpIntroductionPresentationWebApplication >> showPreviousSlide [

	self presentation previousSlide
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> slideIndexSlide [

	^ CpTitledSlide new
		title: 'WebComponent reuse' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'WebComponents should be reusable components' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'As a small example' ;
					yourself) ;
				addContent:(CpBulletedContent new
					addBullet: (CpTextContent new
						text: 'Open a slide-index by pressing <i>' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Use <Left>, <Right>, <Space> or <Backspace> to chose slide' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Press <i> again to close slide-index and make selected slide current' ;
						yourself) ;
					addBullet: (CpTextContent new
						text: 'Press <Escape> to close slide-index and return to current slide' ;
						yourself) ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'The slides within the slide-index are reused' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'They use the same Presenter/View as regular slides' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'They are still interactive (see code examples)' ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> viewClassSlide [

	^ CpTitledSlide new
		title: 'CpView class' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'A View is an UI element' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Views are only present client-side in the browser' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Views should not contain any business logic' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Views should be seen as native rendering elements' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Views should preferrably only work with Strings, Numbers and Points' ;
				yourself) ;
			yourself) ;
		yourself
]

{ #category : #slides }
CpIntroductionPresentationWebApplication >> webApplicationClassSlide [

	^ CpTitledSlide new
		title: 'CpWebApplication class' ;
		content: (CpBulletedContent new
			addBullet: (CpTextContent new
				text: 'An instance is created for every session' ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'Currently no session management implemented' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Therefore use following to clean up sessions' ;
					yourself) ;
				addContent: (CpDemoCodeContent new
					code: 'CpWebApplication allSubInstances do: [ :each | each stop ]' ;
					yourself) ;
				yourself) ;
			addBullet: (CpTextContent new
				text: 'An Inspector is opened on this demo application' ;
				yourself) ;
			addBullet: (CpMultiContent new
				addContent: (CpTextContent new
					text: 'Interact with the application by executing (from Inspector)' ;
					yourself) ;
				addContent: (CpDemoApplicationCodeContent new
					code: 'self showNextSlide' ;
					yourself) ;
				yourself) ;
			yourself) ;
		yourself
]
