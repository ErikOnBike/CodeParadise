"
I am an example application for use with Node.js.

I am a calculating HTTP Server.
Try sending me as URL ""/add:42"" to add a number. You can also use ""/subtract:7"", ""/multiply:3"" or ""/divide:2.5"".
Or combine calculations ""/add:3/subtract:7/multiply:3.1/subtract:2.78"".
You can repeatedly perform calculations. To see the current value use ""/value"".
To remove the last calculation use ""/undo"", to remove all calculations use ""/reset"".
You can snapshot the image using ""/snapshot"". From that point, the image is ""sealed"" and no
updates can be made to the image using the CodeParadise server. The image can be snapshotted
again later to store the current calculation once more. Every snapshot will overwrite the image.
(I do not support LargeIntegers on input, but do support such outcomes)
Have fun!

"
Class {
	#name : #CpNodeJSSupportExampleHttpServerApplication,
	#superclass : #CpServerApplication,
	#category : #'CodeParadise-NodeJS-Support-Examples'
}

{ #category : #accessing }
CpNodeJSSupportExampleHttpServerApplication class >> app [

	^ #'http-server-example'
]

{ #category : #actions }
CpNodeJSSupportExampleHttpServerApplication >> load [

	super load.

	self installClass: CpNodeJSExampleHttpServer
]
