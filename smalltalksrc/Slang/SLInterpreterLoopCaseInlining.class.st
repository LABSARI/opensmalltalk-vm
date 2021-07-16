Class {
	#name : #SLInterpreterLoopCaseInlining,
	#superclass : #Object,
	#instVars : [
		'localizingVars'
	],
	#category : #'Slang-transformations'
}

{ #category : #operations }
SLInterpreterLoopCaseInlining >> applyTo: aCodeGen [

	aCodeGen
		inlineDispatchesInMethodNamed: #interpret
		localizingVars: localizingVars
]

{ #category : #accessing }
SLInterpreterLoopCaseInlining >> localizingVars [

	^ localizingVars
]

{ #category : #accessing }
SLInterpreterLoopCaseInlining >> localizingVars: anObject [

	localizingVars := anObject
]
