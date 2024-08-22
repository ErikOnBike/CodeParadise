Extension { #name : #CpWebApplication }

{ #category : #'*CodeParadise-WebApplication-Debugger' }
CpWebApplication >> addDebugger [

	CpClientDebuggerSupport on: self environment
]
