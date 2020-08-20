"
I am a simple Server Application to show some DOM manipulation behavior.
I only live in the ServerEnvironment.
"
Class {
	#name : #CpDomExamplesServerApplication,
	#superclass : #CpWebApplication,
	#category : #'CodeParadise-WebApplication-Examples'
}

{ #category : #'as yet unclassified' }
CpDomExamplesServerApplication class >> openInBrowser [
	<script>
	WebBrowser openOn: 'http://localhost:8080/static/app.html?DOM-Examples'
]
