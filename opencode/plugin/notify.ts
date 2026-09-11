import type { Plugin } from "@opencode-ai/plugin"

const NOTIFY = `${process.env.DOTFILES ?? `${process.env.HOME}/dotfiles`}/agents/notify.sh`

export default (async ({ $ }) => {
  return {
    "permission.ask": async () => {
      await $`${NOTIFY} ${"opencode needs your permission!"} Blow opencode`.nothrow().quiet()
    },
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`${NOTIFY} ${"opencode finished!"} Glass opencode`.nothrow().quiet()
      }
    },
  }
}) satisfies Plugin
