# Model View Presenter - MVP

CodeParadise has support for a Model View Presenter pattern built in. You typically create your 'business' logic in a Model. The Model will signal relevant changes. A Model can either be a `CpModel`, `Model` or any other class which announces ValueChanged.

There are two ways for a Model to get displayed. Either by updates on the application model (see [Applications](Applications.md)) or by explicitly having Models display themselves. In the former case, a Presenter will render all child Views for any updated or new child models. In the latter case, when a `CpModel` instance is asked to display itself (either by sending `#display` or `#displayIn:`) it will create a Presenter. Once a Presenter is created it will start listening to changes from the Model. Then it creates a View. This will be done in the web browser. The Presenter simply keeps a Proxy to this View. The Presenter will also start listening to announcements from the View.

Whenever the Model announces a change, the Presenter (listening to these announcements) will update (render) its View.

Whenever the View announces a relevant 'event', the Presenter (listening to these announcements) will update its Model. This means the Presenter has intimate knowledge about the Model. At least theoretically a Presenter could be used with a number of Views, but in practice there often exists a one-to-one relation between the two.

An example of MVP can be found in the `CpIntroductionPresentationWebApplication` which is a web application running a presentation/slide show. Updating one of the slides, while it is displayed in the browser will directly and automatically update the display.

## Presenters and Views
The Presenter is responsible for rendering the View, handling View announcements/events and updating the model based on these announcements. The Presenter is a server side object which acts as an intermediate between model and View. A View is the actual UI and is in fact a [WebComponent](https://developer.mozilla.org/en-US/docs/Web/Web_Components) running in the browser. WebComponents can have `slots` in which other WebComponents can be rendered (creating a tree structure). A slot can contain multiple WebComponents. Beside a single unnamed default slot, all slots have a name. Since the View is running inside the browser, where only a limited Smalltalk image is present, the View should and can only contain UI logic. (Do not try to move your business logic into the View. There is not even a Date class present in the browser image.)

### Rendering the View
A View is rendered from the Presenter. The Presenter has to implement an instance method `#renderView` in which the rendering takes place. This method will be invoked (automagically as part of the framework) when a model announces a change, but also when a child Presenter is created. This latter is normally done from within the `#renderView` method.

Every Presenter knows its model (through method `#model`) and View (through method `#view`). It also knows its application (through method `#application`) to allow access to the session information. The parent and child Presenters can also be accessed, but this is often not necessary.

Below is an example from the `CpPresentationPresenter` class which is the application Presenter for a slideshow/presentation. It will render the current slide, a slide carousel (which is shown floating on top of the slide) and the title (which becomes part of the browser's tab):

```Smalltalk
renderView

    "Render the current slide"
	self renderChildViewForModel: self currentSlideModel atSlotNamed: #slide.

	"Only render the carousel if it is present"
	self slidesCarouselPresenter
		ifNotNil: [ :slidesCarouselPresenter | slidesCarouselPresenter renderView ].

	self view renderTitle: self model title
```

Calling `#renderChildViewForModel:atSlotNamed:` will result in the model being asked for its preferred Presenter which in turn renders the model at the given location (slot) within the parent. Subsequent invocations of this method will check whether a Presenter/View pair is already present and update the visuals accordingly. This can result in (part of) the DOM tree being recreated and other parts only receiving minor value/property updates.

A number of rendering methods exist. These are the main methods to use during rendering (in the method `#renderView` of your Presenter) when subcomponents are needed.

* `#renderAllChildViewsForModels:`

    renders a collection of Views for the specified models in the default (unnamed) slot  (i.e. multiple Views inside a single slot)

* `#renderAllChildViewsForModels:atSlotNamed:`

    renders a collection of Views for the specified models in the specified slot

* `#renderAllChildViewsForModels:usingPresenter:`
 
    renders a collection of Views for the specified models using the explicitly defined Presenters in the default (unnamed) slot (i.e. the models are not asked for their preferred Presenter)

* `#renderAllChildViewsForModels:usingPresenter:atSlotNamed:`

    renders a collection of Views for the specified models using the explicitly defined Presenters in the specified slot (i.e. the models are not asked for their preferred Presenter)

* `#renderChildViewForModel:`

    renders a View for the specified model in the default (unnamed) slot (i.e. single View inside a single slot)

* `#renderChildViewForModel:atSlotNamed:`

    renders a View for the specified model in the specified slot

* `#renderChildViewForModel:usingPresenter:`

    renders a View for the specified model using the explicitly defined Presenter in the default (unnamed) slot (i.e. the model is not asked for a preferred Presenter)

* `#renderChildViewForModel:usingPresenter:atSlotNamed`

    renders a View for the specified model using the explicitly defined Presenter in the specified slot (i.e. the model is not asked for a preferred Presenter)

When using a variant with `#usingPresenter:` either a Presenter class or a block can be provided as argument. When a block is provided it will receive the model as first argument (block argument is optional through `#cull:`). This allows the model to be asked for a specific kind of Presenter. For example from within some overview Presenter we could ask children to be rendered as item (instead of some full blown component) by using:

```Smalltalk
renderView

    "Render all employees as cards/items"
	self
        renderChildViewForModel: self model employees
        usingPresenter: [ :each | each preferredItemPresenterClass ]
        atSlotNamed: 'items'
```

The View itself (instead of the children mentioned above) might need to change. This can be done by sending messages to the View. These messages have to be implemented on the View explicitly. Like the `#renderTitle:` method in the example above for the presentation application. Such methods in the View have access to the DOM. See the class `CpDomElement` and subclasses for a full list of behaviours.

### Event handling
The View can make announcements which the Presenter listens for. This is done by calling `#serverAnnounce:` from within the View. The Presenter has to setup a listener. This is typically done inside the method `#viewCreated` within the Presenter. For example the following method is part of the presentation application, within the Presenter `CpLinkedContentPresenter`. This Presenter shows some content and is linked to another slide (navigation link). When the View announces `CpLinkActivated` the Presenter will receive this announcement. Since Presenter and View are connected and the Presenter knows its model, the Presenter can handle this announcement by asking the model for its linked slide and select it, using the following two methods in the Presenter.

```Smalltalk
viewCreated

	super viewCreated.

	self view
		when: CpLinkActivated send: #linkedSlideSelected to: self

linkedSlideSelected

    "Tell the parent presenter the linked slide is selected"

	self parent slideSelected: self model linkedSlide
```

In the View the following two methods are present, which link the browser click event to the announcement of the link being activated.

```Smalltalk
initialize

	super initialize.

	self when: CpPrimaryClickEvent send: #handleClickEvent: to: self

handleClickEvent: aClickEvent

	self serverAnnounce: CpLinkActivated
```

Browser events are handled very similar to regular announcements. Both standard browser events and custom events are supported. New custom events can be created from within the Smalltalk code.

### Updating the model
This is the easy part. The Presenter knows its model and can therefore ask it to perform some operations/behaviour. When this results in changes in the model (and the model announces these through a ValueChanged announcement) then the Presenter's `#renderView` will automagically be performed.

# TODO's
* Explain preference for additional specific Announcements over general Announcements carrying values
* Explain DOM model and where CodeParadise differs
* Explain update WebComponents should be done in slots or on host level to prevent updates from overriding it
