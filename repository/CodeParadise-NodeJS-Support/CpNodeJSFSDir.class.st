Class {
	#name : #CpNodeJSFSDir,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Support-FileSystem'
}

{ #category : #'instance creation' }
CpNodeJSFSDir class >> newInstance [

	self error: 'Please create instances by using CpNodeJSFS >> #', #openDir:options:do:
]

{ #category : #operations }
CpNodeJSFSDir >> close [

	"Asynchronously close the directory's underlying resource handle. Subsequent reads will result in errors.

	A promise is returned that will be fulfilled after the resource has been closed."

	self apply: #close resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpNodeJSFSDir >> closeDo: aBlock [

	"Asynchronously close the directory's underlying resource handle. Subsequent reads will result in errors.

	callback <Function>
		err <Error>

	The callback will be called after the resource handle has been closed."

	self apply: #close withArguments: { aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFSDir >> closeSync [

	"Synchronously close the directory's underlying resource handle. Subsequent reads will result in errors."

	self apply: #closeSync
]

{ #category : #convenience }
CpNodeJSFSDir >> directoriesDo: aBlock [

	"Evaluate the specified Block for all directories in the receiver"

	self do: [ :each |
		each isDirectory
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #convenience }
CpNodeJSFSDir >> do: aBlock [

	"Iterate over all directory entries in the receiver and evaluate each.
	The receiver will return once all entries are evaluated."

	| dirent |

	[
		dirent := self read await.
		dirent ifNil: [ ^ self ].

		aBlock value: dirent ] repeat
]

{ #category : #convenience }
CpNodeJSFSDir >> filesDo: aBlock [

	"Evaluate the specified Block for all regular files in the receiver"

	self do: [ :each |
		each isFile
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #accessing }
CpNodeJSFSDir >> path [

	"The read-only path of this directory as was provided to fs.opendir(), fs.opendirSync(), or fsPromises.opendir()."

	^ self propertyAt: #path
]

{ #category : #operations }
CpNodeJSFSDir >> read [

	"Asynchronously read the next directory entry via readdir(3) as an <fs.Dirent>.

	Returns: <Promise> Fulfills with a <fs.Dirent> | <null>

	A promise is returned that will be fulfilled with an <fs.Dirent>, or null if there are no more directory entries to read.

	Directory entries returned by this function are in no particular order as provided by the operating system's underlying directory mechanisms. Entries added or removed while iterating over the directory might not be included in the iteration results.

	Return: Promise"

	^ self apply: #read resultAs: CpJavaScriptPromise
]

{ #category : #operations }
CpNodeJSFSDir >> readDo: aBlock [

	"Asynchronously read the next directory entry via readdir(3) as an <fs.Dirent>.

	callback <Function>
		err <Error>
		dirent <fs.Dirent> | <null>

	After the read is completed, the callback will be called with an <fs.Dirent>, or null if there are no more directory entries to read.

	Directory entries returned by this function are in no particular order as provided by the operating system's underlying directory mechanisms. Entries added or removed while iterating over the directory might not be included in the iteration results."

	^ self apply: #read withArguments: { aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFSDir >> readSync [

	"Synchronously read the next directory entry as an <fs.Dirent>. See the POSIX readdir(3) documentation for more detail.

	Returns: <fs.Dirent> | <null>

	If there are no more directory entries to read, null will be returned.

	Directory entries returned by this function are in no particular order as provided by the operating system's underlying directory mechanisms. Entries added or removed while iterating over the directory might not be included in the iteration results."

	^ self apply: #readSync
]
