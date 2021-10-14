import TaskRegistry from './taskRegistry.js'
import Attributes from './attributes.js';
import assert from './assert.js'

// try to keep global state in one place
class Context {
  #attributes: Attributes = new Attributes();
  #currentAspect?: string;
  #tasks: TaskRegistry = new TaskRegistry();

  get attributes(): Attributes {
    return this.#attributes;
  }

  get currentAspect(): string {
    assert(this.#currentAspect);

    return this.#currentAspect;
  }

  set currentAspect(aspect: string) {
    this.#currentAspect = aspect;
  }

  get tasks(): TaskRegistry {
    return this.#tasks;
  }
}

export default new Context();
