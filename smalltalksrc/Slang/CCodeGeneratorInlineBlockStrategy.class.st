Class {
	#name : #CCodeGeneratorInlineBlockStrategy,
	#superclass : #CCodeGeneratorInlineAlwaysStrategy,
	#category : #'Slang-CodeGeneration'
}

{ #category : #'as yet unclassified' }
CCodeGeneratorInlineBlockStrategy >> inlineableSend: aNode inMethod: anotherMethod [
	"Answer if the given send node is a call to a method that can be inlined."
	
	aNode isSend ifFalse: [^false].
	^ (aNode arguments anySatisfy: [ :arg | arg isStmtList ])
		and: [ super inlineableSend: aNode inMethod: anotherMethod ]
]
