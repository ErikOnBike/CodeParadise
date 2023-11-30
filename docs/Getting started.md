# Getting started
This document will describe how to get started on building your own webapplication. This description is for an [MVP](MVP.md)-based application, since this offers a rich environment to build your application in. For an explanation how an application 'works', please read the [implementation](Implementation.md) document first.

## Creating an application
As described in the [implementation](Implementation.md) document an application is described by a subclass of `CpWebApplication`. For MVP-based applications, we subclass from `CpMvpWebApplication`. For the examples here, we'll call this subclass `MyWebApplication`. An instance of an application class represents an application session. So session information is normally stored in the instance variables of your application. Furthermore, we need to implement a couple of methods to setup the application. These methods include:

* `MyWebApplication class >> #app`

    This class method should answer a Symbol representing the identifier of the application. This should be a unique value (amongst applications) to allow different applications to be hosted from the same environment. It will be part of the URL we use to access the application. Assuming you are running it from the Pharo environment and the identifier chose is #myapp, the default URL will be: `http://localhost:8080/static/app.html?myapp`.

* `MyWebApplication >> #applicationModel`

    This instance method should answer a model (see [MVP](MVP.md)) which acts as your 'root' model or entry point for the application. You can also use the application itself, since it already has an announcer you will only need to announce `ValueChanged` if this top level element needs updating (do not worry about updating children, they can take care of themselves).

* `MyWebApplication >> #applicationPresenterClass`

    This instance method should answer the presenter class (subclass of `CpPresenter`) which is responsible for updating the view and model based on model changes and view announcements/events. More on this below.

Some example applications with their implementation:

