import {readdir, stat} from 'fs/promises';
import {join} from 'path';

/**
 * Return a list of filenames discovered in a DFS of the directory tree.
 *
 * @param `root` The path for the root of the tree
 * @param `depth?` The maximum number of levels to traverse, if defined
 */
export default async function tree(root: string, depth?: number): Promise<string[]> {
  // all files, including directories
  let files: string[] = await readdir(root);

  // only files
  var leafFiles: string[] = [];

  // depth is unlimited or maximum depth not exceeded
  if (depth === undefined || depth > 0) {
    for (const file of files) {
      let nextFile = join(root, file);

      let stats = await stat(nextFile);

      if (stats.isDirectory()) {
        // if depth is not undefined, decrement remaining levels
        depth = depth ? depth-- : depth;

        // get all children of nextFile (DFS)
        let containedFiles: string[] = await tree(nextFile, depth);

        // concat found files
        leafFiles = leafFiles.concat(containedFiles);
      } else if (stats.isFile()) {
        // nextFile is a leaf file
        leafFiles.push(nextFile);
      } else {
        throw new Error(`tree(): ${nextFile} is not a directory or regular file`);
      }
    }
  }

  return Promise.resolve(leafFiles);
}
