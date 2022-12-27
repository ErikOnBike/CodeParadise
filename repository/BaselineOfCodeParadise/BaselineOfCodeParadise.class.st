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
			baseline: 'CpClientEnvironment' with: [ spec repository: 'github://ErikOnBike/CP-ClientEnvironment' ];
			baseline: 'ZincHTTPComponents' with: [ spec loads: #('Core' 'WebSocket') ; repository: 'github://svenvc/zinc' ].

		"Packages"
		spec
			package: 'CodeParadise-RemoteEnvironment' with: [ spec requires: #('CpClientEnvironment' 'ZincHTTPComponents') ];
			package: 'CodeParadise-WebApplication' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];

			package: 'CodeParadise-WebApplication-MVP' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-WebApplication-Shoelace' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-Fomantic' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-Presentation' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-ChartJS' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-Beach' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ].

		spec
			package: 'CodeParadise-RemoteEnvironment-Tests' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];
			package: 'CodeParadise-WebApplication-Tests' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-Beach-Tests' with: [ spec requires: #('CodeParadise-Beach') ].

		"Groups"
		spec 
			group: 'default' with: #( 'Core' 'Shoelace' 'Fomantic' 'ChartJS' 'Presentation' 'Beach' 'Tests' );

			group: 'Core' with: #( 'CodeParadise-WebApplication' );
			group: 'Tests' with: #( 'CodeParadise-WebApplication-Tests' 'CodeParadise-RemoteEnvironment-Tests' 'CodeParadise-Beach-Tests' );

			group: 'MVP' with: #( 'CodeParadise-WebApplication-MVP' );

			group: 'Shoelace' with: #( 'CodeParadise-WebApplication-Shoelace' );
			group: 'Fomantic' with: #( 'CodeParadise-WebApplication-Fomantic' );
			group: 'ChartJS' with: #( 'CodeParadise-WebApplication-ChartJS' );
			group: 'Presentation' with: #( 'CodeParadise-WebApplication-Presentation' );
			group: 'Beach' with: #( 'CodeParadise-Beach' );

			group: 'CI' with: #( 'Tests' ) ].

	"Pharo 9.x, 10.x and 11.x specific"
	spec for: #(#'pharo9.x' #'pharo10.x' #'pharo11.x') do: [
		spec
			package: 'CodeParadise-RemoteEnvironment-Pharo9' ;
			package: 'CodeParadise-RemoteEnvironment' with: [ spec requires: 'CodeParadise-RemoteEnvironment-Pharo9' ] ]
]
