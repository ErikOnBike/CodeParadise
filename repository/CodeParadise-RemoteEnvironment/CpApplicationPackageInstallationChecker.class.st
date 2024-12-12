Class {
	#name : #CpApplicationPackageInstallationChecker,
	#superclass : #CpPackageInstallationChecker,
	#instVars : [
		'applicationClass'
	],
	#category : #'CodeParadise-RemoteEnvironment-Support'
}

{ #category : #'instance creation' }
CpApplicationPackageInstallationChecker class >> applicationClass: anApplicationClass [

	^ self basicNew
		initializeWithApplicationClass: anApplicationClass ;
		yourself
]

{ #category : #'instance creation' }
CpApplicationPackageInstallationChecker class >> new [

	self errorNewReplacedBy: #applicationClass:
]

{ #category : #initialization }
CpApplicationPackageInstallationChecker >> initializeWithApplicationClass: anApplicationClass [

	self initializeWithPackages: anApplicationClass allowedPackages.

	applicationClass := anApplicationClass.

	"Ensure the receiver reacts to methods being changed"
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded, MethodModified, MethodRemoved
		send: #methodChanged: to: self
]

{ #category : #updating }
CpApplicationPackageInstallationChecker >> methodChanged: anAnnouncement [

	"If the #allowedPackages method has changed, update the packages of the receiver.

	Implementation:
	The current implementation does not try to figure out if the #allowedPackages
	method is actually related to the Application class of the receiver. It simply
	updates the packages. During regular development this should not have much
	impact."

	| method |

	method := anAnnouncement method.
	method ifNil: [ ^ self ].

	method selector = #allowedPackages
		ifFalse: [ ^ self ].

	packages := applicationClass allowedPackages
]
