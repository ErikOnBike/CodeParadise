Class {
	#name : #CpWorkspace,
	#superclass : #CpView,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpWorkspace class >> template [

	<webResource: #html>

	^ '<slot></slot>'
]
