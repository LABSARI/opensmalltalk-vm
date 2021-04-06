Class {
	#name : #CCallNode,
	#superclass : #CExpressionNode,
	#instVars : [
		'arguments',
		'identifier'
	],
	#category : #'CAST-Nodes'
}

{ #category : #generated }
CCallNode >> acceptVisitor: anAbstractVisitor [
	^ anAbstractVisitor visitCall: self
]

{ #category : #generated }
CCallNode >> arguments [
	^ arguments
]

{ #category : #generated }
CCallNode >> arguments: anOrderedCollection [
	self setParents: self arguments to: nil.
	arguments := anOrderedCollection.
	self setParents: self arguments to: self
]

{ #category : #generated }
CCallNode >> identifier [
	^ identifier
]

{ #category : #generated }
CCallNode >> identifier: aCGLRAbstractNode [
	self identifier notNil
		ifTrue: [ self identifier parent: nil ].
	identifier := aCGLRAbstractNode.
	self identifier notNil
		ifTrue: [ self identifier parent: self ]
]

{ #category : #'generated-initialize-release' }
CCallNode >> initialize [
	super initialize.
	arguments := OrderedCollection new: 2.
]

{ #category : #testing }
CCallNode >> isCall [
	
	^ true
]