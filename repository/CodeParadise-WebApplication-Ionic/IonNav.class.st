Class {
	#name : #IonNav,
	#superclass : #IonElement,
	#category : #'CodeParadise-WebApplication-Ionic-Elements'
}

{ #category : #api }
IonNav >> animated [

	"If 'true', the nav should animate the transition of components.
	
	Type: boolean"

	^ self propertyAt: #animated
]

{ #category : #api }
IonNav >> animated: aBoolean [

	"If 'true', the nav should animate the transition of components.
	
	Type: boolean"

	self propertyAt: #animated put: aBoolean
]

{ #category : #api }
IonNav >> animation [

	"By default 'ion-nav' animates transition between pages based in the mode (ios or material design). However, this property allows to create custom transition using 'AnimationBuilder' functions.
	
	Type: AnimationBuilder"

	^ self propertyAt: #animation
]

{ #category : #api }
IonNav >> animation: anObject [

	"By default 'ion-nav' animates transition between pages based in the mode (ios or material design). However, this property allows to create custom transition using 'AnimationBuilder' functions.
	
	Type: AnimationBuilder"

	self propertyAt: #animation put: anObject
]

{ #category : #api }
IonNav >> canGoBack [

	"Returns 'true' if the current view can go back.
	@param view The view to check.
	
	Type: (view?: ViewController) => Promise<boolean>"

	^ self apply: #canGoBack resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> canGoBack: view [

	"Returns 'true' if the current view can go back.
	@param view The view to check.
	
	Type: (view?: ViewController) => Promise<boolean>"

	^ self apply: #canGoBack withArguments: { view } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> delegate [

	"Type: FrameworkDelegate"

	^ self propertyAt: #delegate
]

{ #category : #api }
IonNav >> delegate: anObject [

	"Type: FrameworkDelegate"

	self propertyAt: #delegate put: anObject
]

{ #category : #api }
IonNav >> getActive [

	"Get the active view.
	
	Type: Promise<ViewController | undefined>"

	^ self apply: #getActive resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> getByIndex: index [

	"Get the view at the specified index.
	@param index The index of the view.
	
	Type: (index: number) => Promise<ViewController | undefined>"

	^ self apply: #getByIndex withArguments: { index } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> getLength [

	"Returns the number of views in the stack.
	
	Type: Promise<number>"

	^ self apply: #getLength resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> getPrevious [

	"Get the previous view.
	@param view The view to get.
	
	Type: (view?: ViewController) => Promise<ViewController | undefined>"

	^ self apply: #getPrevious resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> getPrevious: view [

	"Get the previous view.
	@param view The view to get.
	
	Type: (view?: ViewController) => Promise<ViewController | undefined>"

	^ self apply: #getPrevious withArguments: { view } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> getRouteId [

	"Called by <ion-router> to retrieve the current component.
	
	Type: Promise<RouteID | undefined>"

	^ self apply: #getRouteId resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insert: insertIndex component: component [

	"Inserts a component into the navigation stack at the specified index. This is useful to add a component at any point in the navigation stack.
	@param insertIndex The index to insert the component at in the stack.
	@param component The component to insert into the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(insertIndex: number, component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insert withArguments: { insertIndex . component } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insert: insertIndex component: component componentProps: componentProps [

	"Inserts a component into the navigation stack at the specified index. This is useful to add a component at any point in the navigation stack.
	@param insertIndex The index to insert the component at in the stack.
	@param component The component to insert into the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(insertIndex: number, component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insert withArguments: { insertIndex . component . componentProps } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insert: insertIndex component: component componentProps: componentProps opts: opts [

	"Inserts a component into the navigation stack at the specified index. This is useful to add a component at any point in the navigation stack.
	@param insertIndex The index to insert the component at in the stack.
	@param component The component to insert into the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(insertIndex: number, component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insert withArguments: { insertIndex . component . componentProps . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insert: insertIndex component: component componentProps: componentProps opts: opts done: done [

	"Inserts a component into the navigation stack at the specified index. This is useful to add a component at any point in the navigation stack.
	@param insertIndex The index to insert the component at in the stack.
	@param component The component to insert into the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(insertIndex: number, component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insert withArguments: { insertIndex . component . componentProps . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insertPages: insertIndex insertComponents: insertComponents [

	"Inserts an array of components into the navigation stack at the specified index. The last component in the array will become instantiated as a view, and animate in to become the active view.
	@param insertIndex The index to insert the components at in the stack.
	@param insertComponents The components to insert into the navigation stack.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (insertIndex: number, insertComponents: NavComponent[] | NavComponentWithProps[], opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insertPages withArguments: { insertIndex . insertComponents } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insertPages: insertIndex insertComponents: insertComponents opts: opts [

	"Inserts an array of components into the navigation stack at the specified index. The last component in the array will become instantiated as a view, and animate in to become the active view.
	@param insertIndex The index to insert the components at in the stack.
	@param insertComponents The components to insert into the navigation stack.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (insertIndex: number, insertComponents: NavComponent[] | NavComponentWithProps[], opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insertPages withArguments: { insertIndex . insertComponents . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> insertPages: insertIndex insertComponents: insertComponents opts: opts done: done [

	"Inserts an array of components into the navigation stack at the specified index. The last component in the array will become instantiated as a view, and animate in to become the active view.
	@param insertIndex The index to insert the components at in the stack.
	@param insertComponents The components to insert into the navigation stack.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (insertIndex: number, insertComponents: NavComponent[] | NavComponentWithProps[], opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #insertPages withArguments: { insertIndex . insertComponents . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> pop [

	"Pop a component off of the navigation stack. Navigates back from the current component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #pop resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> pop: opts [

	"Pop a component off of the navigation stack. Navigates back from the current component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #pop withArguments: { opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> pop: opts done: done [

	"Pop a component off of the navigation stack. Navigates back from the current component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #pop withArguments: { opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> popTo: indexOrViewCtrl [

	"Pop to a specific index in the navigation stack.
	@param indexOrViewCtrl The index or view controller to pop to.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (indexOrViewCtrl: number | ViewController, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #popTo withArguments: { indexOrViewCtrl } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> popTo: indexOrViewCtrl opts: opts [

	"Pop to a specific index in the navigation stack.
	@param indexOrViewCtrl The index or view controller to pop to.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (indexOrViewCtrl: number | ViewController, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #popTo withArguments: { indexOrViewCtrl . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> popTo: indexOrViewCtrl opts: opts done: done [

	"Pop to a specific index in the navigation stack.
	@param indexOrViewCtrl The index or view controller to pop to.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (indexOrViewCtrl: number | ViewController, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #popTo withArguments: { indexOrViewCtrl . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> popToRoot [

	"Navigate back to the root of the stack, no matter how far back that is.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #popToRoot resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> popToRoot: opts [

	"Navigate back to the root of the stack, no matter how far back that is.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #popToRoot withArguments: { opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> popToRoot: opts done: done [

	"Navigate back to the root of the stack, no matter how far back that is.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #popToRoot withArguments: { opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> push: component [

	"Push a new component onto the current navigation stack. Pass any additional information along as an object. This additional information is accessible through NavParams.
	@param component The component to push onto the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #push withArguments: { component } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> push: component componentProps: componentProps [

	"Push a new component onto the current navigation stack. Pass any additional information along as an object. This additional information is accessible through NavParams.
	@param component The component to push onto the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #push withArguments: { component . componentProps } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> push: component componentProps: componentProps opts: opts [

	"Push a new component onto the current navigation stack. Pass any additional information along as an object. This additional information is accessible through NavParams.
	@param component The component to push onto the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #push withArguments: { component . componentProps . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> push: component componentProps: componentProps opts: opts done: done [

	"Push a new component onto the current navigation stack. Pass any additional information along as an object. This additional information is accessible through NavParams.
	@param component The component to push onto the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #push withArguments: { component . componentProps . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #actions }
IonNav >> push: anElement withOptions: aDictionary [

	"Description	:
		Push a new component onto the current navigation stack. Pass any additional information along as an object. This additional information is accessible through NavParams.
	Signature	:
		push<T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #push withArguments: { anElement . aDictionary }
]

{ #category : #api }
IonNav >> removeIndex: startIndex [

	"Removes a component from the navigation stack at the specified index.
	@param startIndex The number to begin removal at.
	@param removeCount The number of components to remove.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (startIndex: number, removeCount?: number, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #removeIndex withArguments: { startIndex } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> removeIndex: startIndex removeCount: removeCount [

	"Removes a component from the navigation stack at the specified index.
	@param startIndex The number to begin removal at.
	@param removeCount The number of components to remove.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (startIndex: number, removeCount?: number, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #removeIndex withArguments: { startIndex . removeCount } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> removeIndex: startIndex removeCount: removeCount opts: opts [

	"Removes a component from the navigation stack at the specified index.
	@param startIndex The number to begin removal at.
	@param removeCount The number of components to remove.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (startIndex: number, removeCount?: number, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #removeIndex withArguments: { startIndex . removeCount . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> removeIndex: startIndex removeCount: removeCount opts: opts done: done [

	"Removes a component from the navigation stack at the specified index.
	@param startIndex The number to begin removal at.
	@param removeCount The number of components to remove.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (startIndex: number, removeCount?: number, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #removeIndex withArguments: { startIndex . removeCount . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> root [

	"Root NavComponent to load
	
	Type: NavComponent"

	^ self propertyAt: #root
]

{ #category : #api }
IonNav >> root: anObject [

	"Root NavComponent to load
	
	Type: NavComponent"

	self propertyAt: #root put: anObject
]

{ #category : #api }
IonNav >> rootParams [

	"Any parameters for the root component
	
	Type: ComponentProps"

	^ self propertyAt: #rootParams
]

{ #category : #api }
IonNav >> rootParams: anObject [

	"Any parameters for the root component
	
	Type: ComponentProps"

	self propertyAt: #rootParams put: anObject
]

{ #category : #api }
IonNav >> setPages: views [

	"Set the views of the current navigation stack and navigate to the last view. By default animations are disabled, but they can be enabled by passing options to the navigation controller. Navigation parameters can also be passed to the individual pages in the array.
	@param views The list of views to set as the navigation stack.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (views: NavComponent[] | NavComponentWithProps[], opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setPages withArguments: { views } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setPages: views opts: opts [

	"Set the views of the current navigation stack and navigate to the last view. By default animations are disabled, but they can be enabled by passing options to the navigation controller. Navigation parameters can also be passed to the individual pages in the array.
	@param views The list of views to set as the navigation stack.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (views: NavComponent[] | NavComponentWithProps[], opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setPages withArguments: { views . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setPages: views opts: opts done: done [

	"Set the views of the current navigation stack and navigate to the last view. By default animations are disabled, but they can be enabled by passing options to the navigation controller. Navigation parameters can also be passed to the individual pages in the array.
	@param views The list of views to set as the navigation stack.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: (views: NavComponent[] | NavComponentWithProps[], opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setPages withArguments: { views . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setRoot: component [

	"Set the root for the current navigation stack to a component.
	@param component The component to set as the root of the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setRoot withArguments: { component } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setRoot: component componentProps: componentProps [

	"Set the root for the current navigation stack to a component.
	@param component The component to set as the root of the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setRoot withArguments: { component . componentProps } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setRoot: component componentProps: componentProps opts: opts [

	"Set the root for the current navigation stack to a component.
	@param component The component to set as the root of the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setRoot withArguments: { component . componentProps . opts } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setRoot: component componentProps: componentProps opts: opts done: done [

	"Set the root for the current navigation stack to a component.
	@param component The component to set as the root of the navigation stack.
	@param componentProps Any properties of the component.
	@param opts The navigation options.
	@param done The transition complete function.
	
	Type: <T extends NavComponent>(component: T, componentProps?: ComponentProps<T> | null, opts?: NavOptions | null, done?: TransitionDoneFn) => Promise<boolean>"

	^ self apply: #setRoot withArguments: { component . componentProps . opts . done } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setRouteId: id params: params direction: direction [

	"Called by the router to update the view.
	@param id The component tag.
	@param params The component params.
	@param direction A direction hint.
	@param animation an AnimationBuilder.
	@return the status.
	
	Type: (id: string, params: ComponentProps | undefined, direction: RouterDirection, animation?: AnimationBuilder) => Promise<RouteWrite>"

	^ self apply: #setRouteId withArguments: { id . params . direction } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> setRouteId: id params: params direction: direction animation: animation [

	"Called by the router to update the view.
	@param id The component tag.
	@param params The component params.
	@param direction A direction hint.
	@param animation an AnimationBuilder.
	@return the status.
	
	Type: (id: string, params: ComponentProps | undefined, direction: RouterDirection, animation?: AnimationBuilder) => Promise<RouteWrite>"

	^ self apply: #setRouteId withArguments: { id . params . direction . animation } resultAs: CpJavaScriptPromise
]

{ #category : #api }
IonNav >> swipeGesture [

	"If the nav component should allow for swipe-to-go-back.
	
	Type: boolean"

	^ self propertyAt: #swipeGesture
]

{ #category : #api }
IonNav >> swipeGesture: aBoolean [

	"If the nav component should allow for swipe-to-go-back.
	
	Type: boolean"

	self propertyAt: #swipeGesture put: aBoolean
]
