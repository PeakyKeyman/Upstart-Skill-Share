# Product Requirements Document: Personal Thought Database

## Scope
`docs/prd.md` owns product intent and user-facing requirements. It should describe what the system must do for the user, not the low-level implementation or operator workflow details unless they materially define the product contract.

## 1. Project Overview & Intent

The objective of this project is to build a frictionless, single-user "Thought Database." The core intent is to allow the user to capture thoughts, ideas, and audio dumps instantly throughout the day and easily retrieve them later using natural language search.

Because the user needs to access this tool seamlessly across multiple personal devices (smartphones, laptops, desktops) without the overhead of installing native applications, it must be a mobile-first web application. Furthermore, because this is strictly for personal use, the system must completely avoid the bloat, maintenance, and complexity of multi-tenant architecture, user authentication, and public internet exposure. The application will live entirely within a secure, private network context.

The product may also include an adjacent utilities library for general-purpose content tools that support the broader personal workflow without being mistaken for the core thought capture, storage, and retrieval surface.

---

## 2. Core Requirements

### User Interface & Experience

* **Platform:** Responsive web application (Mobile-first with dedicated Desktop layout adaptations), accessible via standard web browsers (e.g., Chrome, Safari).
* **Cross-Device Access:** Must be accessible from any of the user's personal devices without a login screen, dynamically adapting UI layouts to utilize desktop screen real estate optimally.
* **Utilities Library:** The app may expose a dedicated utilities area for adjacent single-user tools. That area should remain clearly secondary to the main Thoughtbase capture and retrieval workflows and should give each utility its own route rather than folding unrelated tools into the primary capture UI.
* **Markdown Export Utility:** The first utility in that library must allow the user to provide markdown by drag-and-drop file intake, direct file selection, or pasted markdown text, preview the rendered markdown, and download it as markdown, PDF, or a standalone self-contained HTML file that works offline and is optimized for comfortable mobile reading with a paper-like presentation.
* **Primary Input:** Voice recording interface featuring standard controls. To prevent accidental submissions, users must **Pause** the recording first, which then reveals a gate to either **Resume**, **Cancel**, or **Finish** the thought.
* **Recording Behavior:** Recording must be completely manual. The app must *not* auto-stop based on silence detection. Short audio clips must *not* be discarded unless explicitly canceled by the user; all finalized audio is retained.
* **Thought Growth Model:** A single user-visible thought may accumulate over time. After a thought is created, the user must be able to append additional **brain dumps** to that same thought using the same capture modalities: voice recording, text entry, or audio file upload.


* **Secondary Input:** 
  * Text-based entry and search must be available as a fallback.
  * **Audio File Input**: Users must be able to securely upload existing audio files from their devices (MP3, M4A, WAV, etc.) to be transcoded and processed.
  * Planned but not yet exposed in the primary capture UI: a **URL Scrape** feature to automatically extract and parse external web articles.
* **Theme:** The visual theme is exclusively **"Dark OLED Luxury"**, designed strictly according to the `frontend-design-pro` skill rules and implemented via `shadcn-ui`. Extended Desktop layout rules are governed by the `_responsive-desktop-design` skill.
* **Results View:** A responsive interface displaying a timestamp, an AI-generated headline, and a short summary for each entry. It scales from a single-column list on mobile to a multi-column desktop grid. It also includes a multi-select mode activated via long-press, allowing bulk deletion or bulk copying of full transcripts directly to the clipboard.
* **Pagination:** Results must use a lazy-loading approach, displaying 25 results at a time, with a "Load More" trigger (scroll or button) for older entries.
* **Cross-Device Transcript Sync:** When a transcript is finalized while Thoughtbase is open on another device, the app should attempt to copy that transcript to the clipboard on connected clients and fall back to an explicit in-app copy prompt when clipboard permissions block the write.