* Zettelkasten [source on GitHub](https://github.com/ErikOnBike/CodeParadise-Zettelkasten/blob/main/repository/CodeParadise-Zettelkasten/ZkZettelkastenApplication.class.st)
* BlogBuilder [source on GitHub](https://github.com/ErikOnBike/CodeParadise-BlogBuilder/blob/main/repository/CodeParadise-BlogBuilder/BbBlogBuilderApplication.class.st)
* Presentation [source on GitHub](https://github.com/ErikOnBike/CodeParadise/blob/master/repository/CodeParadise-WebApplication-Presentation/CpPresentationWebApplication.class.st)

## The application model
Deciding on the model to use for the application might at first be a bit tricky. Some examples:

* For a board game, the model could consist of a number of players and the board itself. The application presenter (and view), could render the surface (to place the board on) and allow users to be added to the game. Remember that the board is itself a model responsible for being rendered, so the application presenter should only render the surface. The application presenter will delegate the board rendering to the board.
* For a drawing application with an SDI (Single Document Interface), the model could contain a drawing model. The application presenter will render all the tools available. It will delegate rendering of the drawing to the drawing model. To keep track of toolboxes which can be opened and closed and moved around, the state and position of these toolboxes might need to become part of the application model.
* For a drawing application with a MDI (Multiple Document Interface), the model could contain a collection of drawings (empty at first or a blanc drawing to start with). The application presenter could show a menu which allows the user to create a new drawing, which would then be added to the application model. And (like SDI variant) it could keep track of the status of the different tools.
* For any application which requires a user to login, the model could include the user. When no user is logged in yet, the application model will render as a login page. Once logged in (and the user being set in the application model) it will render the application 'content' for that specific user.

## The application presenter and view
All applications are rendered as a tree (components with subcomponents), since browser pages are (DOM) trees. The application presenter and view are the root of the rendering tree which make up the (visual) application. All other models will render inside the application (either directly or indirectly as part of another descendant of the application presenter/view). Apart from being the root of the rendering tree, the application presenter and view are not special.

Being the root of the rendering tree, means the application view will be the child of the HTML `<body>` tag. For advanced users, there are ways to add more children to the `<body>` tag to allow for example additional tooling to be present. These (other roots) might have to be rendered explicitly in some situations like during a browser page reload.

## Presenters and views
The presenter is responsible for rendering the view, handling view announcements/events and updating the model based on these announcements. The presenter is a server side object which acts as an intermediate between model and view. A view is the actual UI and is in fact a [WebComponent](https://developer.mozilla.org/en-US/docs/Web/Web_Components) running in the browser. WebComponents can have `slots` in which other WebComponents can be rendered (creating the tree structure). A slot can contain multiple WebComponents. Beside a single unnamed default slot, all slots have a name. Since the view is running inside the browser, where only a limited Smalltalk image is present, the view should and can only contain UI logic. (Do not try to move your business logic into the view. There is not even a Date class present in the browser image.)

### Rendering the view
A view is rendered from the presenter. The presenter has to implement an instance method `#renderView` in which the rendering takes place. This method will be invoked (automagically as part of the framework) when a model announces a change, but also when a child presenter is created. This latter is normally done from within the `#renderView` method.

Every presenter knows its model (through method `#model`) and view (through method `#view`). It also knows its application (through method `#application`) to allow access to the session information. The parent and child presenters can also be accessed, but this is often not necessary.

Below is an example from the `CpPresentationPresenter` class which is the application presenter for a presentation. It will render the current slide, a slide carousel (which is shown floating on top of the slide) and the title (which becomes part of the browser's tab):

```Smalltalk
renderView

    "Render the current slide"
	self renderChildViewForModel: self currentSlideModel atSlotNamed: 'slides'.

	"Only render the carousel if it is present"
	self slidesCarouselPresenter
		ifNotNil: [ :slidesCarouselPresenter | slidesCarouselPresenter renderView ].

	self view renderTitle: self model title
```

Calling `#renderChildViewForModel:atSlotNamed:` will result in the model being asked for its preferred presenter which in turn renders the model at the given location (slot) within the parent. Subsequent invocations of this method will check whether a presenter/view pair is already present and update the visuals accordingly. This can result in (part of) the DOM tree being recreated and other parts only receiving minor value/property updates.

A number of rendering methods exist. These are the main methods to use during rendering when subcomponents are needed.

* `#renderAllChildViewsForModels:`

    renders a collection of views for the specified model in the default (unnaned) slot  (i.e. multiple view inside a single slot)

* `#renderAllChildViewsForModels:atSlotNamed:`

    renders a collection of views for the specified model in the specified slot

* `#renderAllChildViewsForModels:usingPresenter:`
 
    renders a collection of views for the specified model using the explicitly defined presenters in the default (unnamed) slot (i.e. the models are not asked for their preferred presenter)

* `#renderAllChildViewsForModels:usingPresenter:atSlotNamed:`

    renders a collection of views for the specified model using the explicitly defined presenters in the specified slot (i.e. the models are not asked for their preferred presenter)
* `#renderChildViewForModel:`

    renders a view for the specified model in the default (unnamed) slot (i.e. single view inside a single slot)

* `#renderChildViewForModel:atSlotNamed:`

    renders a view for the specified model in the specified slot

* `#renderChildViewForModel:usingPresenter:`

    renders a view for the specified model using the explicitly defined presenter in the default (unnamed) slot (i.e. the model is not asked for a preferred presenter)

* `#renderChildViewForModel:usingPresenter:atSlotNamed`

    renders a view for the specified model using the explicitly defined presenter in the specified slot (i.e. the model is not asked for a preferred presenter)

When using a variant with `#usingPresenter:` either a presenter class or a block can be provided as argument. When a block is provided it will receive the model as (optional) first argument. This allows the model to be asked for a specific kind of presenter. For example from withing some overview presenter we could ask children to be rendered as item (instead of some full blown component) by using:

```Smalltalk
renderView

    "Render all employees as cards/items"
	self
        renderChildViewForModel: self model employees
        usingPresenter: [ :each | each preferredItemPresenterClass ]
        atSlotNamed: 'items'
```

The view itself (instead of the children mentioned above) might need to change. This can be done by sending messages to the view. These messages have to be implemented on the view explicitly. Like the `#renderTitle:` method in the example above for the presentation application. Such methods in the view have access to the DOM. See the class `CpDomElement` and subclasses for a full list of behaviours.

### Event handling
The view can make announcements which the presenter listens for. This is done by calling `#serverAnnounce:` from within the view. The presenter has to setup a listener. This is typically done inside the method `#viewCreated` within the presenter. For example the following method is part of the presentation application, within the presenter `CpLinkedContentPresenter`. This presenter shows some content and is linked to another slide (navigation link). When the view announces `CpLinkActivated` the presenter will receive this announcement. Since presenter and view are connected and the connector knows its model, the presenter can handle this announcement by asking the model for its linked slide and select it (part of the `#linkedSlideSelected` method).

```Smalltalk
viewCreated

	super viewCreated.

	self view
		when: CpLinkActivated send: #linkedSlideSelected to: self
```

In the view the following two methods are present, which link the browser click event to the announcement of the link being activated.

```Smalltalk
initialize

	super initialize.

	self when: CpPrimaryClickEvent send: #handleClickEvent: to: self

handleClickEvent: aClickEvent

	self serverAnnounce: CpLinkActivated
```

Browser events are handled very similar to regular announcements. Both standard browser events and custom events are supported. New custom events can be created from within the Smalltalk code.

### Updating the model
This is the easy part. The presenter knows its model and can therefore ask it to perform some operations/behaviour. When this results in changes in the model (and the model announces these through a ValueChanged announcement) then the presenter's `#renderView` will automagically be performed.


# TODO's
* Explain application life cycle
* Explain session timeouts (or lack of atm)
* Explain preference for additional specific Announcements over general Announcements carrying values
* Explain DOM model and where CodeParadise differs
* Explain update WebComponents should be done in slots or on host level to prevent updates from overriding it
