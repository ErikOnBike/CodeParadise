Class {
	#name : #CpPropertySlotNotFound,
	#superclass : #SlotNotFound,
	#category : #'CodeParadise-WebApplication-MVP-Slots'
}

{ #category : #accessing }
CpPropertySlotNotFound >> messageText [

	^ 'PropertySlot with name ', name printString, ' not found.'
]
