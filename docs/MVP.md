# Model View Presenter - MVP

CodeParadise has support for a Model View Presenter pattern built in. You typically create your 'business' logic in a Model. The Model will signal relevant changes. A Model can either be a `CpModel`, `Model` or any other class which announces ValueChanged.

When a `CpModel` instance is asked to display itself (either by sending `#display` or `#displayIn:`) it will create a Presenter. When using another type of model a Presenter might need to be created (in the web application) explicitly. Once the Presenter is created it will start listening to changes from the Model. Then it creates a View. This will be done in the web browser. The Presenter simply keeps a Proxy to this View. The Presenter will also start listening to announcements from the View.

Whenever the Model announces a change, the Presenter (listening to these announcements) will update (render) its View.

Whenever the View announces a relevant 'event', the Presenter (listening to these announcements) will update its Model. This means the Presenter has intimate knowledge about the Model. At least theoretically a Presenter could be used with a number of Views, but in practice there often exists a one-to-one relation between the two.

An example of MVP can be found in the `CpIntroductionPresentationWebApplication` which is a web application running a presentation/slide show. Updating one of the slides, while it is displayed in the browser will directly and automatically update the display.
