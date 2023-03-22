Class {
	#name : #AlternativeTerm,
	#superclass : #RuleTerm,
	#instVars : [
		'terms'
	],
	#category : #BNFGrammarVisualization
}

{ #category : #'instance creation' }
AlternativeTerm class >> with: aTerms [

	^ self new
		terms: aTerms;
		yourself
]

{ #category : #testing }
AlternativeTerm >> isSymbol [

	^ false
]

{ #category : #testing }
AlternativeTerm >> isTerminal [

	^ terms detect: [ :t | t isTerminal not ] ifNone: [ true ]
]

{ #category : #accessing }
AlternativeTerm >> terms [

	^ terms
]

{ #category : #accessing }
AlternativeTerm >> terms: anObject [

	terms := anObject
]
