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
		:host,
		.container {
			width: 100%;
		}
		ul {
			margin: 0;
		}'
]

{ #category : #'web resources' }
CpBulletedContentView class >> template [

	<webResource: #html>

	^ '<div class="container">
			<ul>
				<slot></slot>
			</ul>
		</div>'
]
