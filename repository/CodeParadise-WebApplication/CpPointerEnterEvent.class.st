"
I am a PointerEnter Event.

Beware: I represent the fact that a pointer is moved into the visible page area.
This is different than the regular browser ""pointerenter"" behavior which can be used
on any visible element. The technical implementation of the event handling causes this
feature to be available only on the full page level.
The PointerEnterEvent is useful for the DragEvent behavior and therefore remains available.

"
Class {
	#name : 'CpPointerEnterEvent',
	#superclass : 'CpPointerEvent',
	#category : 'CodeParadise-WebApplication-Events',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events'
}
