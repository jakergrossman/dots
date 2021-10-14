import {join} from 'path';

import Context from './context.js';
import tree from './tree.js';

/**
 * Get a list of files for an aspect, relative to the 'files'
 * directory of that aspect.
 *
 * @param `aspect` The name of the aspect to get files for. Defaults
 *                 to the current aspect (as indicated by
 *                 Context.currentAspect)
 */
export default async function aspectFiles(aspect?: string): Promise<string[]> {
  // default to current aspect
  if (aspect === undefined) {
    aspect = Context.currentAspect;
  }

  // root directory of aspect's files
  let aspectRoot = join(
    Context.attributes.root,
    'aspects',
    aspect,
    'files'
  );

  // get all files for aspect
  let files = await tree(aspectRoot);

  // trim aspectRoot from full path
  return Promise.resolve(files.map(x => x.slice(aspectRoot.length)));
}
