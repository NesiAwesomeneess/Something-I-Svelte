import { writable } from "svelte/store";

export const context = writable("null");
export const pointerEnabled = writable(true);
export const pointerPosition = writable({ x: 0, y: 0 });
