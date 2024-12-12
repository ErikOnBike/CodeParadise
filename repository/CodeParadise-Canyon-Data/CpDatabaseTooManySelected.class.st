Class {
	#name : #CpDatabaseTooManySelected,
	#superclass : #CpDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CpDatabaseTooManySelected >> messageText [

	^ messageText ifNil: [ 'More than 1 row is selected' ]
]
