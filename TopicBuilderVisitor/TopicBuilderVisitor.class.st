Class {
	#name : #TopicBuilderVisitor,
	#superclass : #PRVisitor,
	#instVars : [
		'helpTopic',
		'actualTopic'
	],
	#category : #TopicBuilderVisitor
}

{ #category : #'instance creation' }
TopicBuilderVisitor class >> with: aActualTopic [
	
	| visitor |
	visitor := self new.
	visitor actualTopic: aActualTopic.
	^ visitor 
]

{ #category : #accessing }
TopicBuilderVisitor >> actualTopic: aActualTopic [

	actualTopic := aActualTopic
]

{ #category : #initialization }
TopicBuilderVisitor >> initialize [ 
	
	super initialize.
	helpTopic := LinkedList new.
	actualTopic := 1.
]

{ #category : #accessing }
TopicBuilderVisitor >> rootTopic [
	^ helpTopic.
]

{ #category : #'visiting-document' }
TopicBuilderVisitor >> visitHeader: anObject [

	(anObject level) > actualTopic 	
		ifTrue: 
			[ actualTopic := (anObject level).
			(helpTopic at:  helpTopic size) addSubtopic:  ((((self class with: actualTopic)  visitHeader: anObject) at: 1) rootTopic at: 1) ]	
		 ifFalse: 
			[ actualTopic := (anObject level).
			helpTopic add: (HelpTopic named: anObject text) ].
	^ super visitHeader:  anObject
]
