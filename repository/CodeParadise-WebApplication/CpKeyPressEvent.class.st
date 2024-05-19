"
I am a KeyPress event. I will be dispatched when a key is pressed down and for certain
keys as well as when that key is kept down. In the latter case I will be dispatched
repeatedly at the interval set for the device I'm running on.
Some keys do not get 'pressed' like arrow keys or modifier keys. Only the KeyDown and
KeyUp events are dispatched for these events.

"
Class {
	#name : 'CpKeyPressEvent',
	#superclass : 'CpKeyEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}
