Class {
	#name : #RuleTerm,
	#superclass : #Object,
	#category : #BNFGrammarVisualization
}

{ #category : #testing }
RuleTerm >> isSymbol [

	self subclassResponsibility
]

{ #category : #testing }
RuleTerm >> isTerminal [

	self subclassResponsibility
]
