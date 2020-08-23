Class {
	#name : #CpBulletedContentView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-Presentation-View'
}

{ #category : #'web resources' }
CpBulletedContentView class >> style [

	<webResource: #css>

	^'.container {
		width: 100%;
		height: 100%;
	}
	ul {
		margin-top: 0;
		margin-bottom: 0;
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
