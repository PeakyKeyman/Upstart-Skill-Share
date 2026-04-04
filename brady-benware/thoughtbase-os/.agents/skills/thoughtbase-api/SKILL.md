---
name: thoughtbase-api
description: Access the user's private Thoughtbase database. Use this skill to run natural-language search across meaning, keywords, and date metadata, then retrieve full transcripts. Trigger this when the user asks you to read, analyze, or process their thoughts from Thoughtbase.
---

# Thoughtbase API Agent Skill

This skill allows you to programmatically access the user's local Thoughtbase instance. Thoughtbase is an audio journaling application that supports hybrid local search across meaning, keywords, and date metadata.

When the user asks you to extract, analyze, or summarize "thoughts", use the bundled `cli.js` script to search the system and retrieve the raw transcripts.

## Using the CLI

This CLI interfaces seamlessly with Thoughtbase's internal REST API. It has been dynamically hardcoded during packaging to communicate directly with this specific instance: **https://thoughtbase.mouse-reedfish.ts.net**

### 1. Searching
To perform a search, run the `search` command. It takes a natural-language search query string as the first argument, and an optional integer as the second argument to limit the number of returned results (defaults to 25).

```bash
# Search for marketing ideas and return the top 2 results
node <path-to-thoughtbase-api-skill>/cli.js search "ideas for marketing campaigns" 2
```
It returns a JSON array of matching metadata objects (with `uuid`, `created_at`, `headline`, `summary`, `distance`). Use this list to figure out which specific thoughts are relevant to the user's prompt. *Do not attempt to read `transcript_text` from this output.*

#### Search styles

- **Direct topic search:** Use short phrases when you know the concept you want.
  - Examples: `"AI coaching"`, `"portfolio review"`, `"LinkedIn writing"`
- **Conversational search:** Use full natural-language prompts when you want date interpretation or more structured retrieval behavior.
  - Examples: `"What did I record about AI coaching last week?"`, `"Show me notes from March about agents"`

#### Tradeoff

- Short direct queries are usually faster.
- Conversational or date-heavy queries may take longer because Thoughtbase can first route the query into structured search terms before running the local database search.

### 2. Retrieving Transcripts
Once you have identified the `uuid`s of the thoughts you want to process, use the `retrieve` command. Pass the exact UUIDs as a single, comma-separated string argument.

```bash
node <path-to-thoughtbase-api-skill>/cli.js retrieve "uuid1,uuid2,uuid3"
```
This returns a full JSON array of the requested thoughts, including their raw `transcript_text`, cleanly ordered chronologically by creation date. 

**Note:** The `retrieve` command is explicitly designed to retrieve multiple files. Always batch your UUIDs together into a single command rather than running a loop of multiple CLI queries.

## Best Practices
- **Step 1:** Run `search` first to get a broad overview of the available thoughts via their metadata.
- **Step 1a:** Prefer short direct topic queries first when you only need concept matching.
- **Step 1b:** Use conversational queries when the user clearly needs date math, time windows, or more guided retrieval.
- **Step 2:** Decide which UUIDs are highly relevant based on their `summary` and timestamps.
- **Step 3:** Run `retrieve` with the concatenated list of UUIDs to extract the raw text bodies.
- **Step 4:** Process the payload to fulfill the user's prompt.
