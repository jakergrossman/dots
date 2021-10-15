// https://stackoverflow.com/a/5947802/2103996
const BOLD='\x1b[1m';
const GREEN='\x1b[32m';
const RED='\x1b[35m';
const YELLOW='\x1b[33m';
const RESET='\x1b[0m';

/**
 * Provides log functions analagous to those
 * in '$REPO_ROOT/bin/common'
 */
export default abstract class Log {

  static log(msg: string) {
    process.stderr.write(`${msg}\n`);
  }

  static info(msg: string) {
    Log.log(`${BOLD}[INFO]${RESET}   ${msg}`)
  }

  static run(msg: string) {
    Log.log(`${GREEN}[RUN]${RESET}    ${msg}`)
  }

  static warn(msg: string) {
    Log.log(`${YELLOW}[WARN]${RESET}   ${msg}`)
  }

  static error(msg: string) {
    Log.log(`${RED}[ERROR]${RESET}  ${msg}`)
  }
}
