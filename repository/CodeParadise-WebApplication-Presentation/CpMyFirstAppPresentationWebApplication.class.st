Class {
	#name : #CpMyFirstAppPresentationWebApplication,
	#superclass : #CpPresentationWebApplication,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #accessing }
CpMyFirstAppPresentationWebApplication class >> app [

	^ #'building-my-first-app'
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addApplicationMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding behaviour to the Application' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoWebApplication:'.
				CpDemoMethodCodeContent code: 'app

	"Answer the identifier for this application"

	^ #''my-to-do-app''' methodClass: #'MyToDoWebApplication class' classified: #accessing.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following two instance methods to MyToDoWebApplication:'.
				CpDemoMethodCodeContent code: 'initialize

	super initialize.

	"For now use a global MyToDoList instance"
	toDoList := Smalltalk
		at: #GlobalMyToDoList
		ifAbsentPut: [ MyToDoList new ]' methodClass: #MyToDoWebApplication classified: #initialization.
				CpDemoMethodCodeContent code: 'applicationModel

	^ toDoList' methodClass: #MyToDoWebApplication classified: #accessing.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addNewToDoItemAnnouncementMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding methods to the new announcement class' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyNewToDoItem:'.
				CpDemoMethodCodeContent code: 'description: aString

	^ self basicNew
		initializeWithDescription: aString ;
		yourself' methodClass: #'MyNewToDoItem class' classified: #'instance creation'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyNewToDoItem:'.
				CpDemoMethodCodeContent code: 'initializeWithDescription: aString

	self initialize.

	description := aString' methodClass: #MyNewToDoItem classified: #initialization.
				CpDemoMethodCodeContent code: 'description

	^ description' methodClass: #MyNewToDoItem classified: #accessing.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemModelMethods2Slide [

	^ CpTitledSlide new
		title: 'Adding behaviour to the MyToDoItem (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoItem:'.
				CpDemoMethodCodeContent code: 'isDone

	^ done' methodClass: #MyToDoItem classified: #accessing.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoItem:'.
				CpDemoMethodCodeContent code: 'description: aString

	^ self basicNew
		initializeWithDescription: aString ;
		yourself' methodClass: #'MyToDoItem class' classified: #'instance creation'.
			}.
			CpTextContent text: 'The two classes now have enough behaviour for our simple example.'.
			CpTextContent text: 'Let''s move on and create Presenters and Views for these classes.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemModelMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding behaviour to the MyToDoItem' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyToDoItem:'.
				CpDemoMethodCodeContent code: 'initialize

	super initialize.

	done := false' methodClass: #MyToDoItem classified: #initialization.
				CpDemoMethodCodeContent code: 'initializeWithDescription: aString

	self initialize.

	description := aString' methodClass: #MyToDoItem classified: #initialization.
				CpDemoMethodCodeContent code: 'description

	^ description' methodClass: #MyToDoItem classified: #accessing.
				CpDemoMethodCodeContent code: 'beDone

	done := true.
	self valueChanged' methodClass: #MyToDoItem classified: #actions.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemPresenters2Slide [

	^ CpTitledSlide new
		title: 'Different Presenter/View classes per State (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoItemDoneView:'.
				CpDemoMethodCodeContent code: 'style

	<webResource: #css>

	^ ''/* Use border-box on all elements */
	*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		overflow: hidden;
	}
	#container {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		height: 100%;
	}
	/* Update look of done ''''tick'''' */
	#done {
		flex-shrink: 0;
		display: inline-block;
		border-radius: 6px;
		padding: 0;
		width: 1.4rem;
		height: 1.4rem;
		background-color: rgba(0, 105, 148, .7);
	}
	/* Limit size of description and strike through (because done) */
	#description {
		flex-grow: 1;
		margin-left: 6px;
		margin-right: 6px;
		text-decoration: line-through;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}''' methodClass: #'MyToDoItemDoneView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemPresenters3Slide [

	^ CpTitledSlide new
		title: 'Different Presenter/View classes per State (part 3)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoItemDoneView:'.
				CpDemoMethodCodeContent code: 'renderDescription: aString

	"Update the DOM, replacing all existing children (in the default slot)
	with a single new one containing the specified description"

	self replaceAllChildrenWith: aString asHtmlElement' methodClass: #MyToDoItemDoneView classified: #rendering.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoItemDonePresenter:'.
				CpDemoMethodCodeContent code: 'renderView

	| toDoItem |

	toDoItem := self model.

	self view renderDescription: toDoItem description' methodClass: #MyToDoItemDonePresenter classified: #rendering.
			}.
			CpTextContent text: 'If you watched closely you''ll see that the above two methods are present on MyToDoItemView and Presenter as well. You could consider sharing this behaviour using inheritance, but be careful using inheritance for re-use convenience only. Using Traits is also an option (since the Trait implementation currently installs methods in a Class), but not thoroughly tested.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemPresenters4Slide [

	^ CpTitledSlide new
		title: 'Different Presenter/View classes per State (part 4)' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'What remains is the need to specify which Presenter to use when.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoItem:'.
				CpDemoMethodCodeContent code: 'preferredPresenterClass

	^ done
		ifTrue: [ MyToDoItemDonePresenter ]
		ifFalse: [ MyToDoItemPresenter ]' methodClass: #MyToDoItem classified: #presenter.
			}.
			CpTextContent text: 'By default a CpModel will try to find a Presenter class with a matching name. If none is found an error is signalled. With the above method we explicitly answer the Presenter class based on the model''s state. We have now implemented both Presenters, since the Presenter for the ''done'' state does not require any specific event handling.'.
			CpTextContent text: 'Reload (the browser tab with) the to-do application for the above to take effect.'.
			CpTextContent text: 'You might see some to-do items as being ''done'', but clicking the button does not visually change anything. Only after reloading the page (again) will it show correctly. The reason is that Presenters are responsible for rendering their children. So we actually want the to-do list to re-render. This would not be necessary if we had chosen to perform DOM manipulation of the existing View. Another approach could have been to have the ''done'' button or ''tick'' be child elements, since then it would re-render automatically. A third option is to re-render the parent explicitly. See the method on the next slide.'
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemPresenters5Slide [

	^ CpTitledSlide new
		title: 'Different Presenter/View classes per State (part 5)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'The following implementation of #handleBeDone in MyToDoItemPresenter ''fixes'' the update issue:'.
				CpDemoMethodCodeContent code: 'handleBeDone

	| listPresenter toDoItem |

	listPresenter := self parent.
	toDoItem := self model.
	toDoItem beDone.

	"Since I''m no longer the preferred Presenter, update the list"
	listPresenter renderView' methodClass: #MyToDoItemPresenter classified: #'event handling'.
			}.
			CpTextContent text: 'Clicking the ''done'' button now, will immediately update the View.'.
			CpTextContent text: 'No worries, not everything is redrawn. The MVP mechanism keeps track of what actually needs updating.'.
			CpTextContent text: 'Currently you can''t undo making a to-do item ''done''. We could have chosen to have the ''done'' button be a toggle, but then you would not have learned about child presenters and rendering specifics. 😊'.
			CpTextContent text: 'Let''s add some more behaviour: removing to-do items.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemPresentersSlide [

	^ CpTitledSlide new
		title: 'Different Presenter/View classes per State' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following Presenter and View classes:'.
				CpDemoClassDefinitionCodeContent superclassName: #CpPresenter className: #MyToDoItemDonePresenter slotNames: #() packageName: 'My-ToDo-Application'.
				CpDemoClassDefinitionCodeContent superclassName: #CpView className: #MyToDoItemDoneView slotNames: #() packageName: 'My-ToDo-Application'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoItemDoneView:'.
				CpDemoMethodCodeContent code: 'template

	<webResource: #html>

	^ ''<div id="container">
		<span id="done"></span>
		<span id="description"><slot></slot></span>
	</div>''' methodClass: #'MyToDoItemDoneView class' classified: #'web resources'.
			}.
			CpTextContent text: 'Instead of a <button> we use a <span> because there is no interaction needed.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemSlide [

	^ CpTitledSlide new
		title: 'Let''s add a to-do item' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Let''s add a to-do item to have more meaningful content.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoExecutableCodeContent code: '"Add a single MyToDoItem to the global MyToDoList
