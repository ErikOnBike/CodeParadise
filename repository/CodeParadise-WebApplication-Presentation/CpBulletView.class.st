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
			margin: 0 5% 0 5%;
		}
		#container {
			line-height: 1.33em;
		}
		::slotted(*) {
			display: inline-block;
			vertical-align: top;
		}'
]

{ #category : #'web resources' }
CpBulletView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<slot></slot>
		</div>'
]
