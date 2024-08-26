# CodeParadise

CodeParadise is the name of a framework and a future platform. CodeParadise as framework allows developing web applications, Node.js applications and mobile apps in Smalltalk only. CodeParadise is based on the [Pharo](https://pharo.org) Smalltalk environment.

The general principle behind CodeParadise is the execution of a regular (but tiny) Smalltalk image inside a JavaScript execution environment. During development this tiny Smalltalk image communicates with a full Pharo development environment to be kept up to date and provide the typical live programming experience we love so much in Smalltalk. Since CodeParadise runs in a Smalltalk image, there is no need for transpiling Smalltalk to JavaScript. That is: Smalltalk all the way!

A few online videos:

* to-do list tutorial walk through [video](https://youtu.be/Y-i6C_yVHxA) - 47:47 minutes
* creating a Node.js application [video](https://youtu.be/2FxPBCq75qY) - 10:22 minutes
* Zettelkasten example application [video](https://youtu.be/omKrz9stuOQ) - 1:37 minutes
* short demo of debugger [video](https://youtu.be/hCwlrWRhrZc) - 1:07 minutes
* UK Smalltalk UG May 2022 [demo](https://vimeo.com/719355883) - CodeParadise used in Expressive Systems by [Object Guild](https://objectguild.com)
* UK Smalltalk UG August 2020 [demo](https://vimeo.com/457353130) - CodeParadise

See [introduction](docs/Introduction.md) for a more thorough explanation of CodeParadise as the future platform.

Relevant documentation:

* [MVP](./docs/MVP.md) - how to use the MVP pattern
* [Applications](./docs/Applications.md) - explains MVP-based applications

## Getting started

Currently CodeParadise can only be used in a Pharo environment. In the future other Smalltalk environments like Cuis might be supported as well.

Getting started requires a few simple steps:

* Load CodeParadise
* Start CodeParadise
* Start your browsers (or Node.js)!

### Load CodeParadise

Loading CodeParadise can be done using:

```Smalltalk
Metacello new
  repository: 'github://ErikOnBike/CodeParadise';
  baseline: 'CodeParadise';
  load.
```

If you plan on developing Node.js applications, please clone the [CP-Node](https://github.com/ErikOnBike/CP-Node) repo into a separate directory. It only contains 2 'required' files: [cp-node.js](https://raw.githubusercontent.com/ErikOnBike/CP-Node/main/cp-node.js) and [client-environment.image](https://github.com/ErikOnBike/CP-Node/raw/main/client-environment.image). You can also copy them to a preferred directory (instead of cloning the repo).

### Start CodeParadise

Thanks to [Tim](https://github.com/macta) there is a menu 'Paradise' in Pharo's menubar which allows starting the environment. First select 'Reset' from the 'Paradise' menu and then open one of the existing web applications through 'Open'. Some more explanation follows below for [manually starting and stopping servers](#manually) and applications.

### Start your browsers

If all went well you should be able to fire up a number of browser tabs/pages and start using the example applications. Profit warning: the examples are still very limited, but should allow some insight in what is possible and allow you to play with it yourself.

The example applications can be reached using the following URLs:
* Introduction Presentation [http://localhost:8080/static/app.html?presentation](http://localhost:8080/static/app.html?presentation)
* **Building your first app** [http://localhost:8080/static/app.html?building-my-first-app](http://localhost:8080/static/app.html?building-my-first-app) [*NEW*]
* Shoelace Examples [http://localhost:8080/static/app.html?Shoelace-Examples](http://localhost:8080/static/app.html?Shoelace-Examples)
* ChartJS Examples [http://localhost:8080/static/app.html?ChartJS-Examples](http://localhost:8080/static/app.html?ChartJS-Examples)
* Counter Example [http://localhost:8080/static/app.html?counter](http://localhost:8080/static/app.html?counter)
* DOM Examples [http://localhost:8080/static/app.html?DOM-Examples](http://localhost:8080/static/app.html?DOM-Examples)
* Component Examples [http://localhost:8080/static/app.html?Component-Examples](http://localhost:8080/static/app.html?Component-Examples)

A bigger example application is under development. It is a [Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten) application.

* Source code: [repo](https://github.com/ErikOnBike/CodeParadise-Zettelkasten) (you will have to load it manually into CodeParadise)
* Short demonstration: [video](https://youtu.be/omKrz9stuOQ)

### Start your Node.js application

To start a Node.js application, execute the following from a [CP-Node](https://github.com/ErikOnBike/CP-Node) directory:
```bash
APP="http-server-example" SERVER_URL="ws://localhost:8080/io" node cp-node.js client-environment.image
```
(replace the value of the APP environment variable with the identifier of your preferred application)

---

### <a name="manually">Manually starting and stopping</a>

To start CodeParadise the following code has to be executed:

```Smalltalk
CpDevTools start.
```

This will start a HTTP and WebSocket server. Once the environment is started you can run as many applications as you want. You can then start an application using the following:

```Smalltalk
CpPresentationWebApplication openInBrowser.
```

When you are done or want to reset the environment, the following code can be executed:

```Smalltalk
CpDevTools stop.

"Garbage collect works better in triples ;-)"
3 timesRepeat: [ Smalltalk garbageCollect ].
```

## Tips and troubleshooting

**Tip**: The server image keeps all sessions in memory at the moment (they never expire yet). So once in a while use the reset code above to clean up the sessions. Remember the sessions will also be saved in the image. So closing and reopening your image should bring you back the session and you can continu where you left off.

### Resource not found

If you encounter any problems with connecting to the server, please check that no other web server is running on the port you are using/trying to use. If you have started a web server pointing to the wrong client environment, please first stop that instance. Otherwise you will keep on serving files from an empty or non-existing directory. Use the reset as described above to stop the server. You might want to check if all ZnServer instances are really stopped. Then create a new instance of the server.

### Unknown classes

Once you have a client running and change code, the client environment might not know a class you are using. Please add this class by using the #beLoaded method (see existing senders to understand its usage). You might need to manually install it in a running environment (you have to find the corresponding server environment and use #addClass: to add it). Or reload the page in your browser. In some cases this is not enough, because of the order in which classes are installed. In such case you have to close the tab/page and open a new browser tab/page.

## Possible usages

The remote code execution capabilities of CodeParadise can be used to create WebApplications, Node.js applications, remote worker instances, mobile applications, etc.

To create WebApplications an MVP (Model View Presenter) pattern is implemented for ease of development. It is based on [WebComponents](https://developer.mozilla.org/en-US/docs/Web/Web_Components) and more specifically it uses the HTML templates technology. The idea is to create a full set of components/widgets to create full featured web applications. All under the control of a Smalltalk application.

Applications can also be 'sealed' allowing them to be run without the need of a Pharo server image. This allows you to create mobile apps, or stand alone Node.js server applications or Node.js CLI tools. This feature is incompatible with the MVP-based applications, since they require communicating with Models and Presenters which run on the Pharo server image.

## Compatibility

The means of installing (Compiled) code in the tiny Smalltalk image (aka ClientEnvironment) is by sending the relevant bytecode. The current implementation assumes that both the Pharo server image (aka ServerEnvironment) and the ClientEnvironment share the same bytecode set. Since the ClientEnvironment is running on SqueakJS VM, only bytecode sets supported by SqueakJS VM are usable. Currently Pharo 10 up to 13 (and including) are supported. Active development is on P12. Support for P8 and P9 is no longer provided, because of the non-standard process of creating the tiny Smalltalk image which runs in the browser. From P10 onwards this is standardized using [TinyBootstrap](https://github.com/ErikOnBike/TinyBootstrap). IF you still need support for P8 or P9, please contact me directly or create an issue.

There is no explicit list of supported browsers at the moment. Please use a recent browser version. If you have trouble using (the pre-Chrome based) Microsoft Edge, please consider switching to Chrome, Firefox or one of the derivatives.
