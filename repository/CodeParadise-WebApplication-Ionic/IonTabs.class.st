Class {
	#name : #IonTabs,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonTabs >> getRouteId [

	"Type: Promise<RouteID | undefined>"

	^ self apply: #getRouteId resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTabs >> getSelected [

	"Get the currently selected tab. This method is only available for vanilla JavaScript projects. The Angular, React, and Vue implementations of tabs are coupled to each framework's router.
	
	Type: Promise<string | undefined>"

	^ self apply: #getSelected resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTabs >> getTab: tab [

	"Get a specific tab by the value of its 'tab' property or an element reference. This method is only available for vanilla JavaScript projects. The Angular, React, and Vue implementations of tabs are coupled to each framework's router.
	@param tab The tab instance to select. If passed a string, it should be the value of the tab's 'tab' property.
	
	Type: (tab: string | HTMLIonTabElement) => Promise<HTMLIonTabElement | undefined>"

	^ self apply: #getTab withArguments: { tab } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTabs >> select: tab [

	"Select a tab by the value of its 'tab' property or an element reference. This method is only available for vanilla JavaScript projects. The Angular, React, and Vue implementations of tabs are coupled to each framework's router.
	@param tab The tab instance to select. If passed a string, it should be the value of the tab's 'tab' property.
	
	Type: (tab: string | HTMLIonTabElement) => Promise<boolean>"

	^ self apply: #select withArguments: { tab } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTabs >> setRouteId: id [

	"Type: (id: string) => Promise<RouteWrite>"

	^ self apply: #setRouteId withArguments: { id } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonTabs >> useRouter [

	"Type: boolean"

	^ self propertyAt: #useRouter
]

{ #category : #api }
IonTabs >> useRouter: aBoolean [

	"Type: boolean"

	self propertyAt: #useRouter put: aBoolean
]
