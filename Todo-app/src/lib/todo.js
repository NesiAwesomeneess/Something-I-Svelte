import { updated } from "$app/stores";
import { writable } from "svelte/store";

function createTodoList() {
  const { subscribe, update } = writable(0);
  let uid = 1;

  return {
    subscribe,
    add: (task) => {
      const entry = {
        id: uid++,
        completed: false,
        task,
      };
      update(($todoList) => [...$todoList, entry]);
    },

    removeDone: () => {
      update(($todoList) => {
        $todoList.filter(({ completed }) => {
          return !completed;
        });
      });
    },
  };
}

export const todoList = createTodoList();
