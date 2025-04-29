Class {
	#name : #CynDatabaseUniqueConstraintViolation,
	#superclass : #CynDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CynDatabaseUniqueConstraintViolation >> messageText [

	^ messageText ifNil: [ 'Unique constraint violation' ]
]
