import { sveltekit } from "@sveltejs/kit/vite";
import { defineConfig } from "vite";
import vitePluginString from "vite-plugin-string";

export default defineConfig({
  plugins: [sveltekit(), vitePluginString()],
  ssr: {
    noExternal: ["three", "troika-three-text"],
  },
});
