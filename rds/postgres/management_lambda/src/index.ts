import { ClientConfig } from "pg"
import Client from "pg/lib/client"
import pgConnectionString from "pg-connection-string"

interface Event {
  queries: string[]
  database?: string
}

export async function handler({ database, queries }: Event) {
  const clientConfig = pgConnectionString.parse(
    process.env.DATABASE_URL!,
  ) as ClientConfig

  if (database) {
    clientConfig.database = database
  }

  console.log(`Connecting to the '${clientConfig.database}' database...`)
  const client = new Client(clientConfig)
  await client.connect()

  try {
    for (const query of queries) {
      console.log("Running query: ", query)
      await client.query(query)
    }
  } finally {
    console.log(`Closing connection to the '${clientConfig.database}' database`)
    await client.end()
  }
}
