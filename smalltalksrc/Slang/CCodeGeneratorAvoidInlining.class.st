Class {
	#name : #CCodeGeneratorAvoidInlining,
	#superclass : #CCodeGeneratorAbsoluteInlineStrategy,
	#category : #'Slang-CodeGeneration'
}

{ #category : #asserting }
CCodeGeneratorAvoidInlining >> shouldInlineMethod: aMethod [

	^ false
]

{ #category : #asserting }
CCodeGeneratorAvoidInlining >> transformations [

	^ { SLUnreachableMethodElimination new }
]
