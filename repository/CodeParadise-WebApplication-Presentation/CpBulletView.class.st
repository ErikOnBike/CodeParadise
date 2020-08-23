Class {
	#name : #CpBulletView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpBulletView class >> style [

	<webResource: #css>

	^':host {
		display: list-item;
		margin-top: .2rem;
		margin-bottom: .2rem;
		margin-left: 5vw;
		font-size: 6vh;
	}
	:host(.sub) { 
		display: block;
	}
	.container {
		width: 100%;
		height: 100%;
	}'
]

{ #category : #'web resources' }
CpBulletView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<slot></slot>
		</div>'
]
