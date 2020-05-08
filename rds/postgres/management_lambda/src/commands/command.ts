import Client from "pg/lib/client"

export interface CommandContext {
  client: Client
}

export type Command<T = any> = (
  options: T,
  context: CommandContext,
) => Promise<void>