(which is created when the application was run the first time)"

GlobalMyToDoList addItem: (MyToDoItem description: ''My first item'')'.
			}.
			CpTextContent text: 'And again it remains mysteriously blank on the browser page. 😕'.
			CpTextContent text: 'We need to add a render method to the MyToDoListPresenter. 💡'.
			CpTextContent text: 'Because rendering child elements is a Presenter responsibility.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Q: Why did the ToDoList get rendered by itself?'.
				CpTextContent text: 'A: It is the application model which is rendered automatically.'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemViewMethods2Slide [

	^ CpTitledSlide new
		title: 'Rendering the to-do item (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following to update/render the description:'.
				CpDemoExecutableCodeContent code: 'GlobalMyToDoList items first valueChanged.'
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoItemView:'.
				CpDemoMethodCodeContent code: 'template

	<webResource: #html>

	^ ''<div id="container">
		<button id="done"></button>
		<span id="description"><slot></slot></span>
	</div>''' methodClass: #'MyToDoItemView class' classified: #'web resources'.
			}.
			CpTextContent text: 'The browser page should update again.'.
			CpTextContent text: 'And show the description and ''done'' button.'.
			CpTextContent text: 'The slot (containing the description) is unnamed/default.'.
			CpTextContent text: 'Let''s add some actual behaviour to the View.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemViewMethodsSlide [

	^ CpTitledSlide new
		title: 'Rendering the to-do item' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoItemPresenter:'.
				CpDemoMethodCodeContent code: 'renderView

	| toDoItem |

	toDoItem := self model.

	self view renderDescription: toDoItem description' methodClass: #MyToDoItemPresenter classified: #rendering.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoItemView:'.
				CpDemoMethodCodeContent code: 'renderDescription: aString

	"Update the DOM, replacing all existing children (in the default slot)
	with a single new one containing the specified description"

	self replaceAllChildrenWith: aString asHtmlElement' methodClass: #MyToDoItemView classified: #rendering.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'It is normal to have a #renderView method in the Presenter,'.
				CpTextContent text: 'which calls a render method in the View to set individual values and texts.'.
				CpTextContent text: '''Larger'' UI elements are often rendered by one of the #render(All)ChildView<...> methods.'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoItemViewStyleSlide [

	^ CpTitledSlide new
		title: 'Styling the to-do item View (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoItemView.'.
				CpTextContent text: 'It will set styling within the component (in the shadow DOM).'.
				CpDemoMethodCodeContent code: 'style

	<webResource: #css>

	^ ''/* Use border-box on all elements */
	*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	:host {
		overflow: hidden;
	}
	#container {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		height: 100%;
	}
	/* Update look and feel of done button */
	#done {
		flex-shrink: 0;
		display: inline-block;
		border: 3px solid rgba(0, 105, 148, .7);
		border-radius: 6px;
		padding: 0;
		width: 1.4rem;
		height: 1.4rem;
		background-color: transparent;
		cursor: pointer;
	}
	/* Limit size of description */
	#description {
		flex-grow: 1;
		margin-left: 6px;
		margin-right: 6px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}''' methodClass: #'MyToDoItemView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListModelMethods2Slide [

	^ CpTitledSlide new
		title: 'Adding behaviour to the MyToDoList (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyToDoList:'.
				CpDemoMethodCodeContent code: 'addItem: aToDoItem

	items add: aToDoItem.

	"Announce the model changed"
	self valueChanged.

	^ aToDoItem' methodClass: #MyToDoList classified: #accessing.
				CpDemoMethodCodeContent code: 'removeItem: aToDoItem

	items remove: aToDoItem.

	"Announce the model changed"
	self valueChanged.

	^ aToDoItem' methodClass: #MyToDoList classified: #accessing.
			}.
			CpTextContent text: 'With this we can maintain our list of to-do items.'.
			CpTextContent text: 'Let''s add some behaviour to the to-do items.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListModelMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding behaviour to the MyToDoList' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'The to-do list is responsible for keeping track of to-do items.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyToDoList:'.
				CpDemoMethodCodeContent code: 'initialize

	super initialize.

	items := OrderedCollection new' methodClass: #MyToDoList classified: #initialization.
				CpDemoMethodCodeContent code: 'items

	^ items' methodClass: #MyToDoList classified: #accessing.
			}.
			CpTextContent text: 'A few more methods are on the next slide.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListPresenterMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding rendering behaviour to the Presenter' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoListPresenter:'.
				CpDemoMethodCodeContent code: 'renderView

	| toDoList |

	toDoList := self model.

	"Render all to-do items"
	self renderAllChildViewsForModels: toDoList items atSlotNamed: #items' methodClass: #MyToDoListPresenter classified: #rendering.
			}.
			CpTextContent text: 'Remember, child elements are positioned using slots.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Trigger an update to (re)render the list (execute the following in a Playground):'.
				CpDemoExecutableCodeContent code: 'GlobalMyToDoList valueChanged'.
			}.
			CpTextContent text: 'Using the browser''s dev tools you will see the new <my-to-do-item>.'.
			CpTextContent text: 'Let''s add the code to render the item content as well.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListViewBehaviourSlide [

	^ CpTitledSlide new
		title: 'Adding behaviour to the to-do list View' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'We start by adding behaviour to the input field.'.
			CpMultiContent withAll: {
				CpTextContent text: 'When the <Enter> key is pressed a to-do item should be created.'.
				CpTextContent text: 'Using the content of the input field.'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'The following steps are needed:'.
				CpBulletedContent withAll: {
					CpTextContent text: 'We need to add a <keypressed> event handler to the input field.'.
					CpTextContent text: 'Which announces (from View to Presenter) a new to-do item is requested.'.
					CpTextContent text: 'After which the Presenter can ask the model to create this new item.'.
				}
			}.
			CpTextContent text: 'Let''s create a new Announcement to inform the Presenter of new input.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoClassDefinitionCodeContent superclassName: #Announcement className: #MyNewToDoItem slotNames: #(#description) packageName: 'My-ToDo-Application'.
			}.
			CpTextContent text: 'The announcement holds the to-do item description (taken from the input field).'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListViewEventHandler2Slide [

	^ CpTitledSlide new
		title: 'Adding an event handler to the input field (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Finally add the following instance method to MyToDoListView:'.
				CpDemoMethodCodeContent code: 'handleNewInput

	self newInputValue
		ifNotNil: [ :value |
			self crTrace: ''New to-do item text: '', value.
			self serverAnnounce: (MyNewToDoItem description: value) ]' methodClass: #MyToDoListView classified: #'event handling'.
			}.
			CpTextContent text: 'This handler will announce (from the browser to the server) a new to-do item.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Since the WebComponent is already created we need to reload the web page,'.
				CpTextContent text: 'to activate the added behaviour (notice first time we need this!).'.
				CpTextContent text: 'Or execute the following code to explicitly perform the initialization.'.
				CpDemoExecutableCodeContent code: 'MyToDoListView allProxiesDo: #initializeShadowRoot.'.
				CpTextContent text: 'Be aware, executing the above more than once will result in adding multiple handlers. If a to-do item is added, it will then be added multiple times as a result.'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Pressing <Enter> inside the input will show the entered text in the browser''s dev console.'.
				CpTextContent text: 'The #crTrace: method can be used for some simple logging inside Views.'.
			}.
			CpTextContent text: 'Let''s handle the Announcement in the Presenter (on the server).'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListViewEventHandlerSlide [

	^ CpTitledSlide new
		title: 'Adding an event handler to the input field' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'We want to listen to the input element, which is part of the template (i.e. lives in the shadow DOM).'.
				CpTextContent text: 'We need to retrieve it using one of the #shadowed<...> methods or through #shadowRoot.'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyToDoListView:'.
				CpDemoMethodCodeContent code: 'newInputElement

	^ (self shadowedElementWithId: #''new-input'')' methodClass: #MyToDoListView classified: #accessing.
				CpDemoMethodCodeContent code: 'newInputValue

	^ self newInputElement
		ifNotNil: [ :input | input propertyAt: #value ]' methodClass: #MyToDoListView classified: #accessing.
				CpDemoMethodCodeContent code: 'initializeShadowRoot

	super initializeShadowRoot.

	"When user presses enter key (without modifiers) handle the input"
	self newInputElement
		when: CpKeyPressEvent enter only send: #handleNewInput to: self' methodClass: #MyToDoListView classified: #initialization.
			}.
			CpTextContent text: 'Event handlers for shadowed elements are typically added in #initializeShadowRoot.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListViewMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding something visible to the View' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoListView:'.
				CpDemoMethodCodeContent code: 'template

	<webResource: #html>

	^ ''<div id="container">
		<div id="header">My to-do list</div>
		<div id="items">
			<slot name="items"></slot>
		</div>
		<input id="new-input" placeholder="What needs to be done?">
	</div>''' methodClass: #'MyToDoListView class' classified: #'web resources'.
			}.
			CpTextContent text: 'This is the template HTML for the WebComponent.'.
			CpTextContent text: 'Go back to your web browser, it magically updated!'.
			CpTextContent text: 'In the upper left corner the header and input appeared.'.
			CpTextContent text: 'In the code above you see a <slot> is used to position child elements (within the DOM/render tree). Child elements (which refer to the slot name) will be visually positioned within that slot.'.
			CpTextContent text: 'Styling needs some work, but we''ll do that later.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListViewStyle2Slide [

	^ CpTitledSlide new
		title: 'Styling the to-do list View (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoListView.'.
				CpTextContent text: 'It will set styling within the component (in the shadow DOM).'.
				CpDemoMethodCodeContent code: 'style

	<webResource: #css>

	^ ''/* Use border-box on all elements */
	*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	/* Define some variables for size calculation */
	:host {
		--my-item-count: 10;
		--my-item-height: 1.5em;
	}
	/* Container is positioned mid screen */
	#container {
		display: flex;
		flex-direction: column;
		justify-content: center;
		width: 20em;
		max-width: 90%;
		margin-left: auto;
		margin-right: auto;
		height: 100%;
	}
	#header {
		font-size: 1.2em;
		font-weight: bold;
		text-align: center;
		color: rgb(0, 105, 148);
	}
	/* Only show a limited number of items */
	#items {
		margin: 10px 0;
		max-height: calc(var(--my-item-count) * var(--my-item-height));
		overflow-y: scroll;
		scroll-behavior: smooth;
	}
	/* Therefore fixed height items are needed */
	::slotted([slot="items"]) {
		display: block;
		height: var(--my-item-height);
	}
	::slotted([slot="items"]:hover) {
		background-color: rgba(0, 105, 148, .1);
	}
	#new-input {
		border: 3px solid rgba(0, 105, 148, .7);
		border-radius: 6px;
		padding: 4px 8px;
		font-size: 1em;
	}''' methodClass: #'MyToDoListView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> addToDoListViewStyleSlide [

	^ CpTitledSlide new
		title: 'Styling the to-do list View' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyToDoListView.'.
				CpTextContent text: 'It will set some styling on the global level (in the light DOM).'.
				CpDemoMethodCodeContent code: 'globalStyle

	<webResource: #css>

	^ ''/* Use full screen */
	html {
		height: 100%;
	}
	body {
		font-family: Tahoma, Geneva, sans-serif;
		font-size: 1.4em;
		height: 100%;
		margin: 0;
		padding: 0;
	}''' methodClass: #'MyToDoListView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> createApplicationSlide [

	^ CpTitledSlide new
		title: 'Creating the Application class' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'We are creating an MVP-based application.'.
			CpTextContent text: 'So we are subclassing CpMvpWebApplication.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoClassDefinitionCodeContent superclassName: #CpMvpWebApplication className: #MyToDoWebApplication slotNames: #(#toDoList) packageName: 'My-ToDo-Application'.
			}.
			CpTextContent text: 'The application needs an identifier.'.
			CpTextContent text: 'And the ''root'' model for the application (the instVar ''toDoList'').'.
			CpTextContent text: 'Let''s add and initialize them using the code on the following slide.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> createModelSlide [

	^ CpTitledSlide new
		title: 'Creating our to-do list Model' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Our simple model requires just 2 classes: MyToDoList and MyToDoItem.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoClassDefinitionCodeContent superclassName: #CpModel className: #MyToDoList slotNames: #(#items) packageName: 'My-ToDo-Application'.
				CpDemoClassDefinitionCodeContent superclassName: #CpModel className: #MyToDoItem slotNames: #(#description #done) packageName: 'My-ToDo-Application'.
			}.
			CpTextContent text: 'We''ll add some behaviour on the following slides.'.
		}) ;
		yourself
]

