Class {
	#name : #TopicBuilderVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'filesystem'
	],
	#category : #TopicBuilderVisitorTest
}

{ #category : #resources }
TopicBuilderVisitorTest class >> spFileContentsMoreSections [

	^ '# Section 1
This is a test on `SpHelpBrowserPresenterTest`
# Section 2
dqsdqsdqd'
]

{ #category : #resources }
TopicBuilderVisitorTest class >> spFileContentsOneSection [

	^ '# Section 1
This is a test on `SpHelpBrowserPresenterTest`'
"# Section 2
dqsdqsdqd"
]

{ #category : #resources }
TopicBuilderVisitorTest class >> spFileContentsWithSubSection [

	^ '# Section 1
This is a test on `SpHelpBrowserPresenterTest`
## Section 2
dqsdqsdqd'
]

{ #category : #resources }
TopicBuilderVisitorTest class >> spFileName [

	^ 'test.md'
]

{ #category : #running }
TopicBuilderVisitorTest >> setUp [
	super setUp.
	filesystem := FileSystem memory
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
TopicBuilderVisitorTest >> testTopicBuilderWithMoreSections [

	| file visitor|
	 (file := filesystem workingDirectory / self class spFileName) 
		writeStreamDo: [ :stream | stream nextPutAll: self class spFileContentsMoreSections ].
	visitor := TopicBuilderVisitor new.
	visitor visit:  (MicroDownParser parse: file) asPillar.
	self assert:  (visitor rootTopic at: 2) title equals: 'Section 2'
]

{ #category : #tests }
TopicBuilderVisitorTest >> testTopicBuilderWithOneSection [

	| file visitor|
	 (file := filesystem workingDirectory / self class spFileName) 
		writeStreamDo: [ :stream | stream nextPutAll: self class spFileContentsOneSection ].
	visitor := TopicBuilderVisitor new.
	visitor visit:  (MicroDownParser parse: file) asPillar.
	self assert:  (visitor rootTopic at: 1) title equals: 'Section 1'.
	self assert: visitor rootTopic size equals: 1
]

{ #category : #tests }
TopicBuilderVisitorTest >> testTopicBuilderWithSubSection [

	| file visitor|
	 (file := filesystem workingDirectory / self class spFileName) 
		writeStreamDo: [ :stream | stream nextPutAll: self class spFileContentsWithSubSection ].
	visitor := TopicBuilderVisitor new.
	visitor visit:  (MicroDownParser parse: file) asPillar.
	self assert:  ((visitor rootTopic at: 1) subtopics at: 1) title equals: 'Section 2'.
	self assert: visitor rootTopic size equals: 1
]
