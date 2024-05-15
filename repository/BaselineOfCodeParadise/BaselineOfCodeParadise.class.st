Class {
	#name : 'BaselineOfCodeParadise',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCodeParadise',
	#package : 'BaselineOfCodeParadise'
}

{ #category : 'baselines' }
BaselineOfCodeParadise >> baseline: spec [

	<baseline>

	spec for: #common do: [

		"Dependencies"
		spec
			baseline: 'ZincHTTPComponents' with: [ spec loads: #('Core' 'WebSocket') ; repository: 'github://svenvc/zinc:v5' ].

		"Packages"
		spec
			package: 'CodeParadise-RemoteEnvironment' with: [ spec requires: #('CpClientEnvironment' 'ZincHTTPComponents') ];
			package: 'CodeParadise-WebApplication' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];
			package: 'CodeParadise-Browser-Support' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-NodeJS-Support' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];

			package: 'CodeParadise-WebApplication-MVP' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-WebApplication-Shoelace' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-Presentation' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-WebApplication-ChartJS' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-Beach' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];

			"2022-06: No longer maintained"
			package: 'CodeParadise-WebApplication-Fomantic' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-WebApplication-Snapshot' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-WebApplication-Development' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-WebApplication-Debugger' with: [ spec requires: #('CodeParadise-WebApplication') ].

		spec
			package: 'CodeParadise-RemoteEnvironment-Tests' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];
			package: 'CodeParadise-WebApplication-Tests' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-Beach-Tests' with: [ spec requires: #('CodeParadise-Beach') ].

		"Groups"
		spec 
			group: 'default' with: #( 'Core' 'Shoelace' 'ChartJS' 'Presentation' 'Beach' 'Snapshot' 'Tests' 'Development');

			group: 'Core' with: #( 'CodeParadise-WebApplication' 'CodeParadise-Browser-Support' 'CodeParadise-NodeJS-Support' );
			group: 'Tests' with: #( 'CodeParadise-WebApplication-Tests' 'CodeParadise-RemoteEnvironment-Tests' 'CodeParadise-Beach-Tests' );

			group: 'MVP' with: #( 'CodeParadise-WebApplication-MVP' );

			group: 'Shoelace' with: #( 'CodeParadise-WebApplication-Shoelace' );
			group: 'ChartJS' with: #( 'CodeParadise-WebApplication-ChartJS' );
			group: 'Presentation' with: #( 'CodeParadise-WebApplication-Presentation' );
			group: 'Beach' with: #( 'CodeParadise-Beach' );

			"2022-06: No longer maintained (needs to be loaded manually)"
			group: 'Fomantic' with: #( 'CodeParadise-WebApplication-Fomantic' );

			group: 'Snapshot' with: #( 'CodeParadise-WebApplication-Snapshot' );

			group: 'Development' with: #( 'CodeParadise-WebApplication-Development' 'CodeParadise-WebApplication-Debugger' );

			group: 'CI' with: #( 'Tests' ) ].

	"Pharo 8.x specific"
	spec for: #(#'pharo8.x') do: [
		spec
			"For Pharo 8 we need a Client Environment with a tiny image based on older pre-Sista bytecode set"
			baseline: 'CpClientEnvironment' with: [ spec repository: 'github://ErikOnBike/CP-ClientEnvironment:pharo8' ] ].

	"Pharo 9.x (and upward) specific"
	spec for: #(#'pharo9.x' #'pharo10.x' #'pharo11.x' #'pharo12.x') do: [
		spec
			"For Pharo 9 (and above) we need a Client Environment with a tiny image based on the newer Sista bytecode set"
			baseline: 'CpClientEnvironment' with: [ spec repository: 'github://ErikOnBike/CP-ClientEnvironment' ] ;
			package: 'CodeParadise-RemoteEnvironment' with: [ spec includes: 'CodeParadise-RemoteEnvironment-Pharo9' ] ;
			package: 'CodeParadise-RemoteEnvironment-Pharo9' with: [ spec requires: 'CodeParadise-RemoteEnvironment' ] ].

	"Pharo 11.x (and upward) specific"
	spec for: #(#'pharo11.x' #'pharo12.x') do: [
		spec
			package: 'CodeParadise-RemoteEnvironment' with: [ spec includes: 'CodeParadise-RemoteEnvironment-Pharo11' ] ;
			package: 'CodeParadise-RemoteEnvironment-Pharo11' with: [ spec requires: 'CodeParadise-RemoteEnvironment' ] ].
]
