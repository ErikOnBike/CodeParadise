Class {
	#name : #CpDatabaseUniqueConstraintViolation,
	#superclass : #CpDatabaseError,
	#category : #'CodeParadise-Canyon-Data-Database'
}

{ #category : #accessing }
CpDatabaseUniqueConstraintViolation >> messageText [

	^ messageText ifNil: [ 'Unique constraint violation' ]
]
