Class {
	#name : #CpNodeJSFSStats,
	#superclass : #CpJavaScriptObject,
	#category : #'CodeParadise-NodeJS-Support-FileSystem'
}

{ #category : #'instance creation' }
CpNodeJSFSStats class >> newInstance [

	self error: 'Please create instances by using CpNodeJSFSDir >> #', #stats, ' or #', #statsSync
]

{ #category : #accessing }
CpNodeJSFSStats >> atime [

	"Added in: v0.11.13
	Type: <Date>
	The timestamp indicating the last time this file was accessed."

	^ self propertyAt: #atime
]

{ #category : #accessing }
CpNodeJSFSStats >> atimeMs [

	"Added in: v8.1.0
	Type: <number> | <bigint>
	The timestamp indicating the last time this file was accessed expressed in milliseconds since the POSIX Epoch."

	^ self propertyAt: #atimeMs
]

{ #category : #accessing }
CpNodeJSFSStats >> birthtime [

	"Added in: v0.11.13
	Type: <Date>
	The timestamp indicating the creation time of this file."

	^ self propertyAt: #birthtime
]

{ #category : #accessing }
CpNodeJSFSStats >> birthtimeMs [

	"Added in: v8.1.0
	Type: <number> | <bigint>
	The timestamp indicating the creation time of this file expressed in milliseconds since the POSIX Epoch."

	^ self propertyAt: #birthtimeMs
]

{ #category : #accessing }
CpNodeJSFSStats >> blksize [

	"Type: <number> | <bigint>
	The file system block size for i/o operations."

	^ self propertyAt: #blksize
]

{ #category : #accessing }
CpNodeJSFSStats >> blocks [

	"Type: <number> | <bigint>
	The number of blocks allocated for this file."

	^ self propertyAt: #blocks
]

{ #category : #accessing }
CpNodeJSFSStats >> ctime [

	"Added in: v0.11.13
	Type: <Date>
	The timestamp indicating the last time the file status was changed."

	^ self propertyAt: #ctime
]

{ #category : #accessing }
CpNodeJSFSStats >> ctimeMs [

	"Added in: v8.1.0
	Type: <number> | <bigint>
	The timestamp indicating the last time the file status was changed expressed in milliseconds since the POSIX Epoch."

	^ self propertyAt: #ctimeMs
]

{ #category : #accessing }
CpNodeJSFSStats >> dev [

	"Type: <number> | <bigint>
	The numeric identifier of the device containing the file."

	^ self propertyAt: #dev
]

{ #category : #accessing }
CpNodeJSFSStats >> gid [

	"Type: <number> | <bigint>
	The numeric group identifier of the group that owns the file (POSIX)."

	^ self propertyAt: #gid
]

{ #category : #accessing }
CpNodeJSFSStats >> ino [

	"Type: <number> | <bigint>
	The file system specific Inode number for the file."

	^ self propertyAt: #ino
]

{ #category : #accessing }
CpNodeJSFSStats >> isBlockDevice [

	"Returns true if the <fs.Dirent> object describes a block device."

	^ self apply: #isBlockDevice
]

{ #category : #accessing }
CpNodeJSFSStats >> isCharacterDevice [

	"Returns true if the <fs.Dirent> object describes a character device."

	^ self apply: #isCharacterDevice
]

{ #category : #accessing }
CpNodeJSFSStats >> isDirectory [

	"Returns true if the <fs.Dirent> object describes a file system directory."

	^ self apply: #isDirectory
]

{ #category : #accessing }
CpNodeJSFSStats >> isFIFO [

	"Returns true if the <fs.Dirent> object describes a first-in-first-out (FIFO) pipe."

	^ self apply: #isFIFO
]

{ #category : #accessing }
CpNodeJSFSStats >> isFile [

	"Returns true if the <fs.Dirent> object describes a regular file."

	^ self apply: #isFile
]

{ #category : #accessing }
CpNodeJSFSStats >> isSocket [

	"Returns true if the <fs.Dirent> object describes a socket."

	^ self apply: #isSocket
]

{ #category : #accessing }
CpNodeJSFSStats >> isSymbolicLink [

	"Returns true if the <fs.Dirent> object describes a symbolic link."

	^ self apply: #isSymbolicLink
]

{ #category : #accessing }
CpNodeJSFSStats >> mode [

	"Type: <number> | <bigint>
	A bit-field describing the file type and mode."

	^ self propertyAt: #mode
]

{ #category : #accessing }
CpNodeJSFSStats >> mtime [

	"Added in: v0.11.13
	Type: <Date>
	The timestamp indicating the last time this file was modified."

	^ self propertyAt: #mtime
]

{ #category : #accessing }
CpNodeJSFSStats >> mtimeMs [

	"Added in: v8.1.0
	Type: <number> | <bigint>
	The timestamp indicating the last time this file was modified expressed in milliseconds since the POSIX Epoch."

	^ self propertyAt: #mtimeMs
]

{ #category : #accessing }
CpNodeJSFSStats >> nlink [

	"Type: <number> | <bigint>
	The number of hard-links that exist for the file."

	^ self propertyAt: #nlink
]

{ #category : #accessing }
CpNodeJSFSStats >> rdev [

	"Type: <number> | <bigint>
	A numeric device identifier if the file represents a device."

	^ self propertyAt: #rdev
]

{ #category : #accessing }
CpNodeJSFSStats >> size [

	"Type: <number> | <bigint>
	The size of the file in bytes.

	If the underlying file system does not support getting the size of the file, this will be 0."

	^ self propertyAt: #size
]

{ #category : #accessing }
CpNodeJSFSStats >> uid [

	"Type: <number> | <bigint>
	The numeric user identifier of the user that owns the file (POSIX)."

	^ self propertyAt: #uid
]
