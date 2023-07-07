Class {
	#name : #CodeParadisePharo9Support,
	#superclass : #Object,
	#category : #'CodeParadise-RemoteEnvironment-Pharo9'
}

{ #category : #initialization }
CodeParadisePharo9Support class >> initialize [

	"Add Pharo9 (and up) specific classes"

	CpClientEnvironment preInstalledClasses
		add: CleanBlockClosure
]
