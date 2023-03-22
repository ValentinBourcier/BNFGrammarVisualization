Class {
	#name : #BNFGrammarVisualizationTest,
	#superclass : #TestCase,
	#category : #'BNFGrammarVisualization-Tests'
}

{ #category : #'as yet unclassified' }
BNFGrammarVisualizationTest >> testBasic [

	| grammar window |
	grammar := BNFGrammarVisualization new.
	
	grammar addRule: 'annotation' with: { 
		TerminalSymbol of: '@' .
		NonTerminalSymbol of:  'qualifiedName'.
		TerminalSymbol of: '('.
		AlternativeTerm with: { 
			NonTerminalSymbol of: 'elementValuePairs' .
			NonTerminalSymbol of: 'elementValue' .
		}.
		TerminalSymbol of: ')'.
	}.
	
	window := grammar open.
	window delete.
]
