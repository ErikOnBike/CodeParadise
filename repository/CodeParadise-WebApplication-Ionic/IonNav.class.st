Class {
	#name : #IonNav,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #actions }
IonNav >> push: anElement [

	^ self push: anElement withOptions: nil
]

{ #category : #actions }
IonNav >> push: anElement withOptions: aDictionary [

	"Description	:
		Push a new component onto the current navigation stack. Pass any additional information along as an object. This additional information is accessible through NavParams.
	Signature	:
		push<T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #push withArguments: { anElement . aDictionary }
]
