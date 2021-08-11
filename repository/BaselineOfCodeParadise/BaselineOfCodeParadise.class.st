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

			package: 'CodeParadise-WebApplication-Shoelace' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-Fomantic' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-Presentation' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-Beach' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ].

		spec
			package: 'CodeParadise-RemoteEnvironment-Tests' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];
			package: 'CodeParadise-WebApplication-Tests' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-Beach-Tests' with: [ spec requires: #('CodeParadise-Beach') ].

		"Pharo 9.x specific"
		spec for: #'pharo9.x' do: [ spec package: 'CodeParadise-RemoteEnvironment-Pharo9' ].

		"Groups"
		spec 
			group: 'default' with: #( 'Core' 'Shoelace' 'Fomantic' 'Presentation' 'Beach' 'Tests' );

			group: 'Core' with: #( 'CodeParadise-WebApplication' );
			group: 'Tests' with: #( 'CodeParadise-WebApplication-Tests' 'CodeParadise-RemoteEnvironment-Tests' 'CodeParadise-WebApplication-Beach-Tests' );

			group: 'MVP' with: #( 'CodeParadise-WebApplication-MVP' );

			group: 'Shoelace' with: #( 'CodeParadise-WebApplication-Shoelace' );
			group: 'Fomantic' with: #( 'CodeParadise-WebApplication-Fomantic' );
			group: 'Presentation' with: #( 'CodeParadise-WebApplication-Presentation' );
			group: 'Beach' with: #( 'CodeParadise-WebApplication-Beach' );

			group: 'CI' with: #( 'Tests' ).
	 ]
]
