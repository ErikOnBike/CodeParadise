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
			baseline: 'ZincHTTPComponents' with: [ spec loads: #('Core' 'WebSocket') ; repository: 'https://github.com/svenvc/zinc' ].

		"Packages"
		spec
			package: 'RemoteEnvironment' ;
			package: 'WebApplication' with: [ spec requires: 'RemoteEnvironment' ] ]
]
