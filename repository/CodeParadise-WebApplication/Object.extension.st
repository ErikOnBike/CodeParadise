Extension { #name : #Object }

{ #category : #'*CodeParadise-WebApplication' }
Object >> cpLog: anObject withLevel: anInteger [
	"Log the argument with a standard error level in log json format.
	NOTE: uses a trailing cr, as this ensures output is flushed for safer logging output"

	Transcript
		show: '{"level":"';
		show: (#( 'INFO' 'WARN' 'ERROR' ) at: anInteger);
		show: '","message":"';
		show: anObject;
		show: '","process":"CP"}';
		cr;
		flush
]

{ #category : #'*CodeParadise-WebApplication' }
Object >> cpLogError: anObject [
	"Log the argument with an error level in log json format"
	
	self cpLog: anObject withLevel: 3
]

{ #category : #'*CodeParadise-WebApplication' }
Object >> cpLogInfo: anObject [
	"Log the argument with an info error level in log json format"
	
	self cpLog: anObject withLevel: 1
]

{ #category : #'*CodeParadise-WebApplication' }
Object >> cpLogWarn: anObject [
	"Log the argument with a warn error level in log json format"
	
	self cpLog: anObject withLevel: 2
]
