Class {
	#name : #SLRemoveMethodReferingToGlobals,
	#superclass : #Object,
	#instVars : [
		'localizingVars'
	],
	#category : #'Slang-transformations'
}

{ #category : #operations }
SLRemoveMethodReferingToGlobals >> applyTo: aCodeGen [

	| removed |
	removed := aCodeGen
		           removeMethodsReferingToGlobals: localizingVars
		           except: #interpret.
	aCodeGen reportShouldNotBeRemoved: removed varList: localizingVars
]

{ #category : #accessing }
SLRemoveMethodReferingToGlobals >> localizingVars [

	^ localizingVars
]

{ #category : #accessing }
SLRemoveMethodReferingToGlobals >> localizingVars: anObject [

	localizingVars := anObject
]
