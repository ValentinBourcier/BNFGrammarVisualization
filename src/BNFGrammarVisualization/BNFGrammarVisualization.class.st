Class {
	#name : #BNFGrammarVisualization,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'rules',
		'arrows'
	],
	#category : #BNFGrammarVisualization
}

{ #category : #modifying }
BNFGrammarVisualization >> addRule: aString with: aCollection [ 
	rules add: (
		Rule new 
			symbol: aString; 
			terms: aCollection; 
			yourself
	)
]

{ #category : #rendering }
BNFGrammarVisualization >> createAlternativeTerm: aTerm [
	
	| terms |
	terms := aTerm terms collect: [ :t | self createRuleTerm: t ].
	RSVerticalLineLayout new on: terms.
	^ RSComposite new 
		shapes: (RSGroup new addAll: terms; yourself );
		adjustToChildren;
		model: aTerm;
		yourself
]

{ #category : #rendering }
BNFGrammarVisualization >> createArrowsBetween: aFrom and: aTo [

	| marker |
	marker := RSPolygon new
		privatePoints: { -5@5. 0@0. 5@5. 0@0 };
		border: (RSBorder new color: Color black);
		yourself.
	aFrom do: [ :f |
		arrows addAll: (aTo collect: [ :t |
			RSBezier new
				withHorizontalAttachPoint;
				controlPointsController: RSHorizontalCPAPController new;
				markerEnd: marker;
				color: Color black;
				from: f;
				to: t; 
				yourself
		])
	].
]

{ #category : #rendering }
BNFGrammarVisualization >> createBeginEndShape [

	| box circle |
	
	circle := RSCircle new size: 16.
	box := RSBox new 
		color: Color white;
		height: circle height + 10;
		yourself.
	^ RSComposite new 
		shapes: (RSGroup new addAll: { box . circle }; yourself);
		yourself.
		
]

{ #category : #rendering }
BNFGrammarVisualization >> createRuleLabel: aRule [ 
	 
	^ RSLabel new
		text: aRule symbol;
		emphasis: TextEmphasis bold;
		color: Color black;
		yourself.
]

{ #category : #rendering }
BNFGrammarVisualization >> createRuleShape: aRule [
	| label terms box |
	label := self createRuleLabel: aRule.
	terms := self createRuleTerms: aRule.
	RSVerticalLineLayout on: { label . terms }.
	box := RSBox new
		color: Color white;
		border: (RSBorder new color: Color black);
		yourself.
	box extent: terms encompassingRectangle corner + 20.
	box position: (RSGroup new addAll: { label . terms }; position).
	^ RSComposite new 
		shapes: (RSGroup new addAll: { box . label . terms };yourself);
		yourself.
]

{ #category : #rendering }
BNFGrammarVisualization >> createRuleTerm: aTerm [

	 ^ aTerm isSymbol 
			ifTrue: [ self createSymbol: aTerm ] 
			ifFalse: [ self createAlternativeTerm: aTerm ]
]

{ #category : #rendering }
BNFGrammarVisualization >> createRuleTerms: aRule [
	
	| terms |
	terms := OrderedCollection new.
	terms add: self createBeginEndShape.
	terms addAll: (aRule terms collect: [ :t | self createRuleTerm: t ]).
	terms add: self createBeginEndShape.
	self createTermsArrows: terms.
	RSHorizontalLineLayout new
		gapSize: 20;
		on: terms.
	^ RSComposite new 
		shapes: (RSGroup new addAll: terms; yourself );
		adjustToChildren;
		model: aRule;
		yourself
]

{ #category : #rendering }
BNFGrammarVisualization >> createRulesShapes [

	 ^ rules collect: [ :r | self createRuleShape: r ]

]

{ #category : #rendering }
BNFGrammarVisualization >> createSymbol: aTerm [ 
	
	| label color box shape |
	color := aTerm isTerminal
		ifTrue: [ Color purple ]
		ifFalse: [ Color blue ].
	label := RSLabel new 
		text: aTerm symbol;
		color: color;
		yourself.
	box := RSBox new
		color: Color white;
		border: (RSBorder new color: Color black);
		yourself.
	box extent: label extent + 10.
	shape := RSComposite new 
		shapes: (RSGroup new addAll: { box . label }; yourself );
		model: aTerm;
		yourself.
	^ shape
]

{ #category : #rendering }
BNFGrammarVisualization >> createTermsArrows: aTerms [

	2 to: aTerms size do: [ :i | 
		| left right from to |
		left := aTerms at: i -1.
		right := aTerms at: i.
		
		from := { left }.
		to := { right }.
		
		(left model isNotNil and: [ left model isSymbol not ]) 
			ifTrue: [ from := left shapes ].
		(right model isNotNil and: [ right model isSymbol not])
			ifTrue: [ to := right shapes ].


		self createArrowsBetween: from and: to.
	].
	
]

{ #category : #examples }
BNFGrammarVisualization >> example [

	<script: 'self new example'>
	self addRule: 'annotation' with: { 
		TerminalSymbol of: '@' .
		NonTerminalSymbol of:  'qualifiedName'.
		TerminalSymbol of: '('.
		AlternativeTerm with: { 
			NonTerminalSymbol of: 'elementValuePairs' .
			NonTerminalSymbol of: 'elementValue' .
		}.
		TerminalSymbol of: ')'.	
	}.
	self open
]

{ #category : #modifying }
BNFGrammarVisualization >> initialize [

	rules := OrderedCollection new.
	arrows := OrderedCollection new.
]

{ #category : #hooks }
BNFGrammarVisualization >> renderIn: aCanvas [

 	| rulesShapes |
	
	rulesShapes := self createRulesShapes.
	aCanvas addAll: rulesShapes.
	aCanvas addAll: arrows.
	RSVerticalLineLayout on: rulesShapes.
	aCanvas @ RSCanvasController 
]