* **Detail View:** Tapping a result navigates to a dedicated page (or an intercepted Modal overlay) that must show the full transcription alongside the AI-generated Coherent Document. Users can seamlessly toggle between these views without layout shifts. It provides playback of the original audio, easy "Copy" buttons and download actions for both the raw transcript and the coherent document in markdown, PDF, and standalone self-contained offline HTML, and the ability to **Regenerate** the Coherent Document if they desire a new LLM pass. This prevents state-loss on the main feed while still providing a definitive URL.
* **Pending Detail State:** If a thought is opened while its initial creation or a newly appended brain dump is still processing, the detail view must clearly frame that pending state while preserving access to any already-finalized transcript and coherent content.
* **Failed Async Recovery State:** If async processing fails, the user must see a single clear recovery state instead of contradictory pending/success labels. Failed new thoughts should offer retry or replacement capture actions. Failed append updates should preserve the last completed aggregate thought while offering explicit retry or discard actions for the failed update.
* **Brain Dump Management:** Within a thought detail view, users must be able to inspect the chronological list of constituent brain dumps, add a new brain dump to the thought, and delete an individual brain dump without deleting the entire thought.
* **Aggregate Transcript Rule:** The raw transcript shown for a thought is the concatenated chronological transcript of all brain dumps currently attached to that thought.
* **Raw Transcript Presentation Rule:** The raw thought view must present a single chronological stack of brain-dump cards rather than a split layout that separately shows both the combined transcript and the dump list. Each card should show modality, timestamp, optional audio playback, and an expandable/collapsible transcript preview. The raw copy action should export markdown ordered chronologically, where each dump includes lightweight metadata (timestamp and capture source) followed by its transcript, with clear separators between captures.
* **Aggregate Coherent Document Rule:** The coherent markdown document, headline, and summary for a thought must always represent the complete combined set of brain dumps rather than any individual dump.

### Data Capture & Reliability

* **Zero Data Loss:** Audio capture must be extremely resilient. If the user minimizes the browser or the mobile OS suspends the app mid-recording, the recorded audio up to that point must not be lost.
* **Aggressive Foregrounding:** During an active recording session, the interface must actively request the `Screen Wake Lock API` to forcefully prevent the mobile OS from sleeping the screen and killing the microphone hardware. The lock must be automatically re-acquired on visibility change events.
* **Forced Termination Handling:** If the mobile OS or user forcefully kills the device screen/app during a recording, the application must natively hook the `track.onended` browser event. This must automatically halt the recorder, convert the session into a recoverable "Orphan" state stored in IndexedDB, and safely prompt the user to resume or discard it directly at the primary "Start Audio" call-to-action explicitly blocking new recordings until resolved.
* **Microphone Permissions:** The application must be served in a way that modern browsers (which require HTTPS/Secure Contexts) readily grant microphone access without throwing security warnings.

### Processing & Storage

* **Single-Tenant Storage:** Data must be saved on a designated local Linux machine.
* **File Management:** Files must be stored in a hidden directory named after the project within the Linux user's home directory (e.g., `~/.thought-db/`).
* **Async Submission Handoff:** Once the backend has durably received a newly submitted thought, the capture flow should be free to return the user to the main library without waiting for transcription, summarization, embedding, and finalization to finish inside the original request.
* **Pending Thought Visibility:** While a newly submitted thought is still processing, the main feed must show it as a placeholder thought card with visible processing status. That placeholder must survive refreshes and should appear on other open devices as well.
* **Async Append Handoff:** Appending a new brain dump to an existing thought must use the same durable async handoff and overall capture pattern as creating a new thought. The capture UI should clearly identify which thought is being extended, but once the append is safely queued the user should return to the main feed, where that thought appears as in-progress again until the aggregate transcript, coherent document, headline, summary, and search index are recomputed.
* **Concurrent Processing:** The user must be able to submit another new thought while one or more previous thoughts are still processing. Multiple in-flight placeholder thoughts may coexist in the feed.
* **File Naming Convention:** Persisted assets must keep chronologically sortable names, but the exact internal naming scheme is an engineering concern rather than a product contract.
* **Retention Policy:** Thoughtbase may persist normalized local assets instead of retaining the exact originally uploaded file, as long as the normalized asset preserves the user's content and the resulting thought remains fully usable.
* **Asset Grouping:** Each entry must save interrelated assets, organized and timestamped:
  * One or more chronological **brain dumps**, each with:
    * Optional normalized audio file optimized for efficient local storage and playback
    * Raw text transcription for that dump
  * One aggregate raw transcript for the parent thought
  * LLM-generated Coherent Markdown Document for the aggregate thought
  * Headline (extracted directly from the aggregate Coherent Document's H1)
  * Summary (extracted directly from the first 250 characters of the aggregate Coherent Document)


### Search & Retrieval

* **Natural Language Queries:** Users must be able to search using conversational prompts.
* **Search Submission:** Search executes on explicit submission (keyboard submit or search action), not on every keystroke.
* **Multi-Modal Filtering:** The search must support semantic (meaning), keyword, and metadata (date/time) filtering.
* **Local Processing:** The database powering the search must be open-source and run entirely locally on the Linux machine. External SaaS databases are strictly prohibited.
* **Agent API (thoughtbase-api):** External AI coding agents can interact programmatically with Thoughtbase by installing its dynamic skill (`thoughtbase-api`). This is hosted completely locally on the host server via `.well-known/skills/` endpoints. Agents install a custom Node CLI script to query the database and retrieve batch-processed full markdown transcripts, enabling seamless integration between the personal datalake and external AI.
