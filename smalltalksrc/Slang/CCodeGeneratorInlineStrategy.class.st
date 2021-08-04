Class {
	#name : #CCodeGeneratorInlineStrategy,
	#superclass : #Object,
	#instVars : [
		'codeGenerator',
		'inlineFlagOrSymbol'
	],
	#category : #'Slang-CodeGeneration'
}

{ #category : #'instance-cre' }
CCodeGeneratorInlineStrategy class >> always [
	
	^ CCodeGeneratorInlineAlwaysStrategy new
]

{ #category : #'instance-creation' }
CCodeGeneratorInlineStrategy class >> asSpecified [

	^ CCodeGeneratorInlineAsSpecifiedStrategy new
]

{ #category : #'instance-creation' }
CCodeGeneratorInlineStrategy class >> asSpecifiedOrQuick [

	^ CCodeGeneratorInlineAsSpecifiedOrQuickStrategy new
]

{ #category : #'instance creation' }
CCodeGeneratorInlineStrategy class >> basicFrom: anObject [

	"The argument is either a boolean or a sumbol.
	If a boolean, it indicates if we need to inline or not.
	If == #asSpecified only inline methods marked with <inline: true>.
	If == #asSpecifiedOrQuick only inline methods marked with <inline: true> or methods that are quick (^constant, ^inst var)."

	(#( true false ) includes: anObject) ifTrue: [ 
		^ (anObject
			   ifTrue: [ self always ]
			   ifFalse: [ self never ])
			  inlineFlagOrSymbol: anObject;
			  yourself ].

	"If the object is a selector use a perform to instantiate it."
	^ (self perform: anObject)
		  inlineFlagOrSymbol: anObject;
		  yourself
]

{ #category : #'instance creation' }
CCodeGeneratorInlineStrategy class >> from: anObject [

	"The argument is either a boolean or a sumbol.
	If a boolean, it indicates if we need to inline or not.
	If == #asSpecified only inline methods marked with <inline: true>.
	If == #asSpecifiedOrQuick only inline methods marked with <inline: true> or methods that are quick (^constant, ^inst var)."

	| inlineStrategy |
	inlineStrategy := self basicFrom: anObject.
	"inlineStrategy inliningStrategy: anObject."
	^ inlineStrategy
]

{ #category : #'instance-crea' }
CCodeGeneratorInlineStrategy class >> never [

	^ CCodeGeneratorInlineNeverStrategy new
]

{ #category : #converting }
CCodeGeneratorInlineStrategy >> asCCodeInlineStrategy [
	^ self
]

{ #category : #testing }
CCodeGeneratorInlineStrategy >> canInline: aTMethod [
	
	^ (self hasUnrenamableCCode: aTMethod) not
		and: [ aTMethod extractInlineDirective ~= false ]
]

{ #category : #'as yet unclassified' }
CCodeGeneratorInlineStrategy >> candidateStatementsForInliningIn: aTMethod [
	"Answer a collection of statement list nodes that are candidates for inlining.
	 Currently, we cannot inline into the argument blocks of and: and or: messages.
	 We do not want to inline code strings within cCode:inSmalltalk: blocks (those with a
	 proper block for the cCode: argument are inlined in MessageNode>>asTranslatorNodeIn:).
	 We do not want to inline code within assert: sends (because we want the assert to read nicely)."

	| stmtLists |
	stmtLists := OrderedCollection new: 10.
	aTMethod parseTree
		nodesDo:
			[:node|
			node isStmtList ifTrue: [stmtLists add: node]]
		unless:
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [ codeGenerator isAssertSelector: node selector]]].
	aTMethod parseTree nodesDo:
		[:node|
		node isSend ifTrue:
			[node selector = #cCode:inSmalltalk: ifTrue:
				[node nodesDo:
					[:ccisNode| stmtLists remove: ccisNode ifAbsent: []]].
			 (node selector = #cppIf:ifTrue:ifFalse: or: [node selector = #cppIf:ifTrue:]) ifTrue:
				[node args first nodesDo:
					[:inCondNode| stmtLists remove: inCondNode ifAbsent: []]].
			((node selector = #and:) or: [node selector = #or:]) ifTrue:
				"Note: the PP 2.3 compiler produces two arg nodes for these selectors"
				[stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args last ifAbsent: []].
			(#(	#ifTrue: #ifFalse: #ifTrue:ifFalse: #ifFalse:ifTrue:
				#ifNil: #ifNotNil: #ifNil:ifNotNil: #ifNotNil:ifNil: ) includes: node selector) ifTrue:
				[stmtLists remove: node receiver ifAbsent: []].
			(#(whileTrue whileTrue: whilefalse whileFalse:) includes: node selector) ifTrue:
				"Allow inlining if it is a [...] whileTrue/whileFalse.
				This is identified by having more than one statement in the 
				receiver block in which case the C code wouldn't work anyways"
				[node receiver statements size = 1 ifTrue:
					[stmtLists remove: node receiver ifAbsent: []]].
			(node selector = #to:do:) ifTrue:
				[stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: []].
			(node selector = #to:by:do:) ifTrue:
				[stmtLists remove: node receiver ifAbsent: [].
				stmtLists remove: node args first ifAbsent: [].
				stmtLists remove: node args second ifAbsent: []]].
		node isCaseStmt ifTrue: "don't inline cases"
			[node cases do: [:case| stmtLists remove: case ifAbsent: []]]].
	^stmtLists
]

{ #category : #accessing }
CCodeGeneratorInlineStrategy >> codeGenerator [
	^ codeGenerator
]

{ #category : #accessing }
CCodeGeneratorInlineStrategy >> codeGenerator: anObject [
	codeGenerator := anObject
]

{ #category : #testing }
CCodeGeneratorInlineStrategy >> hasUnrenamableCCode: aTMethod [

	^ (codeGenerator isSpecialSelector: aTMethod selector)
		or: [ aTMethod hasUnrenamableCCode ]
]

{ #category : #accessing }
CCodeGeneratorInlineStrategy >> inlineFlagOrSymbol [

	^ inlineFlagOrSymbol
]

{ #category : #accessing }
CCodeGeneratorInlineStrategy >> inlineFlagOrSymbol: anObject [

	inlineFlagOrSymbol := anObject
]

{ #category : #'as yet unclassified' }
CCodeGeneratorInlineStrategy >> inlineableSend: aNode inMethod: anotherMethod [
	"Answer if the given send node is a call to a method that can be inlined."

	| m |
	codeGenerator maybeBreakForTestToInline: aNode in: anotherMethod.
	aNode isSend ifFalse: [^false].
	m := codeGenerator methodNamed: aNode selector.  "nil if builtin or external function"
	^m ~= nil
	 and: [m ~~ anotherMethod
	 and: [m mayBeInlined
	 and: [(m isComplete and: [ codeGenerator mayInline: m selector])
		or: [m checkForRequiredInlinability]]]]
]

{ #category : #testing }
CCodeGeneratorInlineStrategy >> isSelectiveInlineStrategy [
	
	^ false
]

{ #category : #asserting }
CCodeGeneratorInlineStrategy >> shouldInlineMethod: aMethod [

	^ self canInline: aMethod
]

{ #category : #'all checks' }
CCodeGeneratorInlineStrategy >> transformations [

	^ self subclassResponsibility
]

{ #category : #asserting }
CCodeGeneratorInlineStrategy >> validateCanInline: aMethod [

	((self canInline: aMethod) not
		and: [ self wantsInline: aMethod ]) ifTrue: [
			"don't inline if method has C code or contains negative inline directive"
			codeGenerator cannotInline: aMethod selector ]
]

{ #category : #testing }
CCodeGeneratorInlineStrategy >> wantsInline: aTMethod [ 
	
	^ (codeGenerator isSpecialSelector: aTMethod selector) not
		and: [ aTMethod extractInlineDirective == true ]
]
