import Client from "pg/lib/client"
import pgConnectionString from "pg-connection-string"

import { GetParameterCommand, SSMClient } from "@aws-sdk/client-ssm"

interface Event {
  queries: string[]
  database?: string
}

const ssmClient = new SSMClient({})

export async function handler({ database, queries }: Event) {
  const clientConfig = pgConnectionString.parse(await getDatabaseUrl())

  if (database) {
    clientConfig.database = database
  }

  console.log(`Connecting to the '${clientConfig.database}' database...`)
  const client = new Client({
    ...clientConfig,

    // fix incompatibilities between pg and pg-connection-string
    database: clientConfig.database ?? undefined,
    host: clientConfig.host ?? undefined,
    port: clientConfig.port ? Number(clientConfig.port) : undefined,
    ssl: true,
  })
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

async function getDatabaseUrl() {
  if (process.env.DATABASE_URL) {
    return process.env.DATABASE_URL
  }

  if (process.env.DATABASE_URL_PARAM) {
    const paramName = process.env.DATABASE_URL_PARAM

    const result = await ssmClient.send(
      new GetParameterCommand({
        Name: paramName,
        WithDecryption: true,
      })
    )

    const paramValue = result.Parameter?.Value

    if (!paramValue) {
      throw new Error(`Failed to fetch ${paramName} from SSM`)
    }

    return paramValue
  }

  throw new Error("Database credentials not provided")
}
