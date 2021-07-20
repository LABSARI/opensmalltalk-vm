Class {
	#name : #CCodeGeneratorInlineAlwaysStrategy,
	#superclass : #CCodeGeneratorAbsoluteInlineStrategy,
	#category : #'Slang-CodeGeneration'
}

{ #category : #accessing }
CCodeGeneratorInlineAlwaysStrategy >> nodeCountOfMethod: aTMethod [

	| nodeCount |
	nodeCount := 0.
	aTMethod parseTree nodesDo: [ :node | nodeCount := nodeCount + 1 ].
	^ nodeCount
]

{ #category : #asserting }
CCodeGeneratorInlineAlwaysStrategy >> shouldInlineMethod: aTMethod [ 

	^ (super shouldInlineMethod: aTMethod) and: [
			(self wantsInline: aTMethod)
				or: [ (self nodeCountOfMethod: aTMethod) < 40 ]]
]

{ #category : #'all checks' }
CCodeGeneratorInlineAlwaysStrategy >> transformations [
   
	| transformations |
	transformations := OrderedCollection new.
	transformations add:
		(SLInlining new inliningStrategy: inlineFlagOrSymbol).
	codeGenerator vmClass ifNil: [ ^ transformations ].

	1 to: 2 do: [ :index | 
		transformations add:
			(SLInterpreterLoopCaseInlining new localizingVars:
				 codeGenerator vmClass namesOfVariablesToLocalize).
		transformations add:
			(SLRemoveMethodReferingToGlobals new localizingVars:
				 codeGenerator vmClass namesOfVariablesToLocalize) ].

	transformations add: SLUnreachableMethodElimination new.

	^ transformations
]
