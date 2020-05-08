import { ClientConfig } from "pg"
import Client from "pg/lib/client"
import pgConnectionString from "pg-connection-string"

import { escapeId as id } from "../utils/pg"
import { Command } from "./command"

const { parse } = pgConnectionString

export const create: Command<{ db: string }> = async ({ db }, { client }) => {
  await client.query(`CREATE DATABASE ${id(db)}`)
}

export const drop: Command<{ db: string }> = async ({ db }, { client }) => {
  await client.query(`DROP DATABASE ${id(db)}`)
}

export const grantAll: Command<{ db: string; user: string }> = async (
  { db, user },
  { client },
) => {
  await client.query(`GRANT ALL ON DATABASE ${id(db)} to ${id(user)}`)
}

export const createExtension: Command<{
  db: string
  extension: string
}> = async ({ db, extension }) => {
  const dbConfig = parse(process.env.DB_URL!) as ClientConfig
  const dbClient = new Client({ ...dbConfig, database: db })
  await dbClient.connect()

  try {
    await dbClient.query(`CREATE EXTENSION IF NOT EXISTS ${id(extension)}`)
  } finally {
    await dbClient.end()
  }
}
