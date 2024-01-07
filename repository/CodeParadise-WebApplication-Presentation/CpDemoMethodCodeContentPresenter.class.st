Class {
	#name : #CpDemoMethodCodeContentPresenter,
	#superclass : #CpDemoCodeContentPresenter,
	#category : #'CodeParadise-WebApplication-Presentation-Examples'
}

{ #category : #'user interaction' }
CpDemoMethodCodeContentPresenter >> installMethod [

	self model installMethod.

	self view renderMessage: 'Installed method: ', self model methodSelector
]

{ #category : #rendering }
CpDemoMethodCodeContentPresenter >> renderView [

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

{ #category : #view }
CpDemoMethodCodeContentPresenter >> viewCreated [

	super viewCreated.

	self view when: CpDemoCodeInstall send: #installMethod to: self
]
