'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var node_modules = require('./node_modules.js');
require('events');
require('util');
require('crypto');
require('path');
require('fs');
require('stream');
require('string_decoder');
require('dns');
require('url');
require('net');
require('assert');
require('tls');

function escapeId(value) {
    return `"${value.replace(/"/g, '""')}"`;
}

const { parse } = node_modules.pgConnectionString;
const create = async ({ db }, { client }) => {
    await client.query(`CREATE DATABASE ${escapeId(db)}`);
};
const drop = async ({ db }, { client }) => {
    await client.query(`DROP DATABASE ${escapeId(db)}`);
};
const grantAll = async ({ db, user }, { client }) => {
    await client.query(`GRANT ALL ON DATABASE ${escapeId(db)} to ${escapeId(user)}`);
};
const createExtension = async ({ db, extension }) => {
    const dbConfig = parse(process.env.DATABASE_URL);
    const dbClient = new node_modules.client({ ...dbConfig, database: db });
    await dbClient.connect();
    try {
        await dbClient.query(`CREATE EXTENSION IF NOT EXISTS ${escapeId(extension)}`);
    }
    finally {
        await dbClient.end();
    }
};

var db = /*#__PURE__*/Object.freeze({
    __proto__: null,
    create: create,
    drop: drop,
    grantAll: grantAll,
    createExtension: createExtension
});

const create$1 = async ({ user, password }, { client }) => {
    await client.query(`CREATE ROLE ${escapeId(user)} WITH LOGIN PASSWORD ${node_modules.pgEscape_4(password)}`);
};
const drop$1 = async ({ user }, { client }) => {
    await client.query(`DROP ROLE ${escapeId(user)}`);
};

var user = /*#__PURE__*/Object.freeze({
    __proto__: null,
    create: create$1,
    drop: drop$1
});

const commands = {
    db,
    user,
};
async function handler(event) {
    console.log("Connecting to the database...");
    const client = new node_modules.client({ connectionString: process.env.DATABASE_URL });
    await client.connect();
    try {
        for (const { path, options } of event.commands) {
            const command = node_modules.get_1(commands, path);
            if (!command) {
                throw new Error(`Unknown command ${path}`);
            }
            console.log(`Running ${path}...`);
            await command(options, { client });
        }
    }
    finally {
        console.log("Closing connection to the database");
        await client.end();
    }
}

exports.handler = handler;
