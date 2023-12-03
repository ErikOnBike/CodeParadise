# Applications
CodeParadise allows different types of applications to be created. This document will describe how [MVP](MVP.md)-based applications work, since this offers a rich environment to build your application in. For an explanation how an application 'works', please read the [implementation](Implementation.md) document first.

Simply put, an (MVP-based) application instance is a session object and it should contain (or be itself) a Model to render as the root of the DOM-tree which make up a webpage. With this root Model, rendering, updates and interactions with the application are performed. Every Model which is a descendant of this root Model, will take care of its own rendering, updates and interactions, so there is no manager behaviour required inside the application.

## Creating an application
As described in the [implementation](Implementation.md) document an application is described by a subclass of `CpWebApplication`. For MVP-based applications, we subclass from `CpMvpWebApplication`. For the examples here, we'll call this subclass `MyWebApplication`. An instance of an application class represents an application session. So session information is normally stored in the instance variables of your application. Furthermore, we need to implement at least the following two methods to setup the application.

* `MyWebApplication class >> #app`

    This class method should answer a Symbol representing the identifier of the application. This should be a unique value (amongst applications) to allow different applications to be hosted from the same environment. It will be part of the URL we use to access the application. Assuming you are running it from the Pharo environment and the identifier chosen is `#myapp``, the default URL will be: `http://localhost:8080/static/app.html?myapp`.

* `MyWebApplication >> #applicationModel`

    This instance method should answer a Model (see [MVP](MVP.md)) which acts as your root Model or entry point for the application. You can also use the application itself. Since it already has an announcer you will only need to announce `ValueChanged` if this top level element needs updating (do not worry about updating children, they can take care of themselves).

Some example applications with their implementation:

* Zettelkasten [source on GitHub](https://github.com/ErikOnBike/CodeParadise-Zettelkasten/blob/main/repository/CodeParadise-Zettelkasten/ZkZettelkastenApplication.class.st)
* BlogBuilder [source on GitHub](https://github.com/ErikOnBike/CodeParadise-BlogBuilder/blob/main/repository/CodeParadise-BlogBuilder/BbBlogBuilderApplication.class.st)
* Presentation [source on GitHub](https://github.com/ErikOnBike/CodeParadise/blob/master/repository/CodeParadise-WebApplication-Presentation/CpPresentationWebApplication.class.st)

## The application Model
Deciding on the Model to use for the application might at first be a bit tricky. Some examples:

* For a board game, the Model could consist of a number of players and the board itself. The application Presenter (and View), could render the surface (to place the board on) and allow users to be added to the game. Remember that the board is itself a Model responsible for being rendered, so the application Presenter should only render the surface. The application Presenter will delegate the board rendering to the board.
* For a drawing application with an SDI (Single Document Interface), the Model could contain a drawing Model. The application Presenter will render all the tools available. It will delegate rendering of the drawing to the drawing Model. To keep track of toolboxes which can be opened and closed and moved around, the state and position of these toolboxes might need to become part of the application Model.
* For a drawing application with a MDI (Multiple Document Interface), the Model could contain a collection of drawings (empty at first or a blanc drawing to start with). The application Presenter could show a menu which allows the user to create a new drawing, which would then be added to the application Model. And (like SDI variant) it could keep track of the status of the different tools.
* For any application which requires a user to login, the application Model could include the user. When no user is logged in yet, the application Model will render as a login page. Once logged in (and the user being set in the application Model) it will render the application 'content' for that specific user. For such a state based Presenter, implement the method `MyWebApplication >> #applicationPresenterClass` or in the application Model's #preferredPresenterClass` method to answer a different Presenter based on the presence of a logged in user.

## The application Presenter and View
All applications are rendered as a tree (components with subcomponents), since webpages are DOM-trees. The application Presenter and View are the root of the rendering tree which make up the (visual) application. All other Models will render inside the application (either directly or indirectly as part of another descendant of the application Presenter/View). Apart from being the root of the rendering tree, the application Presenter and View are not special.

Being the root of the rendering tree, means the application View will be the child of the HTML `<body>` tag. For advanced users, there are ways to add more children to the `<body>` tag to allow for example additional tooling to be present. These (other roots) might have to be rendered explicitly in some situations like during a webpage reload.


# TODO's
* Explain application life cycle
* Explain session timeouts (or lack of atm)
* Explain running behind webserver (e.g. Nginx) and then only needing WebSocket server
