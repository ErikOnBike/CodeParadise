Class {
	#name : #IonInfiniteScroll,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonInfiniteScroll >> complete [

	"Call 'complete()' within the 'ionInfinite' output event handler when your async operation has completed. For example, the 'loading' state is while the app is performing an asynchronous operation, such as receiving more data from an AJAX request to add more items to a data list. Once the data has been received and UI updated, you then call this method to signify that the loading has completed. This method will change the infinite scroll's state from 'loading' to 'enabled'.
	
	Type: Promise<void>"

	^ self apply: #complete resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonInfiniteScroll >> disabled [

	"If 'true', the infinite scroll will be hidden and scroll event listeners will be removed.  Set this to true to disable the infinite scroll from actively trying to receive new data while scrolling. This is useful when it is known that there is no more data that can be added, and the infinite scroll is no longer needed.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonInfiniteScroll >> disabled: aBoolean [

	"If 'true', the infinite scroll will be hidden and scroll event listeners will be removed.  Set this to true to disable the infinite scroll from actively trying to receive new data while scrolling. This is useful when it is known that there is no more data that can be added, and the infinite scroll is no longer needed.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonInfiniteScroll >> position [

	"The position of the infinite scroll element. The value can be either 'top' or 'bottom'.
	
	Type: 'top' | 'bottom'"

	^ self propertyAt: #position
]

{ #category : #api }
IonInfiniteScroll >> position: aString [

	"The position of the infinite scroll element. The value can be either 'top' or 'bottom'.
	
	Type: 'top' | 'bottom'"

	self propertyAt: #position put: aString
]

{ #category : #api }
IonInfiniteScroll >> threshold [

	"The threshold distance from the bottom of the content to call the 'infinite' output event when scrolled. The threshold value can be either a percent, or in pixels. For example, use the value of '10%' for the 'infinite' output event to get called when the user has scrolled 10% from the bottom of the page. Use the value '100px' when the scroll is within 100 pixels from the bottom of the page.
	
	Type: string"

	^ self propertyAt: #threshold
]

{ #category : #api }
IonInfiniteScroll >> threshold: aString [

	"The threshold distance from the bottom of the content to call the 'infinite' output event when scrolled. The threshold value can be either a percent, or in pixels. For example, use the value of '10%' for the 'infinite' output event to get called when the user has scrolled 10% from the bottom of the page. Use the value '100px' when the scroll is within 100 pixels from the bottom of the page.
	
	Type: string"

	self propertyAt: #threshold put: aString
]
