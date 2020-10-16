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
			margin: 0 5% 0 5%;
		}
		:host(.sub) { 
			display: block;
			font-size: .8em;
			padding-bottom: .6em;
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
