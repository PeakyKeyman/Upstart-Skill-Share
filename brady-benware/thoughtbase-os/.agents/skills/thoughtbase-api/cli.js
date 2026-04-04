#!/usr/bin/env node
// Dynamically injected remote Thoughtbase API Base URL
const API_URL = 'https://thoughtbase.mouse-reedfish.ts.net';

async function request(endpoint, payload = null) {
  const { request: sendRequest } = API_URL.startsWith('https')
    ? await import('node:https')
    : await import('node:http');

  return new Promise((resolve, reject) => {
    const url = new URL(API_URL + '/api/' + endpoint);
    const options = {
      method: payload ? 'POST' : 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    };

    const req = sendRequest(url, options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const json = JSON.parse(data);
          resolve(json);
        } catch {
          reject(new Error("Failed to parse JSON response: " + data));
        }
      });
    });

    req.on('error', reject);
    
    if (payload) {
      req.write(JSON.stringify(payload));
    }
    
    req.end();
  });
}

async function main() {
  const args = process.argv.slice(2);
  const command = args[0];

  if (command === 'search') {
    const query = args[1] || '';
    const limit = args[2] ? parseInt(args[2], 10) : undefined;
    
    try {
      const res = await request('search', { query, limit });
      if (res.success) {
        // Obfuscate local OS paths from agent visibility, only expose metadata
        const output = (res.results || []).map(r => ({
          uuid: r.uuid,
          created_at: r.created_at,
          headline: r.headline,
          summary: r.summary,
          distance: r.distance
        }));
        console.log(JSON.stringify(output, null, 2));
      } else {
        console.error('Search failed:', res.error);
        process.exit(1);
      }
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  } else if (command === 'retrieve') {
    const uuidsArg = args[1];
    if (!uuidsArg) {
      console.error('Must provide comma-separated UUIDs');
      process.exit(1);
    }
    
    const uuids = uuidsArg.split(',').map(s => s.trim()).filter(Boolean);
    try {
      const res = await request('thoughts/retrieve', { uuids });
      if (res.success) {
        // Strip backend absolute paths explicitly
        const mapped = res.results.map(r => {
           return {
             uuid: r.uuid,
             created_at: r.created_at,
             headline: r.headline,
             summary: r.summary,
             transcript_text: r.transcript_text
           }
        })
        console.log(JSON.stringify(mapped, null, 2));
      } else {
        console.error('Retrieve failed:', res.error);
        process.exit(1);
      }
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  } else {
    console.log(`
Thoughtbase CLI API Wrapper
Target Server: ${API_URL}

Usage:
  node <path-to-thoughtbase-api-skill>/cli.js search "<your semantic query>" [limit]
  node <path-to-thoughtbase-api-skill>/cli.js retrieve "uuid1,uuid2,uuid3"
    `);
  }
}

main();
