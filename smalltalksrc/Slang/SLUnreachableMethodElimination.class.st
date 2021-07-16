Class {
	#name : #SLUnreachableMethodElimination,
	#superclass : #Object,
	#category : #'Slang-transformations'
}

{ #category : #operations }
SLUnreachableMethodElimination >> applyTo: aCodeGen [

	aCodeGen pruneUnreachableMethods
]
