Class {
	#name : 'CpCurrentApplicationContext',
	#superclass : 'DynamicVariable',
	#category : 'CodeParadise-WebApplication-MVP-Core',
	#package : 'CodeParadise-WebApplication-MVP',
	#tag : 'Core'
}

{ #category : 'accessing' }
CpCurrentApplicationContext class >> application [

	^ self value

]
