Class {
	#name : #RuleSymbol,
	#superclass : #RuleTerm,
	#instVars : [
		'symbol'
	],
	#category : #BNFGrammarVisualization
}

{ #category : #creation }
RuleSymbol class >> of: aString [ 
	
	^ self new
		symbol: aString;
		yourself.
]

{ #category : #testing }
RuleSymbol >> isSymbol [

	^ true
]

{ #category : #testing }
RuleSymbol >> isTerminal [

	self subclassResponsibility
]

{ #category : #accessing }
RuleSymbol >> symbol [

	^ symbol
]

{ #category : #accessing }
RuleSymbol >> symbol: aString [ 

	symbol := aString
]
