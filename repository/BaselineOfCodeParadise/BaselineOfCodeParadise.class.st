Class {
	#name : #BaselineOfCodeParadise,
	#superclass : #BaselineOf,
	#category : #BaselineOfCodeParadise
}

{ #category : #baselines }
BaselineOfCodeParadise >> baseline: spec [

	<baseline>

	spec for: #common do: [

		"Dependencies"
		spec
			baseline: 'ZincHTTPComponents' with: [ spec loads: #('Core' 'WebSocket') ; repository: 'github://svenvc/zinc' ].

		"Packages"
		spec
			package: 'RemoteEnvironment' ;
			package: 'WebApplication' with: [ spec requires: 'RemoteEnvironment' ].

		"Pharo 9.x specific"
		spec for: #'pharo9.x' do: [ spec package: 'RemoteEnvironment-Pharo9' ] ]
]
