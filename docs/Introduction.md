# CodeParadise

CodeParadise is the name of my current pet project. CodeParadise is going to be a [web based](#web-based) [platform](#platform) for [kids](#kids) to learn to program using Object Oriented principles in [Smalltalk](#Smalltalk). It is a place to go when initial experience has been gathered on HTML and CSS and/or environments like [Scratch](https://scratch.mit.edu) and [Blockly](https://developers.google.com/blockly/).

## Status

CodeParadise is still in very early stages of development. Progress is limited because the development has to be done in the evenings and weekends. And even that is limited because of having a family and a regular social live. Development is still a one man show. The plan is to attract kids to join in at an early stage, so they can help shape the environment.

## <a name="platform">Why a platform?</a>

CodeParadise is going to be a platform for kids to share their work and help each other. Mentors (experienced developers and/or teachers) are allowed on the platform as well.

## <a name="kids">Why kids?</a>

Simply put, kids are the future programmers and I like to offer another platform next to the existing ones. One based on the principles of [Object Orientation](http://www.purl.org/stefan_ram/pub/doc_kay_oop_en) (Alan Kay's explanation). I have a broad range of experience with different programming languages and development environments and have personally been most happy with programming using [Smalltalk](#Smalltalk) (in different environments). I want to share that type of happiness with our future programmers.

Strictly speaking the platform is not going to be restricted to kids. Anyone wanting to learn programming can join. Tone of voice, examples and explanation might be more focused on kids than (young) adults though.

## <a name="Smalltalk">Why Smalltalk?</a>

As explained above, using Smalltalk for programming does and did make me very happy (as a programmer). Two elements stand out for me: the simplicity of the underlying model (communicating objects using messages) and a live moldable environment (direct changes and changing the development environment itself). Both are [design principles of Smalltalk](http://www.cs.virginia.edu/~evans/cs655/readings/smalltalk.html). Different Smalltalk implementations do exist, all with their own focus. Two have my special attention [Pharo](https://www.pharo.org) and [Cuis](https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev). The former has a very active community and is very feature rich. The latter is focused on a clean and simple implementation which is nice for learning purposes. Additionally a [toolkit Glamorous](https://gtoolkit.com) is built on top of Pharo that really shows the possibilities of moldability.

## <a name="web-based">Why web based?</a>

The platform is going to be web based, because this lowers the barriers for using it. Anyone with a (relative recent) web browser on his/her computer should be able to use the platform.

## <a name="implementation">How will the platform be implemented?</a>

The platform will consist of a server farm running many Smalltalk images. At this time it is not decided if this will be limited to a specific Smalltalk implementation or if different implementations will co-exist. The latter would mean that these differences has to be made clear to the users, which does not help in the understandability of the platform. All code will become open source and schools, other organizations or individuals should be able to setup their own server/platform as well.
