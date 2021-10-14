import {
  Context,
} from 'meta';

/**
 * @type {Object} Task // A task to perform as part of an aspect's installation
 * @prop {string} aspect // Name of the aspect this task is for
 * @prop {string} description // Short description of the task
 * @prop {function} callback // Callback to execute for this task
 */
export type Task = {
  aspect: string,
  description: string,
  callback: (...arg: any[]) => void
}

/**
 * Register a task for an aspect
 *
 * @param `aspect` The aspect the task is for
 * @param `description` Short description of the task
 * @param `callback` The callback to run for this task
 */
export default function task(
  aspect: string,
  description: string,
  callback: () => Promise<void>
) {
  Context.tasks.register(aspect, description, callback);
}
