Class {
	#name : #CCodeGeneratorAvoidInterpreterInlining,
	#superclass : #CCodeGeneratorInlineStrategy,
	#category : #'Slang-CodeGeneration'
}

{ #category : #'all checks' }
CCodeGeneratorAvoidInterpreterInlining >> transformations [

	^ { SLInlining new inliningStrategy: true. SLUnreachableMethodElimination new }
]
