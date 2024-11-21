Class {
	#name : #CpNodeJSFS,
	#superclass : #CpNodeJSBuiltinModule,
	#category : #'CodeParadise-NodeJS-Support-FileSystem'
}

{ #category : #actions }
CpNodeJSFS >> syncReadFile: aString options: aDictionary [

	"Synchronously read the content of the specified file using the options provided.
	
	path <string> | <Buffer> | <URL> | <integer> filename or file descriptor
	options <Object> | <string>
		encoding <string> | <null> Default: null
		flag <string> See support of file system flags. Default: 'r'.

	Returns: <string> | <Buffer>

	If the encoding option is specified then this function returns a string. Otherwise it returns a buffer.

	If options is a string, then it specifies the encoding."

	^ self apply: #readFileSync withArguments: { aString . aDictionary }
]

{ #category : #actions }
CpNodeJSFS >> syncWriteFile: aString data: anObject options: aDictionary [

	"Synchronously write the specified data to the specified file using the options provided.
	
	file <string> | <Buffer> | <URL> | <integer> filename or file descriptor
	data <string> | <Buffer> | <TypedArray> | <DataView>
	options <Object> | <string>
		encoding <string> | <null> Default: 'utf8'
		mode <integer> Default: 0o666
		flag <string> See support of file system flags. Default: 'w'.
		flush <boolean> If all data is successfully written to the file, and flush is true, fs.fsyncSync() is used to flush the data.

	The encoding option is ignored if data is a buffer.

	The mode option only affects the newly created file.

	If options is a string, then it specifies the encoding."

	self apply: #writeFileSync withArguments: { aString . anObject . aDictionary }
]
