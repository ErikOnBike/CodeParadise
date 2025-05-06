"
I am the Submit event which triggers when a form is submitted.
A HTML form will typically submit a form by sending a request to the server.
On CodeParadise applications this is often not wanted. To prevent such default
behavior the submit event's default behavior can be prevented.

Do add both a specific and prevent default handling the following can be used
from inside a DOM component (WebComponent or View):
```
	myForm
		when: CpSubmitEvent send: #handleFormSubmit to: self ;
		when: CpSubmitEvent send: #preventDefault: to: self
```

(from outside a DOM component, replace the reference to 'self' with an appropriate
reference to a DOM component or use a Block instead of message send)
"
Class {
	#name : #CpSubmitEvent,
	#superclass : #CpEvent,
	#category : #'CodeParadise-WebApplication-Events'
}

{ #category : #'as yet unclassified' }
CpSubmitEvent >> submitter [

	"An HTMLElement object which identifies the button or other element which was invoked to trigger the form being submitted."

	^ self propertyAt: #submitter
]
