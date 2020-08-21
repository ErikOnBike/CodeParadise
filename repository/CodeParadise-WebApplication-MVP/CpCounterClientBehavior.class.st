Class {
	#name : #CpCounterClientBehavior,
	#superclass : #CpMvpWebClientBehavior,
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #accessing }
CpCounterClientBehavior class >> introHtml [

	^ '<h1>Counter example</h1>
	<h2>What is this?</h2>
	<p>
	This is a very basic counter example. It shows two counters. One is attached to a global Counter Model and the other to a client specific Counter Model. If you change the first Counter (by pressing the increase/decrease buttons) all other browser tabs open on this same Counter Example will also update their value. Try it out! It will probably also run on your mobile ;-).
	</p>
	<h2>It looks horrible!</h2>
	<p>
	Don''t you like the simplistic look of the counters? Well go over to the Class <code>CpCounterView</code> and change the CSS style or HTML template. As soon as you save a change in either the <code>#style</code> or the <code>#template</code> method, it will become visible instantaneous in this page (and all other pages showing the Counter Example). That''s coding in Smalltalk style!
	</p>'
]

{ #category : #accessing }
CpCounterClientBehavior class >> introStyle [

	^'
		body { 
			margin-left: 4em;
			margin-right: 4em;
		}
		h2 {
			margin-bottom: 0; 
		}
		p {
			margin-top: .5em;
		}
		code { 
			background-color: #e8e8e8;
			font-size: 1.2em;
		}
	'
]

{ #category : #initialization }
CpCounterClientBehavior >> initialize [

	super initialize.

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: self class introStyle ;
		yourself).
	CpHtmlElement documentBody markupContent: self class introHtml
]
