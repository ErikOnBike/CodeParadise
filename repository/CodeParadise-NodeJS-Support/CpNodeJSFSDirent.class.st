Class {
	#name : #CpNodeJSFSDirent,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Support-FileSystem'
}

{ #category : #'instance creation' }
CpNodeJSFSDirent class >> newInstance [

	self error: 'Please create instances by using CpNodeJSFSDir >> #', #read
]

{ #category : #accessing }
CpNodeJSFSDirent >> isBlockDevice [

	"Returns true if the <fs.Dirent> object describes a block device."

	^ self apply: #isBlockDevice
]

{ #category : #accessing }
CpNodeJSFSDirent >> isCharacterDevice [

	"Returns true if the <fs.Dirent> object describes a character device."

	^ self apply: #isCharacterDevice
]

{ #category : #accessing }
CpNodeJSFSDirent >> isDirectory [

	"Returns true if the <fs.Dirent> object describes a file system directory."

	^ self apply: #isDirectory
]

{ #category : #accessing }
CpNodeJSFSDirent >> isFIFO [

	"Returns true if the <fs.Dirent> object describes a first-in-first-out (FIFO) pipe."

	^ self apply: #isFIFO
]

{ #category : #accessing }
CpNodeJSFSDirent >> isFile [

	"Returns true if the <fs.Dirent> object describes a regular file."

	^ self apply: #isFile
]

{ #category : #accessing }
CpNodeJSFSDirent >> isSocket [

	"Returns true if the <fs.Dirent> object describes a socket."

	^ self apply: #isSocket
]

{ #category : #accessing }
CpNodeJSFSDirent >> isSymbolicLink [

	"Returns true if the <fs.Dirent> object describes a symbolic link."

	^ self apply: #isSymbolicLink
]

{ #category : #accessing }
CpNodeJSFSDirent >> name [

	"The file name that this <fs.Dirent> object refers to. The type of this value is determined by the options.encoding passed to fs.readdir() or fs.readdirSync()."

	^ self propertyAt: #name
]

{ #category : #accessing }
CpNodeJSFSDirent >> parentPath [

	"The path to the parent directory of the file this <fs.Dirent> object refers to."

	^ self propertyAt: #parentPath
]
