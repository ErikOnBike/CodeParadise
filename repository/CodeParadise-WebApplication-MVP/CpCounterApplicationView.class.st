Class {
	#name : #CpCounterApplicationView,
	#superclass : #CpView,
	#category : #'CodeParadise-WebApplication-MVP-Examples'
}

{ #category : #'web resources' }
CpCounterApplicationView class >> style [

	<webResource: #css>

	^ ':host {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}
		#container {
			padding: 1em 4em 2em 4em;
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

{ #category : #'web resources' }
CpCounterApplicationView class >> template [

	<webResource: #html>

	^ '<div id="container">
	<h2>Basic counter example</h2>
	<p>
	This is a very basic counter example. It shows two counters. One is attached to a global Counter Model and the other to a client specific Counter Model. If you change the first Counter (by pressing the increase/decrease buttons) all other browser tabs open on this same Counter Example will also update their value. Try it out! It will probably also run on your mobile ;-).
	</p>
	<slot name="global"></slot>
	<slot name="local"></slot>
	<h2>It looks horrible!</h2>
	<p>
	Don''t you like the simplistic look of the counters? Well go over to the Class <code>CpCounterView</code> and change the CSS style or HTML template. As soon as you save a change in either the <code>#style</code> or the <code>#template</code> method, it will become visible instantaneous in this page (and all other pages showing the Counter Example). That''s coding in Smalltalk style!
	</p>
	</div>'
]
