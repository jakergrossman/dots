import * as os from 'os';
import {existsSync} from 'fs';
import {dirname, join} from 'path';
import {fileURLToPath} from 'url';

/**
 * Read-Only System Attributes
 *
 * @prop {string} platform // Current Platform
 * @prop {string} home // Home Directory
 * @prop {string} backupDir // Backup Directory
 * @prop {string} root // Repository Root
 */
export default class Attributes {
    #platform?: 'darwin' | 'linux';
    #home?: string;
    #backupDir?: string;
    #root?: string;

    // TODO: possibly add distributions for linux.
    get platform(): string {
      if (!this.#platform) {
        // determine os
        const platform: string = os.platform().toLowerCase();
        if (/darwin/.test(platform)) {
          this.#platform = 'darwin';
        } else if (/linux/.test(platform)) {
          this.#platform = 'linux';
        } else {
          throw new Error('Platform "' + platform + '" not supported');
        }
      }

      return this.#platform;
    }

    get home(): string {
      if (!this.#home) {
        this.#home = os.homedir();
      }

      return this.#home;
    }

    get backupDir(): string {
      if (!this.#backupDir) {
        // '.backups' inside $HOME
        this.#backupDir = join(this.home, '.backups');
      }

      return this.#backupDir;
    }

    get root(): string {
      if (!this.#root) {
        // walk up directory tree until package-lock.json is found
        const __dirname = dirname(fileURLToPath(import.meta.url));

        this.#root = (function find(path: string): string {
          const target = 'package-lock.json';

          if (existsSync(join(path, target))) {
            return path;
          } else {
            const next = dirname(path);

            if (next === path) {
              throw new Error(`Searched up to ${path} and could not find ${target}`);
            }

            return find(dirname(path));
          }
        })(__dirname);
            

      }

      return this.#root;
    }
}

