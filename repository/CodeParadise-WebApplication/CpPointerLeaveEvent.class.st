"
I am a PointerLeave Event.

Beware: I represent the fact that a pointer is moved out of the visible page area.
This is different than the regular browser ""pointerleave"" behavior which can be used
on any visible element. The technical implementation of the event handling causes this
feature to be available only on the full page level.
The PointerLeaveEvent is useful for the DragEvent behavior and therefore remains available.

"
Class {
	#name : #CpPointerLeaveEvent,
	#superclass : #CpPointerEvent,
	#category : #'CodeParadise-WebApplication-Events'
}
