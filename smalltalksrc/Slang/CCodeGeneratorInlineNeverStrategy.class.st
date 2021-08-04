Class {
	#name : #CCodeGeneratorInlineNeverStrategy,
	#superclass : #CCodeGeneratorAbsoluteInlineStrategy,
	#category : #'Slang-CodeGeneration'
}

{ #category : #asserting }
CCodeGeneratorInlineNeverStrategy >> shouldInlineMethod: aMethod [

	^ false
]

{ #category : #'all checks' }
CCodeGeneratorInlineNeverStrategy >> transformations [

	^ { 
		  (SLInlining new inliningStrategy:
			   CCodeGeneratorInlineBlockStrategy new).
		  (SLInterpreterLoopCaseInlining new localizingVars: #(  )).
		  SLUnreachableMethodElimination new }
]
