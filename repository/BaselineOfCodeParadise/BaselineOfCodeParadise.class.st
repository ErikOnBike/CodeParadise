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
			baseline: 'ZincHTTPComponents' with: [ spec loads: #('Core' 'WebSocket') ; repository: 'github://svenvc/zinc:v5' ].

		"Packages"
		spec
			package: 'CodeParadise-RemoteEnvironment' with: [ spec requires: #('CpClientEnvironment' 'ZincHTTPComponents') ];
			package: 'CodeParadise-JavaScript' ;
			package: 'CodeParadise-WebApplication' with: [ spec requires: #('CodeParadise-RemoteEnvironment' 'CodeParadise-JavaScript') ];
			package: 'CodeParadise-Browser-Support' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-WebApplication-Snapshot' with: [ spec requires: #('CodeParadise-Browser-Support') ];

			package: 'CodeParadise-NodeJS-Support' with: [ spec requires: #('CodeParadise-RemoteEnvironment' 'CodeParadise-JavaScript') ];
			package: 'CodeParadise-NodeJS-REST' with: [ spec requires: #('CodeParadise-NodeJS-Support') ];
			package: 'CodeParadise-NodeJS-Sqlite3' with: [ spec requires: #('CodeParadise-NodeJS-Support') ];
			package: 'CodeParadise-NodeJS-Nodemailer' with: [ spec requires: #('CodeParadise-NodeJS-Support') ];

			package: 'CodeParadise-WebApplication-MVP' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-WebApplication-Shoelace' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-WebApplication-Ionic' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-WebApplication-ChartJS' with: [ spec requires: #('CodeParadise-WebApplication') ];

			"2022-06: No longer maintained"
			package: 'CodeParadise-WebApplication-Fomantic' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-WebApplication-Presentation' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];
			package: 'CodeParadise-Beach' with: [ spec requires: #('CodeParadise-WebApplication-MVP') ];

			package: 'CodeParadise-WebApplication-Development' with: [ spec requires: #('CodeParadise-WebApplication') ];
			package: 'CodeParadise-WebApplication-Debugger' with: [ spec requires: #('CodeParadise-WebApplication') ].

		spec
			package: 'CodeParadise-RemoteEnvironment-Tests' with: [ spec requires: #('CodeParadise-RemoteEnvironment') ];
			package: 'CodeParadise-WebApplication-Tests' with: [ spec requires: #('CodeParadise-WebApplication') ];

			package: 'CodeParadise-Beach-Tests' with: [ spec requires: #('CodeParadise-Beach') ].

		"Groups"
		spec 
			group: 'default' with: #( 'Core' 'NodeJS-Core' 'Shoelace' 'Ionic' 'ChartJS' 'Presentation' 'Snapshot' 'Tests' 'Development' 'NodeJS-Applications');

			group: 'Core' with: #( 'CodeParadise-Browser-Support' );
			group: 'NodeJS-Core' with: #( 'CodeParadise-NodeJS-Support' );
			group: 'Tests' with: #( 'CodeParadise-WebApplication-Tests' 'CodeParadise-RemoteEnvironment-Tests' );

			group: 'MVP' with: #( 'CodeParadise-WebApplication-MVP' );

			group: 'Shoelace' with: #( 'CodeParadise-WebApplication-Shoelace' );
			group: 'Ionic' with: #( 'CodeParadise-WebApplication-Ionic' );
			group: 'ChartJS' with: #( 'CodeParadise-WebApplication-ChartJS' );
			group: 'Presentation' with: #( 'CodeParadise-WebApplication-Presentation' );
			group: 'Beach' with: #( 'CodeParadise-Beach' 'CodeParadise-Beach-Tests' );

			"2022-06: No longer maintained (needs to be loaded manually)"
			group: 'Fomantic' with: #( 'CodeParadise-WebApplication-Fomantic' );

			group: 'Snapshot' with: #( 'CodeParadise-WebApplication-Snapshot' );

			group: 'Development' with: #( 'CodeParadise-WebApplication-Development' 'CodeParadise-WebApplication-Debugger' );

			group: 'NodeJS-Applications' with: #( 'CodeParadise-NodeJS-REST' 'CodeParadise-NodeJS-Sqlite3' 'CodeParadise-NodeJS-Nodemailer' );

			group: 'CI' with: #( 'Tests' ) ].

	"Pharo 8.x specific"
	spec for: #(#'pharo8.x') do: [
		spec
			"For Pharo 8 we need a Client Environment with a tiny image based on older pre-Sista bytecode set"
			baseline: 'CpClientEnvironment' with: [ spec repository: 'github://ErikOnBike/CP-ClientEnvironment:pharo8' ] ].

	"Pharo 9.x (and upward) specific"
	spec for: #(#'pharo9.x' #'pharo10.x' #'pharo11.x' #'pharo12.x' #'pharo13.x') do: [
		spec
			"For Pharo 9 (and above) we need a Client Environment with a tiny image based on the newer Sista bytecode set"
			baseline: 'CpClientEnvironment' with: [ spec repository: 'github://ErikOnBike/CP-ClientEnvironment' ] ;
			package: 'CodeParadise-RemoteEnvironment' with: [ spec includes: 'CodeParadise-RemoteEnvironment-Pharo9' ] ;
			package: 'CodeParadise-RemoteEnvironment-Pharo9' with: [ spec requires: 'CodeParadise-RemoteEnvironment' ] ].

	"Pharo 11.x (and upward) specific"
	spec for: #(#'pharo11.x' #'pharo12.x' #'pharo13.x') do: [
		spec
			package: 'CodeParadise-RemoteEnvironment' with: [ spec includes: 'CodeParadise-RemoteEnvironment-Pharo11' ] ;
			package: 'CodeParadise-RemoteEnvironment-Pharo11' with: [ spec requires: 'CodeParadise-RemoteEnvironment' ] ].
]
