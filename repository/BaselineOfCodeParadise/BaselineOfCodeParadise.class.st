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
			package: 'CodeParadise-RemoteEnvironment' with: [ spec requires: #('ZincHTTPComponents') ];
			package: 'CodeParadise-WebApplication' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];
			package: 'CodeParadise-WebApplication-MVP' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-WebApplication-Fomantic' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-Beach' with: [ spec requires: #('CodeParadise-WebApplication') ].

		"Pharo 9.x specific"
		spec for: #'pharo9.x' do: [ spec package: 'CodeParadise-RemoteEnvironment-Pharo9' ] ]
]
