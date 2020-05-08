import { literal } from "pg-escape"

import { escapeId as id } from "../utils/pg"
import { Command } from "./command"

export const create: Command<{ user: string; password: string }> = async (
  { user, password },
  { client },
) => {
  await client.query(
    `CREATE ROLE ${id(user)} WITH LOGIN PASSWORD ${literal(password)}`,
  )
}

export const drop: Command<{ user: string }> = async ({ user }, { client }) => {
  await client.query(`DROP ROLE ${id(user)}`)
}
