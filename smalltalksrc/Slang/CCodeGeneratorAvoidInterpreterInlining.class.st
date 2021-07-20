Class {
	#name : #CCodeGeneratorAvoidInterpreterInlining,
	#superclass : #CCodeGeneratorInlineAlwaysStrategy,
	#category : #'Slang-CodeGeneration'
}

{ #category : #'all checks' }
CCodeGeneratorAvoidInterpreterInlining >> transformations [

	^ { SLInlining new inliningStrategy: true. SLUnreachableMethodElimination new }
]
