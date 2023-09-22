# CodeParadise

CodeParadise is the name of a framework and future platform. CodeParadise as framework allows developing web applications in Smalltalk using WebComponents. WebComponents are written using HTML/CSS and Smalltalk. A web application has a server side and a client side environment which interact using websockets. Applications can be built using a [Model View Presenter](docs/MVP.md) design.

The framework enables remote Smalltalk code execution in a Javascript environment. This means you can run Smalltalk inside the web browser and not be concerned with any Javascript. A regular (but tiny) Smalltalk image runs on [SqueakJS VM](https://squeak.js.org) and replaces the use of Javascript. This tiny image runs the same bytecode as a regular Pharo/Squeak/Cuis image, so no transpilation taking place. With some pre-installed Classes which wrap the browser DOM functionality, all DOM manipulation is done through Smalltalk code. Did I mention, no more use of Javascript ;-). For more detail read the [implementation docs](docs/Implementation.md).

A few online videos:
* Zettelkasten example application [video](https://youtu.be/omKrz9stuOQ) - 1:37 minutes
* short demo of debugger [video](https://youtu.be/hCwlrWRhrZc) - 1:07 minutes
* UK Smalltalk UG May 2022 [demo](https://vimeo.com/719355883) - CodeParadise used in Expressive Systems by [Object Guild](https://objectguild.com)
* UK Smalltalk UG August 2020 [demo](https://vimeo.com/457353130) - CodeParadise
* short introduction [video](https://youtu.be/qvY7R6te7go) - 12:47 minutes (outdated)
* first two components [link and button](https://youtu.be/nxQSlf4kFs8) - 2:18 minutes (outdated)
* animated [checkbox](https://youtu.be/-l0S03jZTtc) - 25 seconds (outdated)

See [introduction](docs/Introduction.md) for a more thorough explanation of CodeParadise as the future platform.

## Getting started

Currently CodeParadise can only be used in a Pharo environment (P8 until P12 are supported). In the future other platforms like Cuis might be supported as well.

Getting started requires a few simple steps:
* Load CodeParadise
* Start HTTP and WebSocket server
* Start your browsers!

### Load CodeParadise

Loading CodeParadise can be done using:
```Smalltalk
Metacello new
  repository: 'github://ErikOnBike/CodeParadise';
  baseline: 'CodeParadise';
  load.
```

Depending on your image version it should also load the [ClientEnvironment](https://github.com/ErikOnBike/CP-ClientEnvironment). If you run on a Pharo 8 or 9 environment, it should load the "pharo8" branch and otherwise just the "master" branch.

### Start HTTP and WebSocket Server

Thanks to [Tim](https://github.com/macta) there is a menu 'Paradise' now in Pharo's menubar which allows starting the environment. First select 'Reset' from the 'Paradise' menu and then open one of the existing applications through 'Open'. Some more explanation follows below for [manually starting and stopping servers](#manually) and applications.

### Start your browsers

If all went well you should be able to fire up a number of browser tabs/pages and start using the example applications. Profit warning: the examples are still very limited, but should allow some insight in what is possible and allow you to play with it yourself.

The example applications can be reached using the following URLs:
* Introduction Presentation [http://localhost:8080/static/app.html?presentation](http://localhost:8080/static/app.html?presentation)
* DOM Examples [http://localhost:8080/static/app.html?DOM-Examples](http://localhost:8080/static/app.html?DOM-Examples)
* Component Examples [http://localhost:8080/static/app.html?Component-Examples](http://localhost:8080/static/app.html?Component-Examples)
* Counter Example [http://localhost:8080/static/app.html?counter](http://localhost:8080/static/app.html?counter)
* Shoelace Examples [http://localhost:8080/static/app.html?Shoelace-Examples](http://localhost:8080/static/app.html?Shoelace-Examples)

A bigger example application is under development. It is a [Zettelkasten](https://en.wikipedia.org/wiki/Zettelkasten) application.
* Source code: [repo](https://github.com/ErikOnBike/CodeParadise-Zettelkasten) (you will have to load it manually into CodeParadise)
* Short demonstration: [video](https://youtu.be/omKrz9stuOQ)

---

### <a name="manually">Manually starting and stopping</a>

Besides the Paradise menu, you can also start and stop the ApplicationServer manually.
The ApplicationServer provides a HTTP server (using [Zinc HTTP Components](https://github.com/svenvc/zinc)) for a number of static files. You can use any other web server for this if you prefer.

The ApplicationServer also provides a WebSocket server (again using [Zinc HTTP Components](https://github.com/svenvc/zinc)) for the interactive communication between ClientEnvironment and ServerEnvironment.

To start a server allowing incoming HTTP and WebSockets the following code has to be executed:
```Smalltalk
"Configure the usage of ZnWebSocket as MessageChannel"
CpMessageChannel environmentImplementation: CpZincWebSocketChannel.

"Register the example applications"
CpDomExamplesWebApplication register.
CpComponentExamplesWebApplication register.
CpCounterWebApplication register.
CpShoelaceExamplesWebApplication register.
CpIntroductionPresentationWebApplication register.

"Start the HTTP and WeSocket servers (use the path where you stored the ClientEnvironment)"
CpWebApplicationServerStarter startUsingConfig: {
	#portNumber -> 8080 .
	#staticFilesDirectoryName -> (IceRepository directoryNamed: 'html' in: 'CP-ClientEnvironment')
} asDictionary.

"If you serve the static files using your own HTTP server, you can start the WebSocket server using:"
"CpApplicationServer newOnPort: 8080 path: '/io'."
```

The WebSocket server is listening on path `/io` by default (see example above). If you change this, please also update `app.html` (in the client environment) in which the path is hardcoded. 

When you are done or want to reset the environment, the following code can be executed:
```Smalltalk
"Stop all server instances and applications"
ZnServer allSubInstances do: [ :each | (each port = 8080 and: [ each isRunning]) ifTrue: [ each stop ] ].
CpServerApplication allSubInstances do: [ :each | each stop ].
CpApplicationServer allInstances do: [ :each | each stop ].

"Unregister applications"
CpDomExamplesWebApplication unregister.
CpComponentExamplesWebApplication unregister.
CpCounterWebApplication unregister.
CpCounterWebApplication release.
CpShoelaceExamplesWebApplication unregister.
CpIntroductionPresentationWebApplication unregister.

"Garbage collect works better in triples ;-)"
Smalltalk garbageCollect.
Smalltalk garbageCollect.
Smalltalk garbageCollect.
```

## Tips and troubleshooting

**Tip**: The server image keeps all sessions in memory at the moment (they never expire yet). So once in a while use the reset code above to clean up the sessions. Remember the sessions will also be saved in the image. So closing and reopening your image should bring you back the session and you can continu where you left off.

#### Resource not found
If you encounter any problems with connecting to the server, please check that no other web server is running on the port you are using/trying to use. If you have started a web server pointing to the wrong client environment, please first stop that instance. Otherwise you will keep on serving files from an empty or non-existing directory. Use the reset as described above to stop the server. You might want to check if all ZnServer instances are really stopped. Then create a new instance of the server.

#### Unknown classes
Once you have a client running and change code, the client environment might not know a class you are using. Please add this class by using the #beLoaded method (see existing senders to understand its usage). You might need to manually install it in a running environment (you have to find the corresponding server environment and use #addClass: to add it). Or reload the page in your browser. In some cases this is not enough, because of the order in which classes are installed. In such case you have to close the tab/page and open a new browser tab/page. In a future version this should not be necessary anymore.

## Possible usage

The remote code execution capabilities of CodeParadise can be used to create WebApplications, remote worker instances, mobile applications, etc.

To create WebApplications MVP (Model View Presenter) is implemented in the Presentation Example. It is based on [WebComponents](https://developer.mozilla.org/en-US/docs/Web/Web_Components) and more specifically it uses the HTML templates technology. The idea is to create a full set of components/widgets to create full featured web applications. All under the control of a Smalltalk application.

For mobile applications for example, the following could be done:
* load a ClientEnvironment with all application code (can be done dynamically and include all kinds of tests)
* execute code to remove the ClientEnvironment's Communicator (disconnecting it from the ServerEnvironment) and test code
* save the ClientEnvironment image (only supported for Pharo 10 and up)
* use the saved image stand-alone in a mobile application (combine with SqueakJS VM into single package)

## Compatibility

The means of installing (Compiled) code in the ClientEnvironment is by sending the relevant bytecode. The current implementation assumes that both the ServerEnvironment and the ClientEnvironment share the same bytecode set. Since the ClientEnvironment is running on SqueakJS VM, only bytecode sets supported by SqueakJS VM are usable. Currently Pharo 8 up to 12 (and including) are supported. Active development is on P11 and at some point support for P8 and P9 will be dropped because of the non-standard process of creating the tiny Smalltalk image which runs in the browser. From P10 onwards this is standardized using [TinyBootstrap](https://github.com/ErikOnBike/TinyBootstrap).

There is no explicit list of supported browsers at the moment. Please use a recent browser version. If you have trouble using (the pre-Chrome based) Microsoft Edge, please consider switching to Chrome, Firefox or one of the derivatives.
