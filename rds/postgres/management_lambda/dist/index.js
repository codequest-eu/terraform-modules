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

async function handler({ database, queries }) {
    const clientConfig = node_modules.pgConnectionString.parse(process.env.DATABASE_URL);
    if (database) {
        clientConfig.database = database;
    }
    console.log(`Connecting to the '${clientConfig.database}' database...`);
    const client = new node_modules.client(clientConfig);
    await client.connect();
    try {
        for (const query of queries) {
            console.log("Running query: ", query);
            await client.query(query);
        }
    }
    finally {
        console.log(`Closing connection to the '${clientConfig.database}' database`);
        await client.end();
    }
}

exports.handler = handler;
