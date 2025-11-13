Class {
	#name : #CpNodeJSProcess,
	#superclass : #CpNodeJSBuiltinModule,
	#category : #'CodeParadise-NodeJS-Support-Process'
}

{ #category : #'class initialization' }
CpNodeJSProcess class >> namespace [

	"The NodeJS module 'process' acts as a namespace"

	^ self require
]

{ #category : #accessing }
CpNodeJSProcess >> arch [

	"The operating system CPU architecture for which the Node.js binary was compiled. Possible values are: 'arm', 'arm64', 'ia32', 'loong64', 'mips', 'mipsel', 'ppc64', 'riscv64', 's390', 's390x', and 'x64'."

	^ self propertyAt: #arch
]

{ #category : #accessing }
CpNodeJSProcess >> argv [

	"The process.argv property returns an array containing the command-line arguments passed when the Node.js process was launched. The first element will be process.execPath. See process.argv0 if access to the original value of argv[0] is needed. The second element will be the path to the JavaScript file being executed. The remaining elements will be any additional command-line arguments."

	^ self propertyAt: #argv
]

{ #category : #accessing }
CpNodeJSProcess >> argv0 [

	"The process.argv0 property stores a read-only copy of the original value of argv[0] passed when Node.js starts."

	^ self propertyAt: #argv0
]

{ #category : #operations }
CpNodeJSProcess >> chdir: aString [

	"The process.chdir() method changes the current working directory of the Node.js process or throws an exception if doing so fails (for instance, if the specified directory does not exist)."

	self apply: #chdir withArguments: { aString }
]

{ #category : #accessing }
CpNodeJSProcess >> config [

	"The process.config property returns a frozen Object containing the JavaScript representation of the configure options used to compile the current Node.js executable. This is the same as the config.gypi file that was produced when running the ./configure script."

	^ self propertyAt: #config
]

{ #category : #operations }
CpNodeJSProcess >> cwd [

	"The process.cwd() method returns the current working directory of the Node.js process."

	^ self apply: #cwd
]

{ #category : #accessing }
CpNodeJSProcess >> env [

	"The process.env property returns an object containing the user environment. See environ(7)."

	^ self propertyAt: #env resultAs: Dictionary
]

{ #category : #accessing }
CpNodeJSProcess >> execArgv [

	"The process.execArgv property returns the set of Node.js-specific command-line options passed when the Node.js process was launched. These options do not appear in the array returned by the process.argv property, and do not include the Node.js executable, the name of the script, or any options following the script name. These options are useful in order to spawn child processes with the same execution environment as the parent."

	^ self propertyAt: #execArgv
]

{ #category : #accessing }
CpNodeJSProcess >> execPath [

	"The process.execPath property returns the absolute pathname of the executable that started the Node.js process. Symbolic links, if any, are resolved."

	^ self propertyAt: #execPath
]

{ #category : #operations }
CpNodeJSProcess >> exit [

	"The process.exit() method instructs Node.js to terminate the process synchronously with an exit status of code. If code is omitted, exit uses either the 'success' code 0 or the value of process.exitCode if it has been set. Node.js will not terminate until all the 'exit' event listeners are called."

	self apply: #exit
]

{ #category : #operations }
CpNodeJSProcess >> exit: anInteger [

	"The process.exit() method instructs Node.js to terminate the process synchronously with an exit status of code. If code is omitted, exit uses either the 'success' code 0 or the value of process.exitCode if it has been set. Node.js will not terminate until all the 'exit' event listeners are called."

	self apply: #exit withArguments: { anInteger }
]

{ #category : #accessing }
CpNodeJSProcess >> exitCode [

	"A number which will be the process exit code, when the process either exits gracefully, or is exited via process.exit() without specifying a code."

	^ self propertyAt: #exitCode
]

{ #category : #accessing }
CpNodeJSProcess >> exitCode: anInteger [

	"A number which will be the process exit code, when the process either exits gracefully, or is exited via process.exit() without specifying a code."

	self propertyAt: #exitCode put: anInteger
]

{ #category : #accessing }
CpNodeJSProcess >> fd [

	"This property refers to the value of underlying file descriptor of process.stdin. The value is fixed at 0."

	^ self propertyAt: #fd
]

{ #category : #operations }
CpNodeJSProcess >> getgid [

	"The process.getgid() method returns the numerical group identity of the process. (See getgid(2).)"

	^ self apply: #getgid
]

{ #category : #operations }
CpNodeJSProcess >> getuid [

	"The process.getuid() method returns the numeric user identity of the process. (See getuid(2).)"

	^ self apply: #getuid
]

{ #category : #operations }
CpNodeJSProcess >> kill: anInteger [

	"The process.kill() method sends the signal to the process identified by pid.

Signal names are strings such as 'SIGINT' or 'SIGHUP'. See Signal Events and kill(2) for more information.

This method will throw an error if the target pid does not exist. As a special case, a signal of 0 can be used to test for the existence of a process. Windows platforms will throw an error if the pid is used to kill a process group.

Even though the name of this function is process.kill(), it is really just a signal sender, like the kill system call. The signal sent may do something other than kill the target process.

	pid <number> A process ID
	signal <string> | <number> The signal to send, either as a string or number. Default: 'SIGTERM'."

	self apply: #kill withArguments: { anInteger }
]

{ #category : #operations }
CpNodeJSProcess >> kill: anInteger signal: aStringOrInteger [

	"The process.kill() method sends the signal to the process identified by pid.

Signal names are strings such as 'SIGINT' or 'SIGHUP'. See Signal Events and kill(2) for more information.

This method will throw an error if the target pid does not exist. As a special case, a signal of 0 can be used to test for the existence of a process. Windows platforms will throw an error if the pid is used to kill a process group.

Even though the name of this function is process.kill(), it is really just a signal sender, like the kill system call. The signal sent may do something other than kill the target process.

	pid <number> A process ID
	signal <string> | <number> The signal to send, either as a string or number. Default: 'SIGTERM'."

	self apply: #kill withArguments: { anInteger . aStringOrInteger }
]

{ #category : #accessing }
CpNodeJSProcess >> pid [

	"The process.pid property returns the PID of the process."

	^ self propertyAt: #pid
]

{ #category : #accessing }
CpNodeJSProcess >> ppid [

	"The process.ppid property returns the PID of the parent of the current process."

	^ self propertyAt: #ppid
]

{ #category : #operations }
CpNodeJSProcess >> setgid: aStringOrInteger [

	"The process.setgid() method sets the group identity of the process. (See setgid(2).) The id can be passed as either a numeric ID or a group name string. If a group name is specified, this method blocks while resolving the associated numeric ID."

	self apply: #setgid withArguments: { aStringOrInteger }
]

{ #category : #operations }
CpNodeJSProcess >> setuid: aStringOrInteger [

	"The process.setuid(id) method sets the user identity of the process. (See setuid(2).) The id can be passed as either a numeric ID or a username string. If a username is specified, the method blocks while resolving the associated numeric ID."

	self apply: #setuid withArguments: { aStringOrInteger }
]

{ #category : #accessing }
CpNodeJSProcess >> stderr [

	"The process.stderr property returns a stream connected to stderr (fd 2). It is a net.Socket (which is a Duplex stream) unless fd 2 refers to a file, in which case it is a Writable stream.

process.stderr differs from other Node.js streams in important ways. See note on process I/O for more information."

	^ self propertyAt: #stderr
]

{ #category : #accessing }
CpNodeJSProcess >> stdin [

	"The process.stdin property returns a stream connected to stdin (fd 0). It is a net.Socket (which is a Duplex stream) unless fd 0 refers to a file, in which case it is a Readable stream.

For details of how to read from stdin see readable.read()."

	^ self propertyAt: #stdin
]

{ #category : #accessing }
CpNodeJSProcess >> stdout [

	"The process.stdout property returns a stream connected to stdout (fd 1). It is a net.Socket (which is a Duplex stream) unless fd 1 refers to a file, in which case it is a Writable stream."

	^ self propertyAt: #stdout
]

{ #category : #accessing }
CpNodeJSProcess >> title [

	"The process.title property returns the current process title (i.e. returns the current value of ps). Assigning a new value to process.title modifies the current value of ps.

When a new value is assigned, different platforms will impose different maximum length restrictions on the title. Usually such restrictions are quite limited. For instance, on Linux and macOS, process.title is limited to the size of the binary name plus the length of the command-line arguments because setting the process.title overwrites the argv memory of the process. Node.js v0.8 allowed for longer process title strings by also overwriting the environ memory but that was potentially insecure and confusing in some (rather obscure) cases.

Assigning a value to process.title might not result in an accurate label within process manager applications such as macOS Activity Monitor or Windows Services Manager."

	^ self propertyAt: #title
]

{ #category : #accessing }
CpNodeJSProcess >> title: aString [

	"The process.title property returns the current process title (i.e. returns the current value of ps). Assigning a new value to process.title modifies the current value of ps.

When a new value is assigned, different platforms will impose different maximum length restrictions on the title. Usually such restrictions are quite limited. For instance, on Linux and macOS, process.title is limited to the size of the binary name plus the length of the command-line arguments because setting the process.title overwrites the argv memory of the process. Node.js v0.8 allowed for longer process title strings by also overwriting the environ memory but that was potentially insecure and confusing in some (rather obscure) cases.

Assigning a value to process.title might not result in an accurate label within process manager applications such as macOS Activity Monitor or Windows Services Manager."

	self propertyAt: #title put: aString
]

{ #category : #operations }
CpNodeJSProcess >> umask: anInteger [

	"process.umask(mask) sets the Node.js process's file mode creation mask. Child processes inherit the mask from the parent process. Returns the previous mask."
	
	^ self apply: #umask withArguments: { anInteger }
]

{ #category : #accessing }
CpNodeJSProcess >> uptime [

	"The process.uptime() method returns the number of seconds the current Node.js process has been running.

The return value includes fractions of a second. Use Math.floor() to get whole seconds."

	^ self propertyAt: #uptime
]

{ #category : #accessing }
CpNodeJSProcess >> version [

	"The process.version property contains the Node.js version string."

	^ self propertyAt: #version
]
