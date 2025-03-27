"
I represent the NodeJS FileSystem module and namespace.
I am responsible for performing all kinds of file system related operations.

Currently I don't have many operations implemented. Please add the operations
you need (and do a Pull Request on the repo) or reach out to get the operations
added.

A number of file and/or directory operations have a synchronous as well as asynchronous
implementation. This is a convenience for situations where async is cumbersome.
"
Class {
	#name : #CpNodeJSFS,
	#superclass : #CpNodeJSBuiltinModule,
	#category : #'CodeParadise-NodeJS-Support-FileSystem'
}

{ #category : #'class initialization' }
CpNodeJSFS class >> namespace [

	"The NodeJS module 'fs' acts as a namespace"

	^ self require
]

{ #category : #operations }
CpNodeJSFS >> glob: aString do: aBlock [

	self glob: aString options: Dictionary new do: aBlock
]

{ #category : #operations }
CpNodeJSFS >> glob: aString options: aDictionary do: aBlock [

	"Retrieves the files matching the specified pattern.

	pattern <string> | <string[]>
	options <Object>
		cwd <string> current working directory. Default: process.cwd()
		exclude <Function> Function to filter out files/directories. Return true to exclude the item, false to include it. Default: undefined.
		withFileTypes <boolean> true if the glob should return paths as Dirents, false otherwise. Default: false.
	callback <Function>
		err <Error>"

	self apply: #glob withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> mkdir: aString options: aDictionary do: aBlock [

	"Asynchronously creates a directory.

	path <string> | <Buffer> | <URL>
	options <Object> | <integer>
		recursive <boolean> Default: false
		mode <string> | <integer> Not supported on Windows. Default: 0o777.
	callback <Function>
		err <Error>
		path <string> | <undefined> Present only if a directory is created with recursive set to true.

	The callback is given a possible exception and, if recursive is true, the first directory path created, (err[, path]). path can still be undefined when recursive is true, if no directory was created (for instance, if it was previously created).

	The optional options argument can be an integer specifying mode (permission and sticky bits), or an object with a mode property and a recursive property indicating whether parent directories should be created. Calling fs.mkdir() when path is a directory that exists results in an error only when recursive is false. If recursive is false and the directory exists, an EEXIST error occurs."

	^ self apply: #mkdir withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> mkdirSync: aString options: aDictionary [

	"Synchronously creates a directory. Returns undefined, or if recursive is true, the first directory path created. This is the synchronous version of fs.mkdir().

	path <string> | <Buffer> | <URL>
	options <Object> | <integer>
		recursive <boolean> Default: false
		mode <string> | <integer> Not supported on Windows. Default: 0o777.
	Returns: <string> | <undefined>"

	^ self apply: #mkdirSync withArguments: { aString . aDictionary }
]

{ #category : #operations }
CpNodeJSFS >> mkdirTemp: aString options: aDictionary do: aBlock [

	"Creates a unique temporary directory.

	prefix <string> | <Buffer> | <URL>
	options <string> | <Object>
		encoding <string> Default: 'utf8'
	callback <Function>
		err <Error>
		directory <string>

	Generates six random characters to be appended behind a required prefix to create a unique temporary directory. Due to platform inconsistencies, avoid trailing X characters in prefix. Some platforms, notably the BSDs, can return more than six random characters, and replace trailing X characters in prefix with random characters.

	The created directory path is passed as a string to the callback's second parameter.

	The optional options argument can be a string specifying an encoding, or an object with an encoding property specifying the character encoding to use."

	^ self apply: #mkdtemp withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> mkdirTempSync: aString options: aDictionary [

	"Returns the created directory path.

	prefix <string> | <Buffer> | <URL>
	options <string> | <Object>
		encoding <string> Default: 'utf8'
	Returns: <string>

	For detailed information, see the documentation of the asynchronous version of this API: fs.mkdtemp().

	The optional options argument can be a string specifying an encoding, or an object with an encoding property specifying the character encoding to use."

	^ self apply: #mkdtempSync withArguments: { aString . aDictionary }
]

{ #category : #operations }
CpNodeJSFS >> openDir: aString options: aDictionary do: aBlock [

	"Asynchronously open the specified directory and evaluate the specified Block with an Error and a Dir instance (see below).

	path <string> | <Buffer> | <URL>
	options <Object>
		encoding <string> | <null> Default: 'utf8'
		bufferSize <number> Number of directory entries that are buffered internally when reading from the directory. Higher values lead to better performance but higher memory usage. Default: 32
		recursive <boolean> Default: false
	callback <Function>
		err <Error>
		dir <fs.Dir>

	Asynchronously open a directory. See the POSIX opendir(3) documentation for more details.

	Creates an <fs.Dir>, which contains all further functions for reading from and cleaning up the directory.

	The encoding option sets the encoding for the path while opening the directory and subsequent read operations."

	self apply: #opendir withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> openDirSync: aString options: aDictionary [

	"Synchronously open a directory. See opendir(3).

	path <string> | <Buffer> | <URL>
	options <Object>
		encoding <string> | <null> Default: 'utf8'
		bufferSize <number> Number of directory entries that are buffered internally when reading from the directory. Higher values lead to better performance but higher memory usage. Default: 32
		recursive <boolean> Default: false
	Returns: <fs.Dir>

	Creates an <fs.Dir>, which contains all further functions for reading from and cleaning up the directory.

	The encoding option sets the encoding for the path while opening the directory and subsequent read operations."

	self apply: #opendirSync withArguments: { aString . aDictionary }
]

{ #category : #operations }
CpNodeJSFS >> readFile: aString options: aDictionary do: aBlock [

	"Asynchronously read the content of the specified file using the options provided.

	The specified Block should accept two arguments: err and data (see below).
	
	path <string> | <Buffer> | <URL> | <integer> filename or file descriptor
	options <Object> | <string>
		encoding <string> | <null> Default: null
		flag <string> See support of file system flags. Default: 'r'.
		signal <AbortSignal> allows aborting an in-progress readFile
	callback <Function>
		err <Error> | <AggregateError>
		data <string> | <Buffer>

	Asynchronously reads the entire contents of a file."

	self apply: #readFileSync withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> readFileSync: aString options: aDictionary [

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

{ #category : #operations }
CpNodeJSFS >> rm: aString options: aDictionary do: aBlock [

	"Asynchronously removes files and directories (modeled on the standard POSIX rm utility). No arguments other than a possible exception are given to the completion callback.

	path <string> | <Buffer> | <URL>
	options <Object>
		force <boolean> When true, exceptions will be ignored if path does not exist. Default: false.
		maxRetries <integer> If an EBUSY, EMFILE, ENFILE, ENOTEMPTY, or EPERM error is encountered, Node.js will retry the operation with a linear backoff wait of retryDelay milliseconds longer on each try. This option represents the number of retries. This option is ignored if the recursive option is not true. Default: 0.
		recursive <boolean> If true, perform a recursive removal. In recursive mode operations are retried on failure. Default: false.
		retryDelay <integer> The amount of time in milliseconds to wait between retries. This option is ignored if the recursive option is not true. Default: 100.
	callback <Function>
		err <Error>

	To get a behavior similar to the rm -rf Unix command, use fs.rm() with options { recursive: true, force: true }."

	^ self apply: #rm withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> rmSync: aString options: aDictionary [

	"Synchronously removes files and directories (modeled on the standard POSIX rm utility). Returns undefined.

	path <string> | <Buffer> | <URL>
	options <Object>
		force <boolean> When true, exceptions will be ignored if path does not exist. Default: false.
		maxRetries <integer> If an EBUSY, EMFILE, ENFILE, ENOTEMPTY, or EPERM error is encountered, Node.js will retry the operation with a linear backoff wait of retryDelay milliseconds longer on each try. This option represents the number of retries. This option is ignored if the recursive option is not true. Default: 0.
		recursive <boolean> If true, perform a recursive directory removal. In recursive mode operations are retried on failure. Default: false.
		retryDelay <integer> The amount of time in milliseconds to wait between retries. This option is ignored if the recursive option is not true. Default: 100.

	To get a behavior similar to the rm -rf Unix command, use fs.rm() with options { recursive: true, force: true }."

	^ self apply: #rmSync withArguments: { aString . aDictionary }
]

{ #category : #operations }
CpNodeJSFS >> rmdir: aString options: aDictionary do: aBlock [

	"Asynchronous rmdir(2). No arguments other than a possible exception are given to the completion callback.

	path <string> | <Buffer> | <URL>
	options <Object>
		maxRetries <integer> If an EBUSY, EMFILE, ENFILE, ENOTEMPTY, or EPERM error is encountered, Node.js retries the operation with a linear backoff wait of retryDelay milliseconds longer on each try. This option represents the number of retries. This option is ignored if the recursive option is not true. Default: 0.
		recursive <boolean> If true, perform a recursive directory removal. In recursive mode, operations are retried on failure. Default: false. Deprecated.
		retryDelay <integer> The amount of time in milliseconds to wait between retries. This option is ignored if the recursive option is not true. Default: 100.
	callback <Function>
		err <Error>

	Using fs.rmdir() on a file (not a directory) results in an ENOENT error on Windows and an ENOTDIR error on POSIX.

	To get a behavior similar to the rm -rf Unix command, use fs.rm() with options { recursive: true, force: true }."

	^ self apply: #rmdir withArguments: { aString . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> rmdirSync: aString options: aDictionary [

	"Synchronous rmdir(2). Returns undefined.

	path <string> | <Buffer> | <URL>
	options <Object>
		maxRetries <integer> If an EBUSY, EMFILE, ENFILE, ENOTEMPTY, or EPERM error is encountered, Node.js retries the operation with a linear backoff wait of retryDelay milliseconds longer on each try. This option represents the number of retries. This option is ignored if the recursive option is not true. Default: 0.
		recursive <boolean> If true, perform a recursive directory removal. In recursive mode, operations are retried on failure. Default: false. Deprecated.
		retryDelay <integer> The amount of time in milliseconds to wait between retries. This option is ignored if the recursive option is not true. Default: 100.

	Using fs.rmdirSync() on a file (not a directory) results in an ENOENT error on Windows and an ENOTDIR error on POSIX.

	To get a behavior similar to the rm -rf Unix command, use fs.rmSync() with options { recursive: true, force: true }."

	^ self apply: #rmdirSync withArguments: { aString . aDictionary }
]

{ #category : #deprecated }
CpNodeJSFS >> syncReadFile: aString options: aDictionary [

	self flag: #deprecatedMethod.
	self warnCr: 'Use of any CpNodeJSFS''s #syncReadFile:options: is deprecated, please use #readFileSync:options:'.

	self readFileSync: aString options: aDictionary
]

{ #category : #deprecated }
CpNodeJSFS >> syncWriteFile: aString data: anObject options: aDictionary [

	self flag: #deprecatedMethod.
	self warnCr: 'Use of any CpNodeJSFS''s #syncWriteFile:data:options: is deprecated, please use #writeFileSync:data:options:'.

	self writeFileSync: aString data: anObject options: aDictionary
]

{ #category : #operations }
CpNodeJSFS >> unlink: aString do: aBlock [

	"Asynchronously removes a file or symbolic link. No arguments other than a possible exception are given to the completion callback.

	path <string> | <Buffer> | <URL>
	callback <Function>
		err <Error>

	fs.unlink() will not work on a directory, empty or otherwise. To remove a directory, use fs.rmdir()."

	^ self apply: #unlink withArguments: { aString . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> unlinkSync: aString [

	"Synchronous unlink(2). Returns undefined.

	path <string> | <Buffer> | <URL>"

	^ self apply: #unlinkSync withArguments: { aString }
]

{ #category : #operations }
CpNodeJSFS >> writeFile: aString data: anObject options: aDictionary do: aBlock [

	"Asynchronously write the specified data to the specified file using the options provided.

	The specified Block should accept one argument: err (see below).
	
	file <string> | <Buffer> | <URL> | <integer> filename or file descriptor
	data <string> | <Buffer> | <TypedArray> | <DataView>
	options <Object> | <string>
		encoding <string> | <null> Default: 'utf8'
		mode <integer> Default: 0o666
		flag <string> See support of file system flags. Default: 'w'.
		flush <boolean> If all data is successfully written to the file, and flush is true, fs.fsync() is used to flush the data. Default: false.
		signal <AbortSignal> allows aborting an in-progress writeFile
	callback <Function>
		err <Error> | <AggregateError>

	When file is a filename, asynchronously writes data to the file, replacing the file if it already exists. data can be a string or a buffer.

	When file is a file descriptor, the behavior is similar to calling fs.write() directly (which is recommended). See the notes below on using a file descriptor.

	The encoding option is ignored if data is a buffer.

	The mode option only affects the newly created file. See fs.open() for more details."

	self apply: #writeFile withArguments: { aString . anObject . aDictionary . aBlock asJavaScriptFunction }
]

{ #category : #operations }
CpNodeJSFS >> writeFileSync: aString data: anObject options: aDictionary [

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
