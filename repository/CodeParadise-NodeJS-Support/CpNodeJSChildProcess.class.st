Class {
	#name : #CpNodeJSChildProcess,
	#superclass : #CpNodeJSEventEmitter,
	#category : #'CodeParadise-NodeJS-Support-Process'
}

{ #category : #accessing }
CpNodeJSChildProcess >> exitCode [

	"The subprocess.exitCode property indicates the exit code of the child process. If the child process is still running, the field will be null."

	^ self propertyAt: #exitCode
]

{ #category : #operations }
CpNodeJSChildProcess >> kill: aStringOrInteger [

	"The subprocess.kill() method sends a signal to the child process. If no argument is given, the process will be sent the 'SIGTERM' signal. See signal(7) for a list of available signals. This function returns true if kill(2) succeeds, and false otherwise."

	^ self apply: #kill withArguments: { aStringOrInteger }
]

{ #category : #accessing }
CpNodeJSChildProcess >> killed [

	"The subprocess.killed property indicates whether the child process successfully received a signal from subprocess.kill(). The killed property does not indicate that the child process has been terminated."

	^ self propertyAt: #killed
]

{ #category : #accessing }
CpNodeJSChildProcess >> pid [

	"Returns the process identifier (PID) of the child process. If the child process fails to spawn due to errors, then the value is undefined and error is emitted."

	^ self propertyAt: #pid
]

{ #category : #accessing }
CpNodeJSChildProcess >> signalCode [

	"The subprocess.signalCode property indicates the signal received by the child process if any, else null."

	^ self propertyAt: #signalCode
]

{ #category : #accessing }
CpNodeJSChildProcess >> spawnargs [

	"The subprocess.spawnargs property represents the full list of command-line arguments the child process was launched with."

	^ self propertyAt: #spawnargs
]

{ #category : #accessing }
CpNodeJSChildProcess >> spawnfile [

	"The subprocess.spawnfile property indicates the executable file name of the child process that is launched.

For child_process.fork(), its value will be equal to process.execPath. For child_process.spawn(), its value will be the name of the executable file. For child_process.exec(), its value will be the name of the shell in which the child process is launched."

	^ self propertyAt: #spawnfile
]

{ #category : #accessing }
CpNodeJSChildProcess >> stderr [

	"A Readable Stream that represents the child process's stderr.

If the child process was spawned with stdio[2] set to anything other than 'pipe', then this will be null.

subprocess.stderr is an alias for subprocess.stdio[2]. Both properties will refer to the same value.

The subprocess.stderr property can be null or undefined if the child process could not be successfully spawned."

	^ self propertyAt: #stderr
]

{ #category : #accessing }
CpNodeJSChildProcess >> stdin [

	"A Writable Stream that represents the child process's stdin.

If a child process waits to read all of its input, the child process will not continue until this stream has been closed via end().

If the child process was spawned with stdio[0] set to anything other than 'pipe', then this will be null.

subprocess.stdin is an alias for subprocess.stdio[0]. Both properties will refer to the same value.

The subprocess.stdin property can be null or undefined if the child process could not be successfully spawned."

	^ self propertyAt: #stdin
]

{ #category : #accessing }
CpNodeJSChildProcess >> stdio [

	"A sparse array of pipes to the child process, corresponding with positions in the stdio option passed to child_process.spawn() that have been set to the value 'pipe'. subprocess.stdio[0], subprocess.stdio[1], and subprocess.stdio[2] are also available as subprocess.stdin, subprocess.stdout, and subprocess.stderr, respectively."

	^ self propertyAt: #stdio
]

{ #category : #accessing }
CpNodeJSChildProcess >> stdout [

	"A Readable Stream that represents the child process's stdout.

If the child process was spawned with stdio[1] set to anything other than 'pipe', then this will be null.

subprocess.stdout is an alias for subprocess.stdio[1]. Both properties will refer to the same value."

	^ self propertyAt: #stdout
]
