/**
 * Type alias for asynchronous function
 */
type Callback = () => Promise<void>;

/**
 * Registry of aspect tasks.
 */
export default class TaskRegistry {
  #callbacks: Map<string, Array<[Callback, string]>>;

  constructor() {
    this.#callbacks = new Map();
  }

  /**
   * Register a new task
   *
   * @param `aspect` The aspect the task is for
   * @param `description` Short description of the task
   * @param `callback` The callback to run for this task
   */
  register(aspect: string, description: string, callback: Callback) {
    if (!this.#callbacks.has(aspect)) {
      this.#callbacks.set(aspect, []);
    }

    this.#callbacks.get(aspect)!.push([callback, description]);
  }

  get(aspect: string): Array<[Callback, string]> {
    return this.#callbacks.get(aspect) || [];
  }
}

