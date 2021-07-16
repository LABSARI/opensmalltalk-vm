Class {
	#name : #SLInlining,
	#superclass : #Object,
	#instVars : [
		'inliningStrategy'
	],
	#category : #'Slang-transformations'
}

{ #category : #operations }
SLInlining >> applyTo: aCodeGen [

	aCodeGen doBasicInlining: inliningStrategy
]

{ #category : #accessing }
SLInlining >> inliningStrategy [

	^ inliningStrategy
]

{ #category : #accessing }
SLInlining >> inliningStrategy: anObject [

	inliningStrategy := anObject
]
