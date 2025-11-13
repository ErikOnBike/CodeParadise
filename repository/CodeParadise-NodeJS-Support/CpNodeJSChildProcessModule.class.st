Class {
	#name : #CpNodeJSChildProcessModule,
	#superclass : #CpNodeJSBuiltinModule,
	#category : #'CodeParadise-NodeJS-Support-Process'
}

{ #category : #'instance creation' }
CpNodeJSChildProcessModule class >> moduleName [

	^ 'node:child_process'
]

{ #category : #'class initialization' }
CpNodeJSChildProcessModule class >> namespace [

	"The NodeJS module 'process' acts as a namespace"

	^ self require
]

{ #category : #operations }
CpNodeJSChildProcessModule >> exec: aString options: aDictionary callback: aBlock [

	"Spawns a shell then executes the command within that shell, buffering any generated output. The command string passed to the exec function is processed directly by the shell and special characters (vary based on shell) need to be dealt with accordingly.

	command <string> The command to run, with space-separated arguments.
	options <Object>
		cwd <string> | <URL> Current working directory of the child process. Default: process.cwd().
		env <Object> Environment key-value pairs. Default: process.env.
		encoding <string> Default: 'utf8'
		shell <string> Shell to execute the command with. See Shell requirements and Default Windows shell. Default: '/bin/sh' on Unix, process.env.ComSpec on Windows.
		signal <AbortSignal> allows aborting the child process using an AbortSignal.
		timeout <number> Default: 0
		maxBuffer <number> Largest amount of data in bytes allowed on stdout or stderr. If exceeded, the child process is terminated and any output is truncated. See caveat at maxBuffer and Unicode. Default: 1024 * 1024.
		killSignal <string> | <integer> Default: 'SIGTERM'
		uid <number> Sets the user identity of the process (see setuid(2)).
		gid <number> Sets the group identity of the process (see setgid(2)).
		windowsHide <boolean> Hide the subprocess console window that would normally be created on Windows systems. Default: false.
	callback <Function> called with the output when process terminates.
		error <Error>
		stdout <string> | <Buffer>
		stderr <string> | <Buffer>

	Returns: <ChildProcess>"

	^ self apply: #exec withArguments: { aString . aDictionary . aBlock asJavaScriptFunction } resultAs: CpNodeJSChildProcess
]

{ #category : #operations }
CpNodeJSChildProcessModule >> execFile: aString arguments: anArray options: aDictionary callback: aBlock [

	"The child_process.execFile() function is similar to child_process.exec() except that it does not spawn a shell by default. Rather, the specified executable file is spawned directly as a new process making it slightly more efficient than child_process.exec().

	The same options as child_process.exec() are supported. Since a shell is not spawned, behaviors such as I/O redirection and file globbing are not supported.

	command <string> The command to run, with space-separated arguments.
	options <Object>
		cwd <string> | <URL> Current working directory of the child process. Default: process.cwd().
		env <Object> Environment key-value pairs. Default: process.env.
		encoding <string> Default: 'utf8'
		shell <string> Shell to execute the command with. See Shell requirements and Default Windows shell. Default: '/bin/sh' on Unix, process.env.ComSpec on Windows.
		signal <AbortSignal> allows aborting the child process using an AbortSignal.
		timeout <number> Default: 0
		maxBuffer <number> Largest amount of data in bytes allowed on stdout or stderr. If exceeded, the child process is terminated and any output is truncated. See caveat at maxBuffer and Unicode. Default: 1024 * 1024.
		killSignal <string> | <integer> Default: 'SIGTERM'
		uid <number> Sets the user identity of the process (see setuid(2)).
		gid <number> Sets the group identity of the process (see setgid(2)).
		windowsHide <boolean> Hide the subprocess console window that would normally be created on Windows systems. Default: false.
	callback <Function> called with the output when process terminates.
		error <Error>
		stdout <string> | <Buffer>
		stderr <string> | <Buffer>

	Returns: <ChildProcess>"

	^ self apply: #execFile withArguments: { aString . anArray . aDictionary . aBlock asJavaScriptFunction } resultAs: CpNodeJSChildProcess
]

{ #category : #operations }
CpNodeJSChildProcessModule >> execFileSync: aString arguments: anArray options: aDictionary [

	"The child_process.execFileSync() method is generally identical to child_process.execFile() with the exception that the method will not return until the child process has fully closed. When a timeout has been encountered and killSignal is sent, the method won't return until the process has completely exited.

	If the child process intercepts and handles the SIGTERM signal and does not exit, the parent process will still wait until the child process has exited.

	If the process times out or has a non-zero exit code, this method will throw an Error that will include the full result of the underlying child_process.spawnSync().

	If the shell option is enabled, do not pass unsanitized user input to this function. Any input containing shell metacharacters may be used to trigger arbitrary command execution.

	file <string> The name or path of the executable file to run.
	args <string[]> List of string arguments.
	options <Object>
		cwd <string> | <URL> Current working directory of the child process.
		input <string> | <Buffer> | <TypedArray> | <DataView> The value which will be passed as stdin to the spawned process. If stdio[0] is set to 'pipe', Supplying this value will override stdio[0].
		stdio <string> | <Array> Child's stdio configuration. See child_process.spawn()'s stdio. stderr by default will be output to the parent process' stderr unless stdio is specified. Default: 'pipe'.
		env <Object> Environment key-value pairs. Default: process.env.
		uid <number> Sets the user identity of the process (see setuid(2)).
		gid <number> Sets the group identity of the process (see setgid(2)).
		timeout <number> In milliseconds the maximum amount of time the process is allowed to run. Default: undefined.
		killSignal <string> | <integer> The signal value to be used when the spawned process will be killed. Default: 'SIGTERM'.
		maxBuffer <number> Largest amount of data in bytes allowed on stdout or stderr. If exceeded, the child process is terminated. See caveat at maxBuffer and Unicode. Default: 1024 * 1024.
		encoding <string> The encoding used for all stdio inputs and outputs. Default: 'buffer'.
		windowsHide <boolean> Hide the subprocess console window that would normally be created on Windows systems. Default: false.
		shell <boolean> | <string> If true, runs command inside of a shell. Uses '/bin/sh' on Unix, and process.env.ComSpec on Windows. A different shell can be specified as a string. See Shell requirements and Default Windows shell. Default: false (no shell).

	Returns: <Buffer> | <string> The stdout from the command."

	^ self apply: #execFileSync withArguments: { aString . anArray . aDictionary }
]

{ #category : #operations }
CpNodeJSChildProcessModule >> execSync: aString options: aDictionary [

	"The child_process.execSync() method is generally identical to child_process.exec() with the exception that the method will not return until the child process has fully closed. When a timeout has been encountered and killSignal is sent, the method won't return until the process has completely exited. If the child process intercepts and handles the SIGTERM signal and doesn't exit, the parent process will wait until the child process has exited.

	If the process times out or has a non-zero exit code, this method will throw. The Error object will contain the entire result from child_process.spawnSync().

	Never pass unsanitized user input to this function. Any input containing shell metacharacters may be used to trigger arbitrary command execution.

	command <string> The command to run.
	options <Object>
		cwd <string> | <URL> Current working directory of the child process.
		input <string> | <Buffer> | <TypedArray> | <DataView> The value which will be passed as stdin to the spawned process. If stdio[0] is set to 'pipe', Supplying this value will override stdio[0].
		stdio <string> | <Array> Child's stdio configuration. See child_process.spawn()'s stdio. stderr by default will be output to the parent process' stderr unless stdio is specified. Default: 'pipe'.
		env <Object> Environment key-value pairs. Default: process.env.
		shell <string> Shell to execute the command with. See Shell requirements and Default Windows shell. Default: '/bin/sh' on Unix, process.env.ComSpec on Windows.
		uid <number> Sets the user identity of the process. (See setuid(2)).
		gid <number> Sets the group identity of the process. (See setgid(2)).
		timeout <number> In milliseconds the maximum amount of time the process is allowed to run. Default: undefined.
		killSignal <string> | <integer> The signal value to be used when the spawned process will be killed. Default: 'SIGTERM'.
		maxBuffer <number> Largest amount of data in bytes allowed on stdout or stderr. If exceeded, the child process is terminated and any output is truncated. See caveat at maxBuffer and Unicode. Default: 1024 * 1024.
		encoding <string> The encoding used for all stdio inputs and outputs. Default: 'buffer'.
		windowsHide <boolean> Hide the subprocess console window that would normally be created on Windows systems. Default: false.

	Returns: <Buffer> | <string> The stdout from the command."

	^ self apply: #execSync withArguments: { aString . aDictionary }
]

{ #category : #operations }
CpNodeJSChildProcessModule >> spawn: aString arguments: anArray options: aDictionary [

	"The child_process.spawn() method spawns a new process using the given command, with command-line arguments in args. If omitted, args defaults to an empty array.

	If the shell option is enabled, do not pass unsanitized user input to this function. Any input containing shell metacharacters may be used to trigger arbitrary command execution.

	A third argument may be used to specify additional options, with these defaults:
		const defaults = {
		  cwd: undefined,
		  env: process.env,
		}; copy

	Use cwd to specify the working directory from which the process is spawned. If not given, the default is to inherit the current working directory. If given, but the path does not exist, the child process emits an ENOENT error and exits immediately. ENOENT is also emitted when the command does not exist.

	Use env to specify environment variables that will be visible to the new process, the default is process.env.
	undefined values in env will be ignored.

	command <string> The command to run.
	args <string[]> List of string arguments.
	options <Object>
		cwd <string> | <URL> Current working directory of the child process.
		env <Object> Environment key-value pairs. Default: process.env.
		argv0 <string> Explicitly set the value of argv[0] sent to the child process. This will be set to command if not specified.
		stdio <Array> | <string> Child's stdio configuration (see options.stdio).
		detached <boolean> Prepare child process to run independently of its parent process. Specific behavior depends on the platform (see options.detached).
		uid <number> Sets the user identity of the process (see setuid(2)).
		gid <number> Sets the group identity of the process (see setgid(2)).
		serialization <string> Specify the kind of serialization used for sending messages between processes. Possible values are 'json' and 'advanced'. See Advanced serialization for more details. Default: 'json'.
		shell <boolean> | <string> If true, runs command inside of a shell. Uses '/bin/sh' on Unix, and process.env.ComSpec on Windows. A different shell can be specified as a string. See Shell requirements and Default Windows shell. Default: false (no shell).
		windowsVerbatimArguments <boolean> No quoting or escaping of arguments is done on Windows. Ignored on Unix. This is set to true automatically when shell is specified and is CMD. Default: false.
		windowsHide <boolean> Hide the subprocess console window that would normally be created on Windows systems. Default: false.
		signal <AbortSignal> allows aborting the child process using an AbortSignal.
		timeout <number> In milliseconds the maximum amount of time the process is allowed to run. Default: undefined.
		killSignal <string> | <integer> The signal value to be used when the spawned process will be killed by timeout or abort signal. Default: 'SIGTERM'.

	Returns: <ChildProcess>"

	^ self apply: #spawn withArguments: { aString . anArray . aDictionary } resultAs: CpNodeJSChildProcess
]

{ #category : #operations }
CpNodeJSChildProcessModule >> spawnSync: aString arguments: anArray options: aDictionary [

	"The child_process.spawnSync() method is generally identical to child_process.spawn() with the exception that the function will not return until the child process has fully closed. When a timeout has been encountered and killSignal is sent, the method won't return until the process has completely exited. If the process intercepts and handles the SIGTERM signal and doesn't exit, the parent process will wait until the child process has exited.

	If the shell option is enabled, do not pass unsanitized user input to this function. Any input containing shell metacharacters may be used to trigger arbitrary command execution.

	command <string> The command to run.
	args <string[]> List of string arguments.
	options <Object>
		cwd <string> | <URL> Current working directory of the child process.
		input <string> | <Buffer> | <TypedArray> | <DataView> The value which will be passed as stdin to the spawned process. If stdio[0] is set to 'pipe', Supplying this value will override stdio[0].
		argv0 <string> Explicitly set the value of argv[0] sent to the child process. This will be set to command if not specified.
		stdio <string> | <Array> Child's stdio configuration. See child_process.spawn()'s stdio. Default: 'pipe'.
		env <Object> Environment key-value pairs. Default: process.env.
		uid <number> Sets the user identity of the process (see setuid(2)).
		gid <number> Sets the group identity of the process (see setgid(2)).
		timeout <number> In milliseconds the maximum amount of time the process is allowed to run. Default: undefined.
		killSignal <string> | <integer> The signal value to be used when the spawned process will be killed. Default: 'SIGTERM'.
		maxBuffer <number> Largest amount of data in bytes allowed on stdout or stderr. If exceeded, the child process is terminated and any output is truncated. See caveat at maxBuffer and Unicode. Default: 1024 * 1024.
		encoding <string> The encoding used for all stdio inputs and outputs. Default: 'buffer'.
		shell <boolean> | <string> If true, runs command inside of a shell. Uses '/bin/sh' on Unix, and process.env.ComSpec on Windows. A different shell can be specified as a string. See Shell requirements and Default Windows shell. Default: false (no shell).
		windowsVerbatimArguments <boolean> No quoting or escaping of arguments is done on Windows. Ignored on Unix. This is set to true automatically when shell is specified and is CMD. Default: false.
		windowsHide <boolean> Hide the subprocess console window that would normally be created on Windows systems. Default: false.

	Returns: <Object>
		pid <number> Pid of the child process.
		output <Array> Array of results from stdio output.
		stdout <Buffer> | <string> The contents of output[1].
		stderr <Buffer> | <string> The contents of output[2].
		status <number> | <null> The exit code of the subprocess, or null if the subprocess terminated due to a signal.
		signal <string> | <null> The signal used to kill the subprocess, or null if the subprocess did not terminate due to a signal.
		error <Error> The error object if the child process failed or timed out."

	^ self apply: #spawnSync withArguments: { aString . anArray . aDictionary } resultAs: Dictionary
]
