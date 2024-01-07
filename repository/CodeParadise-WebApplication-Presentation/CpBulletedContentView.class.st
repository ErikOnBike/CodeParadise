Class {
	#name : #CpBulletedContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpBulletedContentView class >> style [

	<webResource: #css>

	^ '* {
			box-sizing: border-box;
		}
		ul {
			margin: 0;
		}'
]

{ #category : #'web resources' }
CpBulletedContentView class >> template [

	<webResource: #html>

	^ '<div id="container">
			<ul>
				<slot></slot>
			</ul>
		</div>'
]
