Class {
	#name : 'CodeParadisePharo11Support',
	#superclass : 'Object',
	#category : 'CodeParadise-RemoteEnvironment-Pharo11',
	#package : 'CodeParadise-RemoteEnvironment-Pharo11'
}

{ #category : 'initialization' }
CodeParadisePharo11Support class >> initialize [

	"Add Pharo9 (and up) specific classes"

	CpClientEnvironment preInstalledClasses
		add: ConstantBlockClosure
]
