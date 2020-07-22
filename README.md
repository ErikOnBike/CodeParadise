# Code Paradise

Code Paradise is the name of a project and future platform. Code Paradise as project enables remote code execution in a Javascript environment. This means you can run Smalltalk inside the web browser and not be concerned with any Javascript. A regular (but tiny) Smalltalk image runs on [SqueakJS VM](https://squeak.js.org) and replaces the use of Javascript. This tiny image runs the same bytecode as a regular Pharo/Squeak/Cuis image. With some pre-installed Classes which wrap the browser DOM functionality, all DOM manipulation is done through Smalltalk code. Did I mention, no more use of Javascript ;-). Javascript is only used for the VM and some VM plugins.

## Introduction

The project offers a `RemoteEnvironment` and a `ServerApplication` controlling it. The `RemoteEnvironment` consists of a `ClientEnvironment` and a `ServerEnvironment`. The `ClientEnvironment` is a Smalltalk environment running inside a Javascript environment like a web browser or Node.js instance. The `ServerEnvironment` is (currently) a Pharo Smalltalk environment running on or as a web server. The two environments communicatie using WebSockets, allowing interactive  (instead of request-response style) communication. The `ServerApplication` can install code (`Classes` and `CompiledMethods`) in the `ClientEnvironment` on-the-fly thereby creating a dynamic environment (somewhat) similar to the live coding experience of a regular Smalltalk environment. The `ClientEnvironment` can only send back `Announcements` to the `ServerEnvironment` (explicit design decision I'll try to document in the near future).

A few online videos:
* short introduction [video](https://youtu.be/qvY7R6te7go) (it is a little outdated)
* first two components [link and button](https://youtu.be/nxQSlf4kFs8) - 2:18 minutes
* animated [checkbox](https://youtu.be/-l0S03jZTtc) 25 seconds

See [introduction](introduction.md) for a more thorough explanation of CodeParadise as the future platform.

## Getting started

Getting started requires a few steps:
* Setup ClientEnvironment consisting of SqueakJS VM and tiny Smalltalk image
* Load ServerEnvironment into regular Pharo image
* Run code on the server to start HTTP and WebSocket server
* Start your browsers!

### Setup ClientEnvironment

To download the ClientEnvironment clone [CP-ClientEnvironment](https://github.com/ErikOnBike/CP-ClientEnvironment) or copy the 3 raw files in the html directory. Remember the directory in which the 3 files `app.html`, `squeak_headless_bundle.js` and `client-environment.image` are written. You will need this location in the third step when running the server.

The files:
* `app.html` contains a few lines of code to start the Squeak JS VM and specify which Smalltalk image to run
* `squeak_headless_bundle.js` contains the Squeak JS VM in headless mode (ie no BitBlt support) and a number of plugins
   * Large Integers
   * Misc primitives (includes some String handling)
   * (CodeParadise) System (includes WebSocket support)
   * (CodeParadise) DOM (wrapper code for DOM functionality)
* `client-environment.image` is a tiny (around 200Kb) Smalltalk image

The tiny Smalltalk image does not include a Compiler or Debugger. If you try to start it using a desktop VM you will not get it running, since it assumes a number of Javascript primitives is implemented. The image is based on [Pharo Candle](https://github.com/carolahp/PharoCandleSrc) but has been extended with Exception handling, Announcements and the minimal ClientEnvironment classes like a Communicator. The code and some explanation for this tiny image can be found on [CP-Bootstrap](https://github.com/ErikOnBike/CP-Bootstrap).

**Tip**: Do not forget to pull this repo regularly, since some code changes will need to be made on the ClientEnvironment as well.

### Load ServerEnvironment

The ServerEnvironment should be run from a Pharo7 or Pharo8 image (**Pharo9 can't be used at the moment, see compatibility info below**). In the future other platforms like Cuis will probably be supported as well.

Loading the ServerEnvironment can be done using:
```Smalltalk
Metacello new
  repository: 'github://ErikOnBike/CodeParadise/repository';
  baseline: 'CodeParadise';
  load.
```

### Run HTTP and WebSocket Server

The ServerEnvironment provides a HTTP server (using [Zinc HTTP Components](https://github.com/svenvc/zinc)) for a number of static files. You can use any other web server for this if you prefer.

The ServerEnvironment provides a WebSocket server (again using [Zinc HTTP Components](https://github.com/svenvc/zinc)) for the interactive communication between ClientEnvironment and ServerEnvironment.

To start a web server allowing incoming HTTP and WebSockets the following code has to be executed:
```Smalltalk
"Configure the usage of ZnWebSocket as MessageChannel"
CpMessageChannel environmentImplementation: CpZincWebSocketChannel.

"Register the two example applications"
CpDomExamplesServerApplication register.
CpComponentExamplesServerApplication register.
CpCounterWebApplication register.

"Start the HTTP and WeSocket servers (use the path where you stored the ClientEnvironment)"
CpWebApplicationServerStarter startUsingConfig: {
	#portNumber -> 8080 .
	#staticFilesDirectoryName -> '/your/path/to/CP-ClientEnvironment/html'
} asDictionary.

"If you serve the static files using your own HTTP server, you can start the WebSocket server using:"
"CpRemoteEnvironmentServer newOnPort: 8080 path: '/io'."
```

The WebSocket server is listening on path `/io` by default (see example above). If you change this, please also update `app.html` in which the path is hardcoded. 

When you are done or want to reset the environment, the following code can be executed:
```Smalltalk
"Stop all server instances and applications"
ZnServer allSubInstances do: [ :each | (each port = 8080 and: [ each isRunning]) ifTrue: [ each stop ] ].
CpRemoteEnvironmentServer allInstances do: [ :each | each stop ].
CpServerApplication allSubInstances do: [ :each | each stop ].

"Unregister applications"
CpDomExamplesServerApplication unregister.
CpComponentExamplesServerApplication unregister.
CpCounterWebApplication unregister.
CpCounterWebApplication release.

"Garbage collect works better in triples ;-)"
Smalltalk garbageCollect.
Smalltalk garbageCollect.
Smalltalk garbageCollect.
```

**Tip**: Adding additional classes to an application is currently not always correctly propagated to a running environment. Even reloading a tab/window might not always yield the required result. Try opening a new tab/window just to be sure. And if it still results in an exception, you might try to reset the environment with the code above and restart it.

**Tip**: The server image keeps all sessions in memory at the moment (they never expire yet). So once in a while use the reset code above to clean up the sessions. Remember the sessions will also be saved in the image. So closing and reopening your image should bring you back the session and you can continu where you left off.

### Start your browsers

If all went well you should be able to fire up a number of browser tabs/pages and start using the example applications. Profit warning: the examples are still very limited, but should allow some insight in what is possible and allow you to play with it yourself.

The two applications can be reached using the following URLs:
* DOM Examples [http://localhost:8080/static/app.html?DOM-Examples](http://localhost:8080/static/app.html?DOM-Examples)
* Component Examples [http://localhost:8080/static/app.html?Component-Examples](http://localhost:8080/static/app.html?Component-Examples)
* Counter Example [http://localhost:8080/static/app.html?counter](http://localhost:8080/static/app.html?counter)

## Troubleshooting

#### Resource not found
If you encounter any problems with connecting to the server, please check that no other web server is running on the port you are using/trying to use. If you have started a web server pointing to the wrong client environment, please first stop that instance. Otherwise you will keep on serving files from an empty or non-existing directory. Use the reset as described above to stop the server. You might want to check if all ZnServer instances are really stopped. Then create a new instance of the server.

#### Unknown classes
Once you have a client running and change code, the client environment might not know a class you are using. Please add this class to the #cpRequiredClasses method (see existing implementors to understand its usage). Just adding the class to this method will not also install it. You might need to manually install it in a running environment (you have to find the corresponding server environment and use #addClass: to add it). Or reload the page in your browser. In some cases this is not enough, because of the order in which classes are installed. In such case you have to close the tab/page and open a new browser tab/page. In a future version this should not be necessary anymore.

## Possible usage

The remote code execution capabilities of CodeParadise can be used to create WebApplications, remote worker instances, mobile applications, etc.

To create WebApplications a small part of MVP (Model View Presenter) is implemented in the Counter Example. It is based on [WebComponents](https://developer.mozilla.org/en-US/docs/Web/Web_Components) and more specifically it uses the HTML templates technology. The idea is to create a full set of components/widgets to create full featured web applications. All under the control of a Smalltalk application.

For the mobile applications for example, the following could be done:
* load a ClientEnvironment with all application code (can be done dynamically and include all kinds of tests)
* execute code to remove the ClientEnvironment's Communicator (disconnecting it from the ServerEnvironment) and test code
* save the ClientEnvironment image (currently not working because of tiny image format, but seems fixable ;-)
* use the saved image stand-alone in a mobile application (combine with SqueakJS VM into single package)

## Compatibility

The means of installing (Compiled) code in the ClientEnvironment is by sending the relevant bytecode. The current implementation assumes that both the ServerEnvironment and the ClientEnvironment share the same bytecode set. Since the ClientEnvironment is running on SqueakJS VM, only bytecode sets supported by SqueakJS VM are usable. At the moment there is no support for the newer Sista bytecode set in SqueakJS VM. Therefore Pharo9 can't be used as a development platform. Support for Sista in SqueakJS VM is currently not foreseen. If anyone is interested to help out, please reach out to either Vanessa Freudenberg (developer and maintainer of SqueakJS VM) at [SqueakJS](https://github.com/codefrau/SqueakJS) or me.

There is no explicit list of supported browsers at the moment. Please use a recent browser version. If you have trouble using (the pre-Chrome based) Microsoft Edge, please consider switching to Chrome, Firefox or one of the derivatives.
