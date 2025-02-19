Class {
	#name : #CpDemoClassDefinitionCodeContentPresenter,
	#superclass : #CpDemoExecutableCodeContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #rendering }
CpDemoClassDefinitionCodeContentPresenter >> renderView [

	| codeStatus codeStatusString otherCode |

	super renderView.

	codeStatus := self model status.

	codeStatusString := codeStatus ifNotNil: [
		codeStatus == #installed
			ifTrue: [ 'installed' ]
			ifFalse: [
				"Only for this status do we ask for the other (existing) code"
				otherCode := self model otherCode.
				'other impl.' ] ].

	self view
		renderOtherCode: otherCode ;
		renderBanner: codeStatusString showOther: otherCode isNotNil
]
