"
I am a CustomEvent which gets dispatched if a (Smalltalk based) WebComponent is created
from markup content (instead of being created from code). My main usage is to allow any
necessary (Smalltalk) initialization to be performed even though I was not created from
(Smalltalk) code.

"
Class {
	#name : 'CpCreatedFromMarkupEvent',
	#superclass : 'CpCustomEvent',
	#category : 'CodeParadise-WebApplication-Events-Custom',
	#package : 'CodeParadise-WebApplication',
	#tag : 'Events-Custom'
}
