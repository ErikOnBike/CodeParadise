Class {
	#name : #CpBulletView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpBulletView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		:host {
			display: list-item;
			width: 100%;
			margin: .2vh 5vw .2vh 5vw;
		}
		:host(.sub) { 
			display: block;
		}
		.container {
			width: 100%;
		}'
]

{ #category : #'web resources' }
CpBulletView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<slot></slot>
		</div>'
]
