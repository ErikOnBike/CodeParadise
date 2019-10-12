# Code Paradise

Code Paradise is the name of my current pet project. Code Paradise is going to be a [web based](#web-based) [platform](#platform) for [kids](#kids) to learn to program using Object Oriented principles in [Smalltalk](#Smalltalk). It is a place to go when initial experience has been gathered on HTML and CSS and/or environments like [Scratch](https://scratch.mit.edu) and [Blockly](https://developers.google.com/blockly/).

## Status

Code Paradise is still in very early stages of development. Progress is limited because the development has to be done in the evenings and weekends. And even that is limited because of having a family and a regular social live. Development is still a one man show. The plan is to attract kids to join in at an early stage, so they can help shape the environment.

## <a name="platform">Why a platform?</a>

Code Paradise is going to be a platform for kids to share their work and help each other. Mentors (experienced developers and/or teachers) are allowed on the platform as well.

## <a name="kids">Why kids?</a>

Simply put, kids are the future programmers and I like to offer another platform next to the existing ones. One based on the principles of [Object Orientation](http://www.purl.org/stefan_ram/pub/doc_kay_oop_en) (Alan Kay's explanation). I have a broad range of experience with different programming languages and development environments and have personally been most happy with programming using [Smalltalk](#Smalltalk) (in different environments). I want to share that type of happiness with our future programmers.

Strictly speaking the platform is not going to be restricted to kids. Anyone wanting to learn programming can join. Tone of voice, examples and explanation might be more focused on kids than (young) adults though.

## <a name="Smalltalk">Why Smalltalk?</a>

As explained above, using Smalltalk for programming does and did make me very happy (as a programmer). Two elements stand out for me: the simplicity of the underlying model (communicating objects using messages) and a live moldable environment (direct changes and changing the development environment itself). Both are [design principles of Smalltalk](http://www.cs.virginia.edu/~evans/cs655/readings/smalltalk.html). Different Smalltalk implementations do exist, all with their own focus. Two have my special attention [Pharo](https://www.pharo.org) and [Cuis](https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev). The former has a very active community and is very feature rich. The latter is focused on a clean and simple implementation which is nice for learning purposes. Additionally a [toolkit Glamorous](https://gtoolkit.com) is built on top of Pharo that really shows the possibilities of moldability.

## <a name="web-based">Why web based?</a>

The platform is going to be web based, because this lowers the barriers for using it. Anyone with a (relative recent) web browser on his/her computer should be able to use the platform.

## <a name="implementation">How will the platform be implemented?</a>

The platform will consist of a server farm running many Smalltalk images. At this time it is not decided if this will be limited to a specific Smalltalk implementation or if different implementations will co-exist. The latter would mean that these differences has to be made clear to the users, which does not help in the understandability of the platform.

## Background

The development environment itself will be running on the mentioned servers. The web browser is only responsible for the user interface of the development environment. A small Smalltalk application will run in the web browser to handle user interface logic (displaying information and receiving input events). All decision logic (even of what should be displayed) is performed on the server side.

[SqueakJS](https://squeak.js.org) or [Amber](https://amber-lang.net) can already be used as Smalltalk development environment in the web browser. They both would require quite some work to become a team environment in which users can help each other and an environment that could use more (server side) resources like databases. Running a 'regular' Smalltalk image inside SqueakJS does work, but requires a fast CPU and a lot of memory. Amber's main focus is on client side development. It could be used for the user interface, but it would use a very distinct implementation since it is not based on a Smalltalk image being run by a VM.

The current plan is to have a web browser as the 'head' of the development environment. It should only represent the display and input device. There has to be some logic in the web browser to create the display (creating elements in the DOM) and handling events (user pressing buttons or dragging windows). This is normally done in Javascript, but it shines through. As soon as an event is not handled correctly, Javascript will generate an Exception. This does not fit the Smalltalk model and some translation has to be done between the two models. [PharoJS](https://pharojs.github.io) might be useful here.

Currently work is being based on a [tiny Smalltalk image](https://github.com/carolahp/pharo/tree/candle) running on SqueakJS in the browser. This tiny image is responsible for the client side UI logic. The server side Smalltalk image contains UI components (classes) which 'know' their HTML and CSS (something kids do learn in different places) and a tiny bit of Smalltalk code to handle events. This UI component (HTML, CSS and code) is transferred to the web browser and installed in the tiny image. It will create the same UI component (class) inside the browser and it can/will only do the displaying and event handling. If the server side code changes, these changes are sent to the web browser as well. This keeps the UI components in sync. If an exception occurs in the tiny image, it will be send back to the server as an event. The server can handle it or show a debugger (which of course gets displayed in the web browser just like everything else). There has to be a tiny glue layer between the tiny image and the DOM. This is done by a Javascript plugin for SqueakJS (and could be regarded as part of the VM) like UI handling for desktop Smalltalks is also handled in plugins. 

The UI components are based on the [Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components) standard.