{ #category : #model }
CpMyFirstAppPresentationWebApplication >> createPresentationModel [

	"Create and answer the PresentationModel for the presentation"

	^ (CpPresentation titled: 'My First Application')
		beDeckBased ;
		addSlide: self introductionSlide ;
		addSlide: self explanationSlide ;
		addSlide: self createModelSlide ;
		addSlide: self addToDoListModelMethodsSlide ;
		addSlide: self addToDoListModelMethods2Slide ;
		addSlide: self addToDoItemModelMethodsSlide ;
		addSlide: self addToDoItemModelMethods2Slide ;
		addSlide: self createPresentersSlide ;
		addSlide: self createViewsSlide ;
		addSlide: self createApplicationSlide ;
		addSlide: self addApplicationMethodsSlide ;
		addSlide: self startApplicationSlide ;
		addSlide: self addToDoListViewMethodsSlide ;
		addSlide: self addToDoItemSlide ;
		addSlide: self addToDoListPresenterMethodsSlide ;
		addSlide: self addToDoItemViewMethodsSlide ;
		addSlide: self addToDoItemViewMethods2Slide ;
		addSlide: self addToDoListViewBehaviourSlide ;
		addSlide: self addNewToDoItemAnnouncementMethodsSlide ;
		addSlide: self addToDoListViewEventHandlerSlide ;
		addSlide: self addToDoListViewEventHandler2Slide ;
		addSlide: self updateToDoListPresenterMethodsSlide ;
		addSlide: self updateToDoListPresenterMethods2Slide ;
		addSlide: self updateToDoListPresenterMethods3Slide ;
		addSlide: self addToDoListViewStyleSlide ;
		addSlide: self addToDoListViewStyle2Slide ;
		addSlide: self addToDoItemViewStyleSlide ;
		addSlide: self updateToDoItemViewMethodsSlide ;
		addSlide: self updateToDoItemViewMethods2Slide ;
		addSlide: self updateToDoItemViewMethods3Slide ;
		addSlide: self updateToDoItemViewMethods4Slide ;
		addSlide: self addToDoItemPresentersSlide ;
		addSlide: self addToDoItemPresenters2Slide ;
		addSlide: self addToDoItemPresenters3Slide ;
		addSlide: self addToDoItemPresenters4Slide ;
		addSlide: self addToDoItemPresenters5Slide ;
		addSlide: self updateToDoListPresenterMoreMethodsSlide ;
		addSlide: self updateToDoListPresenterMoreMethods2Slide ;
		addSlide: self updateToDoListPresenterMoreMethods3Slide ;
		addSlide: self updateToDoListPresenterMoreMethods4Slide ;
		addSlide: self updateToDoListPresenterMoreMethods5Slide ;
		addSlide: self updateToDoListPresenterMoreMethods6Slide ;
		addSlide: self updateToDoListPresenterMoreMethods7Slide ;
		addSlide: self updateToDoListModelSlide ;
		addSlide: self updateToDoListModel2Slide ;
		addSlide: self updateToDoListModel3Slide ;
		addSlide: self updateToDoListModel4Slide ;
		addSlide: self updateToDoListModel5Slide ;
		addSlide: self updateToDoListModel6Slide ;
		addSlide: self updateToDoListModel7Slide ;
		addSlide: self finalSlide ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> createPresentersSlide [

	^ CpTitledSlide new
		title: 'Creating the Presenter classes' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'We need a Presenter for MyToDoItem and for MyToDoList.'.
			CpTextContent text: 'By using matching names as the Models they are ''recognised'' as default presenter.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoClassDefinitionCodeContent superclassName: #CpPresenter className: #MyToDoItemPresenter slotNames: #() packageName: 'My-ToDo-Application'.
				CpDemoClassDefinitionCodeContent superclassName: #CpPresenter className: #MyToDoListPresenter slotNames: #() packageName: 'My-ToDo-Application'.
			}.
			CpTextContent text: 'We simply start with the default implementation and add behaviour later.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> createViewsSlide [

	^ CpTitledSlide new
		title: 'Creating the View classes' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'We need a View for MyToDoItem and for MyToDoList.'.
			CpTextContent text: 'By using matching names as the Presenters they are ''recognised'' as default view.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoClassDefinitionCodeContent superclassName: #CpView className: #MyToDoItemView slotNames: #() packageName: 'My-ToDo-Application'.
				CpDemoClassDefinitionCodeContent superclassName: #CpView className: #MyToDoListView slotNames: #() packageName: 'My-ToDo-Application'.
			}.
			CpTextContent text: 'These View classes are WebComponents.'.
			CpMultiContent withAll: {
				CpTextContent text: 'All methods added will execute inside the browser'.
				CpTextContent text: '(no need for JavaScript anymore 🥳).'.
			}.
			CpTextContent text: 'Now it is time for the Application itself. 🚀'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> explanationSlide [

	^ CpTitledSlide new
		title: 'Tutorial presentation: building our first app' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: '🚀 Let''s create our first web application! 🚀'.
			CpTextContent text: 'Step-by-step we''ll create a very simple to-do app.'.
			CpTextContent text: 'We use the Model View Presenter (MVP) pattern of CodeParadise.'.
			CpTextContent text: 'It would help if you know HTML and CSS.'.
			CpTextContent text: 'And have some understanding of templates within WebComponents.'.
			CpTextContent text: 'But all code is given, so you can also just follow along.'.
			CpTextContent text: 'Whenever source code is shown, hover it for copy-to-clipboard.'.
			CpTextContent text: 'Read carefully where methods should be added (class/instance side).'.
			CpTextContent text: 'Or simply execute it using the action shown when hovering code.'.
			CpTextContent text: 'What are you waiting for, let''s get going!'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> finalSlide [

	^ CpTitledSlide new
		title: 'The End' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'This is the end of this tutorial presentation.'.
			CpTextContent text: 'We created our first web application! Hope you like it.'.
			CpTextContent text: 'By showing each step you hopefully learned how this can be done and seen a few of the choices you''ll have to make.'.
			CpTextContent text: 'The CodeParadise framework offers the ability to create MVP-based web applications in which a lot of the update and rendering is taken care of automagically 🪄. Use these powers wisely and if unsure about how to use it (how to approach an issue), feel free to reach out.'.
			CpTextContent text: 'Maybe you have not looked at the actual code (besides what is shown during this presentation). Please do take a little time to look around the classes and methods we created during this tutorial.'.
			CpTextContent text: 'Please feel invited to try and add or change some features or start a new app as well!'.
			CpTextContent text: 'And please share your work with others. 🙏'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> introductionSlide [

	^ CpFullPageSlide new
		content: (CpImageContent new
			url: '/static/resources/presentation-opening-slide.svg' ;
			width: '100%' ;
			yourself) ;
		yourself
]

{ #category : #actions }
CpMyFirstAppPresentationWebApplication >> openInspector [

	"Open an Inspector on the receiver and answer it"

	^ self inspector
]

{ #category : #actions }
CpMyFirstAppPresentationWebApplication >> showNextSlide [

	self presentation nextSlide
]

{ #category : #actions }
CpMyFirstAppPresentationWebApplication >> showPreviousSlide [

	self presentation previousSlide
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> startApplicationSlide [

	^ CpTitledSlide new
		title: 'Let''s start our application' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'We first need to register the application.'.
				CpTextContent text: 'Execute the following in a Playground:'.
				CpDemoExecutableCodeContent code: 'MyToDoWebApplication register.'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'We can now start it by opening a web browser.'.
				CpBulletedContent withAll: {
					CpMultiContent withAll: {
						CpTextContent text: 'Execute the following in a Playground:'.
						CpDemoExecutableCodeContent code: 'MyToDoWebApplication openInBrowser.'.
					}.
					CpHtmlContent html: 'Or open a browser on <a href="http://localhost:8080/static/app.html?my-to-do-app" target="_blank">http://localhost:8080/static/app.html?my-to-do-app</a>.'.
					CpTextContent text: 'Or select ''my-to-do-app'' from the Pharo menu: Paradise | Open...'.
				}.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'And a perfectly blank page is visible. 🤔'.
				CpTextContent text: 'AND...if you open up the web browser''s dev tools. 💡'.
				CpTextContent text: 'You should see a DOM element <my-to-do-list>.'.
				CpTextContent text: 'With some funny looking identifier (so just ignore it).'.
			}.
			CpTextContent text: 'Leave the web browser open for now.'.
			CpTextContent text: 'If it is closed, just reopen a new one using the above.'.
			CpTextContent text: 'In the following slides we''ll update the visuals.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoItemViewMethods2Slide [

	^ CpTitledSlide new
		title: 'Make the ''done'' button work' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyToDoItemView:'.
				CpDemoMethodCodeContent code: 'initializeShadowRoot

	super initializeShadowRoot.

	"When user clicks on the button (without modifiers) handle the input"
	(self shadowedElementWithId: #done)
		when: CpClickEvent primary only send: #handleDoneClicked to: self' methodClass: #MyToDoItemView classified: #initialization.
				CpDemoMethodCodeContent code: 'handleDoneClicked

	self serverAnnounce: (CpActionRequested id: #done)' methodClass: #MyToDoItemView classified: #'event handling'.
			}.
			CpTextContent text: 'The CpActionRequested is a support class to prevent having to create many Announcement classes. The MyNewToDoItem could have used the same class (with a parameter for the description).'.
			CpTextContent text: 'In your own apps, please choose the approach you like best.'.
			CpTextContent text: 'Reload the app to let the above take effect.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Or execute the following code to explicitly perform the initialization (once!).'.
				CpDemoExecutableCodeContent code: 'MyToDoItemView allProxiesDo: #initializeShadowRoot.'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoItemViewMethods3Slide [

	^ CpTitledSlide new
		title: 'Make the ''done'' button work (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyToDoItemPresenter:'.
				CpDemoMethodCodeContent code: 'viewCreated

	super viewCreated.

	self view
		when: (CpActionRequested id: #done) send: #handleBeDone to: self' methodClass: #MyToDoItemPresenter classified: #view.
				CpDemoMethodCodeContent code: 'handleBeDone

	| toDoItem |

	toDoItem := self model.
	toDoItem beDone' methodClass: #MyToDoItemPresenter classified: #'event handling'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Since the Presenter and View are already created, this subscription will not be added automatically.'.
				CpHtmlContent html: '<span>You have to start a new session (close the to-do-app tab and <a href="http://localhost:8080/static/app.html?my-to-do-app" target="_blank">open new one</a>) for this to work.</span>'.
				CpTextContent text: 'Or execute the following code (once!) the perform the setup explicitly.'.
				CpDemoExecutableCodeContent code: 'MyToDoItemPresenter allInstancesDo: #viewCreated.'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoItemViewMethods4Slide [

	^ CpTitledSlide new
		title: 'Make the ''done'' button work (part 3)' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'We also need to update the view to show the difference between to-do and done.'.
			CpMultiContent withAll: {
				CpTextContent text: 'This can be done in two ways:'.
				CpBulletedContent withAll: {
					CpTextContent text: 'Have different Presenter/View classes per state.'.
					CpTextContent text: 'Manipulate the DOM from the View class (through Presenter).'.
				}.
			}.
			CpTextContent text: 'And of course a combination can be used.'.
			CpTextContent text: 'Deciding which to choose depends typically on how different behaviour is between states (using DOM manipulation for little or no difference). But personal preference might be deciding as well.'.
			CpTextContent text: 'On the next slides we are implementing a different Presenter and View combo for the ''done'' state of the to-do item.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoItemViewMethodsSlide [

	^ CpTitledSlide new
		title: 'Add a little behaviour to the to-do list View' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'The list looks a lot better, but adding an item might be outside of the scrolling region (i.e. be invisible). Let''s add a little behaviour to always scroll to the bottom position.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following instance method of MyToDoListView:'.
				CpDemoMethodCodeContent code: 'updateAfterAddItem

	self newInputElement
		ifNotNil: [ :input | input propertyAt: #value put: '''' ].

	"Scroll to last item"
	(self shadowedElementWithId: #items) propertyAt: #scrollTop put: 9999' methodClass: #MyToDoListView classified: #updating.
			}.
			CpTextContent text: 'On the following slides we are going to add behaviour to the to-do item view.'.
			CpTextContent text: 'To make the ''done'' button work.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModel2Slide [

	^ CpTitledSlide new
		title: 'Don''t do too much (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following instance method in MyToDoList:'.
				CpDemoMethodCodeContent code: 'addItem: aToDoItem

	self isFull ifTrue: [ ^ aToDoItem ].

	items add: aToDoItem.

	"Announce the model changed"
	self valueChanged.

	"Keep track of item state"
	aToDoItem whenChangedSend: #itemChanged to: self.

	^ aToDoItem' methodClass: #MyToDoList classified: #accessing.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Since existing items have not been subscribed to, execute the following (once!):'.
				CpDemoExecutableCodeContent code: 'GlobalMyToDoList items do: [ :each |
	each whenChangedSend: #itemChanged to: GlobalMyToDoList ]'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModel3Slide [

	^ CpTitledSlide new
		title: 'Don''t do too much (part 3)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following instance method in MyToDoList:'.
				CpDemoMethodCodeContent code: 'removeItem: aToDoItem

	items remove: aToDoItem.

	"Announce the model changed"
	self valueChanged.

	"Stop keeping track of item"
	aToDoItem unsubscribe: self.

	^ aToDoItem' methodClass: #MyToDoList classified: #accessing.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModel4Slide [

	^ CpTitledSlide new
		title: 'Don''t do too much (part 4)' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'When the item change is announced, simply announce the receiver (the to-do list) has changed. This will update the View and will result in a View in which no more to-do items can be entered.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method in MyToDoList:'.
				CpDemoMethodCodeContent code: 'itemChanged

	"An item of the receiver changed,
	notify interested parties the receiver changed"

	self valueChanged' methodClass: #MyToDoList classified: #'event handling'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following instance method in MyToDoItemPresenter (it does not need the old fix anymore):'.
				CpDemoMethodCodeContent code: 'handleBeDone

	| toDoItem |

	toDoItem := self model.
	toDoItem beDone' methodClass: #MyToDoItemPresenter classified: #'event handling'.
			}.
			CpTextContent text: 'Let''s add behaviour to the to-do list View to prevent adding even more.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModel5Slide [

	^ CpTitledSlide new
		title: 'Don''t do too much (part 5)' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'This time the ''isFull'' state will be made visual through DOM manipulation. We''ll disable the input field if the to-do list is already full.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method in MyToDoListView:'.
				CpDemoMethodCodeContent code: 'renderIsFull: aBoolean

	"Add or remove attribute #disabled and update the input placeholder"

	| disabledValue placeholderValue |

	disabledValue := aBoolean ifTrue: [ '''' ] ifFalse: [ nil ].
	placeholderValue := aBoolean
		ifTrue: [ ''The to-do list is full!'' ]
		ifFalse: [ ''What needs to be done?'' ].

	(self shadowedElementWithId: ''new-input'')
		attributeAt: #disabled put: disabledValue ;
		attributeAt: #placeholder put: placeholderValue' methodClass: #MyToDoListView classified: #rendering.
			}.
			CpTextContent text: 'Let''s update the styling as well to make it more obvious there is too much to do.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModel6Slide [

	^ CpTitledSlide new
		title: 'Don''t do too much (part 6)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following class method in MyToDoListView.'.
				CpTextContent text: 'It will set styling within the component (in the shadow DOM).'.
				CpDemoMethodCodeContent code: 'style

	<webResource: #css>

	^ ''/* Use border-box on all elements */
	*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	/* Define some variables for size calculation */
	:host {
		--my-item-count: 10;
		--my-item-height: 1.5em;
	}
	/* Container is positioned mid screen */
	#container {
		display: flex;
		flex-direction: column;
		justify-content: center;
		width: 20em;
		max-width: 90%;
		margin-left: auto;
		margin-right: auto;
		height: 100%;
	}
	#header {
		font-size: 1.2em;
		font-weight: bold;
		text-align: center;
		color: rgb(0, 105, 148);
	}
	/* Only show a limited number of items */
	#items {
		margin: 10px 0;
		max-height: calc(var(--my-item-count) * var(--my-item-height));
		overflow-y: scroll;
		scroll-behavior: smooth;
	}
	/* Therefore fixed height items are needed */
	::slotted([slot="items"]) {
		display: block;
		height: var(--my-item-height);
	}
	::slotted([slot="items"]:hover) {
		background-color: rgba(0, 105, 148, .1);
	}
	#new-input {
		border: 3px solid rgba(0, 105, 148, .7);
		border-radius: 6px;
		padding: 4px 8px;
		font-size: 1em;
	}
	#new-input[disabled] {
		border-color: rgba(255, 0, 0, .4);
		background-color: rgba(255, 0, 0, .4);
		cursor: not-allowed;
	}
	#new-input[disabled]::placeholder {
		color: white;
	}''' methodClass: #'MyToDoListView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModel7Slide [

	^ CpTitledSlide new
		title: 'Don''t do too much (part 7)' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Finally update the Presenter to render the new status.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following instance method in MyToDoListPresenter:'.
				CpDemoMethodCodeContent code: 'renderView

	| toDoList |

	toDoList := self model.

	self
		renderAllChildViewsForModels: toDoList items
		usingPresenter: [ :model | MyRemovableToDoItemPresenter ]
		atSlotNamed: #items.

	self view renderIsFull: toDoList isFull' methodClass: #MyToDoListPresenter classified: #rendering.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Execute the following code to update the view (or simply reload the to-do app browser tab).'.
				CpDemoExecutableCodeContent code: 'GlobalMyToDoList valueChanged'.
			}.
			CpTextContent text: 'So we now can limit the amount of to-do items! 🙏'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListModelSlide [

	^ CpTitledSlide new
		title: 'Don''t do too much' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Let''s update our model to prevent too many open to-do items.'.
			CpTextContent text: 'For updating the View we''ll be using DOM manipulation this time.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods in MyToDoList:'.
				CpDemoMethodCodeContent code: 'notDoneCount

	"Answer amount of to-do items which are not done yet"

	^ items count: [ :each | each isDone not ]' methodClass: #MyToDoList classified: #accessing.
				CpDemoMethodCodeContent code: 'isFull

	"Answer whether the list contains (more than) enough (open) to-do items"

	^ self notDoneCount >= 5' methodClass: #MyToDoList classified: #accessing.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMethods2Slide [

	^ CpTitledSlide new
		title: 'Update the Presenter for event handling (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoListPresenter:'.
				CpDemoMethodCodeContent code: 'handleNewToDoItem: aNewToDoItem

	aNewToDoItem description
		ifNotEmpty: [ :description |
			| toDoList |

			toDoList := self model.
			toDoList addItem: (MyToDoItem description: description) ]' methodClass: #MyToDoListPresenter classified: #'event handling'.
			}.
			CpTextContent text: 'The to-do list will announce it has changed and the display will update automagically.'.
			CpTextContent text: 'So start a new session and add a to-do item! Or two or three...still a lot to do. 😉'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMethods3Slide [

	^ CpTitledSlide new
		title: 'Update the Presenter for event handling (part 3)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'It''s a bit weird that the input text remains after the to-do item is added.'.
				CpTextContent text: 'We can remove the input text by updating the handler in MyToDoListPresenter as below:'.
				CpDemoMethodCodeContent code: 'handleNewToDoItem: aNewToDoItem

	aNewToDoItem description
		ifNotEmpty: [ :description |
			| toDoList |

			toDoList := self model.
			toDoList addItem: (MyToDoItem description: description).
			
			self view updateAfterAddItem ]' methodClass: #MyToDoListPresenter classified: #'event handling'.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'And add the following instance method to the MyToDoListView:'.
				CpDemoMethodCodeContent code: 'updateAfterAddItem

	self newInputElement
		ifNotNil: [ :input | input propertyAt: #value put: '''' ]' methodClass: #MyToDoListView classified: #accessing.
		}.
		CpTextContent text: 'That looks a lot better! Now let''s add some styling.'.
	}) ;
	yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMethodsSlide [

	^ CpTitledSlide new
		title: 'Update the Presenter for event handling' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Since MyToDoListView is announcing, the MyToDoListPresenter should be listening.'.
			CpTextContent text: 'It''s best to start listening as soon as the view is created (use #viewCreated hook).'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoListPresenter:'.
				CpDemoMethodCodeContent code: 'viewCreated

	super viewCreated.

	self view
		when: MyNewToDoItem send: #handleNewToDoItem: to: self' methodClass: #MyToDoListPresenter classified: #view.
			}.
			CpMultiContent withAll: {
				CpTextContent text: 'Since the Presenter and View are already created, this subscription will not be added automatically.'.
				CpHtmlContent html: '<span>You have to start a new session (close the to-do-app tab and <a href="http://localhost:8080/static/app.html?my-to-do-app" target="_blank">open new one</a>) for this to work.</span>'.
				CpTextContent text: 'Or execute the following code the perform the setup explicitly.'.
				CpDemoExecutableCodeContent code: 'MyToDoListPresenter allInstancesDo: #viewCreated.'.
				CpTextContent text: 'Be aware, executing the above more than once will result in adding multiple handlers. If a to-do item is added, it will then be added multiple times as a result.'.
			}.
			CpTextContent text: 'Before you do, let''s first add the actual handler on the next slide.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethods2Slide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list (part 2)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyRemovableToDoItemPresenter:'.
				CpDemoMethodCodeContent code: 'viewCreated

	super viewCreated.

	self view
		when: (CpActionRequested id: #remove) send: #handleRemove to: self' methodClass: #MyRemovableToDoItemPresenter classified: #view.
				CpDemoMethodCodeContent code: 'handleRemove

	| toDoItem |

	toDoItem := self model.
	self parent handleRemoveToDoItem: toDoItem' methodClass: #MyRemovableToDoItemPresenter classified: #'event handling'.
			}.
			CpTextContent text: 'Since the to-do list is responsible for removing items, we''re delegating the handling to the parent Presenter. Some shared knowledge is required. Alternatively a to-do item might be told in which list it lives so it can inform the list itself (which will then update itself). Or the to-do item might announce its own removal, which the to-do list can listen to. Multiple solutions are possible. Pick one that feelds good for your model/solution.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethods3Slide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list (part 3)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyRemovableToDoItemPresenter:'.
				CpDemoMethodCodeContent code: 'renderView

	self renderChildViewForModel: self model' methodClass: #MyRemovableToDoItemPresenter classified: #rendering.

			}.
			CpMultiContent withAll: {
				CpTextContent text: 'This renders a child View using its own model (thereby visually decorating the View). Since no explicit Presenter is specified, it will use the model''s preferred Presenter class (which we implemented to be based on the to-do item state). On the following slides we will see an example where the Presenter is set explicitly.'.
				CpHtmlContent html: '&nbsp;'.
			}.
			CpTextContent text: 'In general: a Presenter is responsible to decide how to render children in its #renderView method. This allows context specific rendering. If there is no need for such context specific rendering, the Presenter can ask the model for its preferred Presenter. This later is the default implementation for the methods #renderChildViewForModel:(atSlotNamed:) and #renderAllChildViewsForModels:(atSlotNamed:).'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethods4Slide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list (part 4)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance method to MyToDoListPresenter:'.
				CpDemoMethodCodeContent code: 'handleRemoveToDoItem: aToDoItem

	| toDoList |

	toDoList := self model.
	toDoList removeItem: aToDoItem' methodClass: #MyToDoListPresenter classified: #'event handling'.
			}.
			CpTextContent text: 'The MyRemovableToDoItemPresenter is ready, let''s add the View.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyRemovableToDoItemView:'.
				CpDemoMethodCodeContent code: 'template

	<webResource: #html>

	^ ''<div id="container">
		<slot></slot><button id="remove">❌</button>
	</div>''' methodClass: #'MyRemovableToDoItemView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethods5Slide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list (part 5)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following class method to MyRemovableToDoItemView.'.
				CpTextContent text: 'It will set styling within the component (in the shadow DOM).'.
				CpDemoMethodCodeContent code: 'style

	<webResource: #css>

	^ ''/* Use border-box on all elements */
	*, *:before, *:after {
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		box-sizing: border-box;
	}
	#container {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		height: 100%;
	}
	/* Update look and feel of remove button */
	#remove {
		flex-shrink: 0;
		display: inline-block;
		border: none;
		padding: 0;
		width: 1.4rem;
		height: 1.4rem;
		background-color: transparent;
		cursor: pointer;
	}''' methodClass: #'MyRemovableToDoItemView class' classified: #'web resources'.
			}.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethods6Slide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list (part 6)' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Let''s hook up the event handler for the ''remove'' button.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Add the following instance methods to MyRemovableToDoItemView:'.
				CpDemoMethodCodeContent code: 'initializeShadowRoot

	super initializeShadowRoot.

	(self shadowedElementWithId: ''remove'')
		when: CpClickEvent primary only send: #handleRemove to: self' methodClass: #MyRemovableToDoItemView classified: #initialization.
				CpDemoMethodCodeContent code: 'handleRemove

	self serverAnnounce: (CpActionRequested id: #remove)' methodClass: #MyRemovableToDoItemView classified: #'event handling'.
			}.
			CpTextContent text: 'There is no render method, since only a child element is rendered (from the Presenter) and no specific fields or texts (i.e. smaller UI elements) need rendering here.'.
			CpTextContent text: 'Let''s install this new Presenter and View combo into our application.'
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethods7Slide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list (part 7)' ;
		content: (CpBulletedContent withAll: {
			CpMultiContent withAll: {
				CpTextContent text: 'Update the following instance method in MyToDoListPresenter:'.
				CpDemoMethodCodeContent code: 'renderView

	| toDoList |

	toDoList := self model.

	self
		renderAllChildViewsForModels: toDoList items
		usingPresenter: [ :model | MyRemovableToDoItemPresenter ]
		atSlotNamed: #items' methodClass: #MyToDoListPresenter classified: #rendering.
			}.
			CpTextContent text: 'This implementation explicitly specifies the Presenter class to be used for rendering children.'.
			CpTextContent text: 'Instead of the Block a direct reference to the MyRemovableToDoItemPresenter class could have been used as well. (For the record: The argument ''model'' is optional as well.)'.
			CpTextContent text: 'This variant allows the model to be asked for a preferred Presenter. This can be very useful to ask for context specific Presenters (like sending #preferredTableCellPresenterClass or #preferredOverviewPresenterClass).'.
			CpTextContent text: 'Reload the browser tab of the to-do app for this change to take effect.'.
		}) ;
		yourself
]

{ #category : #slides }
CpMyFirstAppPresentationWebApplication >> updateToDoListPresenterMoreMethodsSlide [

	^ CpTitledSlide new
		title: 'Adding remove behaviour to to-do list' ;
		content: (CpBulletedContent withAll: {
			CpTextContent text: 'Removing a to-do item is behaviour of MyToDoList, but requires us to know which item we want to remove. One solution to achieve this is to have a ''remove'' button displayed after each to-do item. We ''decorate'' the to-do item View with a ''remove'' button.'.
			CpMultiContent withAll: {
				CpTextContent text: 'Create the following Presenter and View:'.
				CpDemoClassDefinitionCodeContent superclassName: #CpPresenter className: #MyRemovableToDoItemPresenter slotNames: #() packageName: 'My-ToDo-Application'.
				CpDemoClassDefinitionCodeContent superclassName: #CpView className: #MyRemovableToDoItemView slotNames: #() packageName: 'My-ToDo-Application'.
			}.
			CpTextContent text: 'On the following slides we''ll be adding the looks and feel.'.
		}) ;
		yourself
]
