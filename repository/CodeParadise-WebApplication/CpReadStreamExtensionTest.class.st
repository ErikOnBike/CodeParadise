Class {
	#name : #CpReadStreamExtensionTest,
	#superclass : #TestCase,
	#category : #'CodeParadise-WebApplication'
}

{ #category : #tests }
CpReadStreamExtensionTest >> testLookAheadAt [

	| readStream |

	readStream := ReadStream on: 'Hello world'.

	self assert: (readStream lookAheadAt: 1) = $H description: 'Look at next Character from start'.
	self assert: (readStream lookAheadAt: 2) = $e description: 'Look at second Character from start'.
	self assert: (readStream lookAheadAt: 0) isNil description: 'No current (at start)'.
	self assert: (readStream lookAheadAt: -1) isNil description: 'No previous (at start)'.

	readStream next: 5.
	self assert: (readStream lookAheadAt: 1) = Character space description: 'Look at next Character from middle'.
	self assert: (readStream lookAheadAt: 2) = $w description: 'Look at second Character from middle'.
	self assert: (readStream lookAheadAt: 0) = $o description: 'Current in middle'.
	self assert: (readStream lookAheadAt: -1) = $l description: 'Previous in middle'.

	readStream next: 6.
	self assert: readStream atEnd description: 'Read all Characters'.
	self assert: (readStream lookAheadAt: 1) isNil description: 'Look at next Character from end'.
	self assert: (readStream lookAheadAt: 2) isNil description: 'Look at second Character from end'.
	self assert: (readStream lookAheadAt: 0) = $d description: 'Current at end'.
	self assert: (readStream lookAheadAt: -1) = $l description: 'Previous at end'

]
