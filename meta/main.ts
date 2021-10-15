import {open} from 'fs/promises';

import Context from './context.js';
import Log from './log.js';

import assert from './assert.js';

/**
 * Entry point for configuration
 */
async function main(): Promise<void> {

  // read platform information from package.json
  const fd = await open('package.json', 'r')
  let json = await fd.readFile({encoding: 'utf-8'});
  await fd.close();

  // make sure package.json has a platforms object
  let obj = JSON.parse(json);
  assert(obj.platforms);
  let platforms = obj.platforms;

  // get aspects for current platform
  let aspects = platforms[Context.attributes.platform]['aspects'];

  // register tasks
  for (const aspect of aspects) {
    await loadAspect(aspect);
  }

  // run tasks
    Log.run(`Running tasks for platform "${Context.attributes.platform}"`);
    for (const aspect of aspects) {
      // Update context
      Context.currentAspect = aspect;

      // Print and run an aspects tasks, if there are any
      if (Context.tasks.get(Context.currentAspect).length > 0) {
        Log.info(Context.currentAspect);
        for (const [callback, description] of Context.tasks.get(aspect)) {
          Log.run('\\ ' + description);

        try {
          await callback();
        } catch (err) {
          Log.error('TASK FAILED');
        }
      }
    }
  }
}

// TODO: should this by inline?
/**
 * Load an aspects tasks
 *
 * @param `aspect` The aspect to load
 */
async function loadAspect(aspect: string): Promise<void> {
  try {
    await import('../aspects/' + aspect + '/index.js');
  } catch (err) {
    Log.error('Could not import aspect "' + aspect + '"');
  }
}

// TODO: proper error handling/recovery
main().catch(console.error);
