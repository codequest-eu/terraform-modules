import get from "lodash/get"
import Client from "pg/lib/client"

import * as db from "./commands/db"
import * as user from "./commands/user"
import { Command } from "./commands/command"

const commands = {
  db,
  user,
}

interface Event {
  commands: {
    path: string
    options: any
  }[]
}

export async function handler(event: Event) {
  console.log("Connecting to the database...")
  const client = new Client({ connectionString: process.env.DATABASE_URL })
  await client.connect()

  try {
    for (const { path, options } of event.commands) {
      const command: Command<any> = get(commands, path)

      if (!command) {
        throw new Error(`Unknown command ${path}`)
      }

      console.log(`Running ${path}...`)
      await command(options, { client })
    }
  } finally {
    console.log("Closing connection to the database")
    await client.end()
  }
}
