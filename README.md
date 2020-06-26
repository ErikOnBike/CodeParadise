# Code Paradise

Code Paradise is the name of a project and future platform. Code Paradise as project enables remote code execution in a Javascript environment. This means you can run Smalltalk inside the web browser and not be concerned with any Javascript. A regular (but tiny) Smalltalk image runs on [SqueakJS VM](https://squeak.js.org) and replaces the use of Javascript. This tiny image runs the same bytecode as a regular Pharo/Squeak/Cuis image. With some pre-installed Classes which wrap the browser DOM functionality, all DOM manipulation is done through Smalltalk code. Did I mention, no more use of Javascript ;-). Javascript is only used for the VM and some VM plugins.

## Introduction

The project offers a `RemoteEnvironment` and a `ServerApplication` controlling it. The `RemoteEnvironment` consists of a `ClientEnvironment` and a `ServerEnvironment`. The `ClientEnvironment` is a Smalltalk environment running inside a Javascript environment like a web browser or Node.js instance. The `ServerEnvironment` is (currently) a Pharo Smalltalk environment running on or as a web server. The two environments communicatie using WebSockets, allowing interactive  (instead of request-response style) communication. The `ServerApplication` can install code (`Classes` and `CompiledMethods`) in the `ClientEnvironment` on-the-fly thereby creating a dynamic environment (somewhat) similar to the live coding experience of a regular Smalltalk environment. The `ClientEnvironment` can only send back `Announcements` to the `ServerEnvironment` (explicit design decision I'll try to document in the near future).

A short introduction [video](https://youtu.be/qvY7R6te7go) will show some of the capabilities (it is a little outdated).

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

The tiny Smalltalk image does not include a Compiler or Debugger. If you try to start it using a desktop VM you will not get it running, since it assumes a number of Javascript primitives is implemented. The image is based on [Pharo Candle](https://github.com/carolahp/PharoCandleSrc) but has been extended with Exception handling, Announcements and the minimal ClientEnvironment classes like a Communicator. The code for this tiny image will become available online shortly.

### Load ServerEnvironment

The ServerEnvironment should be run from a Pharo7+ image. In the future other platforms like Cuis will probably supported as well.

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

To start a web server allowing incoming HTTP and WebSockets the following code has to be executed (port number and WebSocket path '/io' are hardcoded in the ClientEnvironment for now):
```Smalltalk
"Configure the usage of ZnWebSocket as MessageChannel"
CpMessageChannel environmentImplementation: CpZincWebSocketChannel.

"Register the two example applications"
CpDomExamplesServerApplication register.
CpCounterWebApplication register.

"Start the HTTP and WeSocket servers (use the path where you stored the ClientEnvironment)"
CpWebApplicationServerStarter startUsingConfig: {
	#portNumber -> 8080 .
	#staticFilesDirectoryName -> '/your/client/environment/path'
} asDictionary.

"If you serve the static files using your own HTTP server, you can start the WebSocket server using:"
"CpRemoteEnvironmentServer newOnPort: 8080 path: '/io'."
```

When you are done or want to reset the environment, the following code can be executed:
```Smalltalk
"Stop all server instances and applications"
ZnServer allSubInstances do: [ :each | (each port = 8080 and: [ each isRunning]) ifTrue: [ each stop ] ].
CpRemoteEnvironmentServer allInstances do: [ :each | each stop ].
CpServerApplication allSubInstances do: [ :each | each stop ].

"Unregister applications"
CpDomExamplesServerApplication unregister.
CpCounterWebApplication unregister.
CpCounterWebApplication release.

"Garbage collect works better in triples ;-)"
Smalltalk garbageCollect.
Smalltalk garbageCollect.
Smalltalk garbageCollect.
```

### Start your browsers

If all went well you should be able to fire up a number of browser tabs/pages and start using the example applications. Profit warning: the examples are still very limited, but should allow some insight in what is possible and allow you to play with it yourself.

The two applications can be reached using the following URLs:
* DOM Examples [http://localhost:8080/static/app.html?DOM-Examples](http://localhost:8080/static/app.html?DOM-Examples)
* Counter Example [http://localhost:8080/static/app.html?counter](http://localhost:8080/static/app.html?counter)

## Possible usage

The remote code execution capabilities of CodeParadise can be used to create WebApplications, remote worker instances, mobile applications, etc.

To create WebApplications a small part of MVP (Model View Presenter) is implemented in the Counter Example. It is based on [WebComponents](https://developer.mozilla.org/en-US/docs/Web/Web_Components) and more specifically it uses the HTML templates technology. The idea is to create a full set of components/widgets to create full featured web applications. All under the control of a Smalltalk application.

For the mobile applications for example, the following could be done:
* load a ClientEnvironment with all application code (can be done dynamically and include all kinds of tests)
* execute code to remove the ClientEnvironment's Communicator (disconnecting it from the ServerEnvironment) and test code
* save the ClientEnvironment image (currently not working because of tiny image format, but seems fixable ;-)
* use the saved image stand-alone in a mobile application (combine with SqueakJS VM into single package)
