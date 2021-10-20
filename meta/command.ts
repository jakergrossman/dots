import {spawn} from 'child_process';

/**
 * @type {Object} Result // Details about the execution of the command.
 * @prop {string} command // The command that was run, including args.
 * @prop {string|null} signal // The signal that terminated the child process, if any.
 * @prop {string|null} status // The status code returned by the command, if any.
 * @prop {string} stdout // Data written to STDOUT by the child process.
 * @prop {string} stderr // Data written to STDERR by the child process.
 */
type Result = {
  command: string,
  signal: string | null;
  status: number | null,
  stdout: string,
  stderr: string,
}

type Options = {
  cwd?: string,
  env?: NodeJS.ProcessEnv,
}

/**
 * Runs an external command.
 *
 * @param `executable` The name of the program (argv[0])
 * @param `args` The argument to the program (argv[1..])
 * @param `cwd?` CWD to use when running the command.
 */
export default async function command(
  executable: string,
  args: string[] = [],
  options: Options = {}
): Promise<Result> {
  return new Promise(resolve => {
    // initialize result
    const result = {
      command: [executable, ...args].join(' '),
      signal: null,
      status: null,
      stdout: '',
      stderr: '',
    }

    let child = spawn(executable, args, options);

    // log stdout
    child.stdout.on('data', (data) => {
      result.stdout += data;
    });

    // log stderr
    child.stderr.on('data', (data) => {
      result.stderr += data;
    });

    // log status or signal, if appropriate.
    child.on('exit', (status, signal) => {
      if (typeof status === 'number') {
        resolve({...result, status});
      } else if (signal) {
        resolve({...result, signal});
      } else {
        throw new Error('command(): bad exit');
      }
    });
  });
}
