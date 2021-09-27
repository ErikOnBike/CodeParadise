Class {
	#name : #CpWorkspace,
	#superclass : #CpView,
	#category : #'CodeParadise-Beach-Components'
}

{ #category : #'web resources' }
CpWorkspace class >> style [

	<webResource: #css>

	^ ':host {
		display: block;
		position: fixed;
		top: 0;
		left: 0;
		width: max-content;
		height: max-content;
	}'
]

{ #category : #'web resources' }
CpWorkspace class >> template [

	<webResource: #html>

	^ '<slot></slot>'
]

{ #category : #accessing }
CpWorkspace >> upperLeftPoint [

	^ self translateToLocalPoint: 0 @ 0
]
