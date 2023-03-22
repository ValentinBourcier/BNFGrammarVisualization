Class {
	#name : #Rule,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'terms'
	],
	#category : #BNFGrammarVisualization
}

{ #category : #accessing }
Rule >> symbol [

	^ symbol
]

{ #category : #accessing }
Rule >> symbol: anObject [

	symbol := anObject
]

{ #category : #accessing }
Rule >> terms [

	^ terms
]

{ #category : #accessing }
Rule >> terms: anObject [

	terms := anObject
]
