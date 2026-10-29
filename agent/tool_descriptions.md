# Værktøjsbeskrivelser

Begge værktøjer er n8n "Call n8n Workflow Tool"-noder, der kalder hvert sit subworkflow.

## 1. search_tracks_by_vibe  (workflows/02_vector_retrieval.json)

**Description (indsat i værktøjets Description-felt):**
Semantisk søgning efter sange ud fra stemning, vibe eller beskrivelse (fx "rolig aftenmusik", "energisk træningsmusik"). Brug det, når brugeren beskriver en følelse eller situation frem for en konkret kunstner eller genre. Input: `query` (påkrævet, kort beskrivelse på dansk), `limit` (valgfri), `genre` (valgfri), og valgfrie talfiltre mellem 0 og 1 for energy, danceability og valence. Sæt kun filtre, hvis brugeren beder om det, og udelad dem ellers. Returnerer sange med track_id, kunstner, genre, similarity og tre lignende sange fra grafen.

| Input | Type | Påkrævet | Betydning |
|---|---|---|---|
| query | tekst | ja | Stemning/vibe |
| limit | tal | nej | 1-10, standard 5 |
| genre | tekst | nej | Genrefilter |
| min_energy / max_energy | tal 0-1 | nej | Filter |
| min_danceability / max_danceability | tal 0-1 | nej | Filter |
| min_valence / max_valence | tal 0-1 | nej | Filter (glad/trist) |

**Output:** `source`, `query`, `filters_applied`, `count`, `results[]` (track_id, title, artist, genre, album, release_year, energy, danceability, valence, similarity, similar_via_graph) og `note`.

## 2. query_music_graph  (workflows/03_graph_retrieval.json)

**Description:**
Struktureret opslag i musikgrafen: kunstnere, genrer, albums, år og relationer mellem dem. Brug det til faktuelle spørgsmål ("hvilke sange har X", "hvilke genrer spiller Y", "hvem ligner Z"). Input: `operation` (én af: tracks_by_artist, genres_of_artist, artists_in_genre, subgenres_in_genre, top_tracks_in_genre, tracks_on_album, tracks_by_year, similar_tracks, related_artists, artists_sharing_genre), `name` (kunstner, genre, album, titel eller årstal alt efter operation) og `limit` (valgfri). Brug ikke værktøjet til at beskrive stemning.

| operation | name er | Svarer på |
|---|---|---|
| tracks_by_artist | kunstner | Hvilke sange har X lavet? |
| genres_of_artist | kunstner | Hvilke genrer spiller X? |
| artists_in_genre | genre | Hvilke kunstnere spiller genre Y? |
| subgenres_in_genre | genre | Hvilke undergenrer findes? |
| top_tracks_in_genre | genre | Mest populære sange i genre Y |
| tracks_on_album | albumnavn | Hvad er på albummet? |
| tracks_by_year | årstal | Sange fra et givet år |
| similar_tracks | sangtitel | Sange der ligner X (via SIMILAR_TO) |
| related_artists | kunstner | Kunstnere hvis sange ligner X's |
| artists_sharing_genre | kunstner | Kunstnere med samme genrer som X |

**Output:** `source` (inkl. operationsnavn), `operation`, `name`, `count`, `results[]` og `note`.
Cypher er skrevet på forhånd i workflowet for hver operation, så agenten aldrig skriver Cypher selv.

## Agentens modelkonfiguration
- Model: **[INDSÆT modelnavn fra OpenAI Chat Model-noden]**
- Temperature: **[INDSÆT, anbefalet 0.2-0.3]**
- Memory: **[Simple Memory ja/nej]**
- Systemprompt: se `system_prompt.txt`
- Skills: **[ingen / beskriv]**
