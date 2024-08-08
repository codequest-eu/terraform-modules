import { createConnection } from "mysql2"

interface Event {
  queries: string[]
  database?: string
}

export async function handler({ database, queries }: Event) {
  const connection = createConnection(process.env.DATABASE_URL!)

  if (database) {
    connection.config.database = database
  }

  console.log(`Connecting to the '${connection.config.database}' database...`)
  connection.connect()

  try {
    for (const query of queries) {
      console.log("Running query: ", query)

      await new Promise<void>((resolve, reject) => {
        connection.query(query, err => {
          err ? reject(err) : resolve()
        })
      })
    }
  } finally {
    console.log(
      `Closing connection to the '${connection.config.database}' database`,
    )
    connection.end()
  }
}
