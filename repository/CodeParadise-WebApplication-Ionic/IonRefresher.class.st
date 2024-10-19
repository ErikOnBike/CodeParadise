Class {
	#name : #IonRefresher,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonRefresher >> cancel [

	"Changes the refresher's state from 'refreshing' to 'cancelling'.
	
	Type: Promise<void>"

	^ self apply: #cancel resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRefresher >> closeDuration [

	"Time it takes to close the refresher. Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: string"

	^ self propertyAt: #closeDuration
]

{ #category : #api }
IonRefresher >> closeDuration: aString [

	"Time it takes to close the refresher. Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: string"

	self propertyAt: #closeDuration put: aString
]

{ #category : #api }
IonRefresher >> complete [

	"Call 'complete()' when your async operation has completed. For example, the 'refreshing' state is while the app is performing an asynchronous operation, such as receiving more data from an AJAX request. Once the data has been received, you then call this method to signify that the refreshing has completed and to close the refresher. This method also changes the refresher's state from 'refreshing' to 'completing'.
	
	Type: Promise<void>"

	^ self apply: #complete resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRefresher >> disabled [

	"If 'true', the refresher will be hidden.
	
	Type: boolean"

	^ self propertyAt: #disabled
]

{ #category : #api }
IonRefresher >> disabled: aBoolean [

	"If 'true', the refresher will be hidden.
	
	Type: boolean"

	self propertyAt: #disabled put: aBoolean
]

{ #category : #api }
IonRefresher >> getProgress [

	"A number representing how far down the user has pulled. The number '0' represents the user hasn't pulled down at all. The number '1', and anything greater than '1', represents that the user has pulled far enough down that when they let go then the refresh will happen. If they let go and the number is less than '1', then the refresh will not happen, and the content will return to it's original position.
	
	Type: Promise<number>"

	^ self apply: #getProgress resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonRefresher >> mode [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	^ self propertyAt: #mode
]

{ #category : #api }
IonRefresher >> mode: aString [

	"The mode determines which platform styles to use.
	
	Type: 'ios' | 'md'"

	self propertyAt: #mode put: aString
]

{ #category : #api }
IonRefresher >> pullFactor [

	"How much to multiply the pull speed by. To slow the pull animation down, pass a number less than '1'. To speed up the pull, pass a number greater than '1'. The default value is '1' which is equal to the speed of the cursor. If a negative value is passed in, the factor will be '1' instead.  For example: If the value passed is '1.2' and the content is dragged by '10' pixels, instead of '10' pixels the content will be pulled by '12' pixels (an increase of 20 percent). If the value passed is '0.8', the dragged amount will be '8' pixels, less than the amount the cursor has moved.  Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: number"

	^ self propertyAt: #pullFactor
]

{ #category : #api }
IonRefresher >> pullFactor: aNumber [

	"How much to multiply the pull speed by. To slow the pull animation down, pass a number less than '1'. To speed up the pull, pass a number greater than '1'. The default value is '1' which is equal to the speed of the cursor. If a negative value is passed in, the factor will be '1' instead.  For example: If the value passed is '1.2' and the content is dragged by '10' pixels, instead of '10' pixels the content will be pulled by '12' pixels (an increase of 20 percent). If the value passed is '0.8', the dragged amount will be '8' pixels, less than the amount the cursor has moved.  Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: number"

	self propertyAt: #pullFactor put: aNumber
]

{ #category : #api }
IonRefresher >> pullMax [

	"The maximum distance of the pull until the refresher will automatically go into the 'refreshing' state. Defaults to the result of 'pullMin + 60'. Does not apply when  the refresher content uses a spinner, enabling the native refresher.
	
	Type: number"

	^ self propertyAt: #pullMax
]

{ #category : #api }
IonRefresher >> pullMax: aNumber [

	"The maximum distance of the pull until the refresher will automatically go into the 'refreshing' state. Defaults to the result of 'pullMin + 60'. Does not apply when  the refresher content uses a spinner, enabling the native refresher.
	
	Type: number"

	self propertyAt: #pullMax put: aNumber
]

{ #category : #api }
IonRefresher >> pullMin [

	"The minimum distance the user must pull down until the refresher will go into the 'refreshing' state. Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: number"

	^ self propertyAt: #pullMin
]

{ #category : #api }
IonRefresher >> pullMin: aNumber [

	"The minimum distance the user must pull down until the refresher will go into the 'refreshing' state. Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: number"

	self propertyAt: #pullMin put: aNumber
]

{ #category : #api }
IonRefresher >> snapbackDuration [

	"Time it takes the refresher to snap back to the 'refreshing' state. Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: string"

	^ self propertyAt: #snapbackDuration
]

{ #category : #api }
IonRefresher >> snapbackDuration: aString [

	"Time it takes the refresher to snap back to the 'refreshing' state. Does not apply when the refresher content uses a spinner, enabling the native refresher.
	
	Type: string"

	self propertyAt: #snapbackDuration put: aString
]
