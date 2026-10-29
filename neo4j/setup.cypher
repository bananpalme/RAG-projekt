// Køres af "Create schema"-noden i ingestion-workflowet (eller manuelt i Neo4j Browser).
CREATE CONSTRAINT track_id    IF NOT EXISTS FOR (t:Track)    REQUIRE t.track_id IS UNIQUE;
CREATE CONSTRAINT album_id    IF NOT EXISTS FOR (a:Album)    REQUIRE a.album_id IS UNIQUE;
CREATE CONSTRAINT artist_name IF NOT EXISTS FOR (a:Artist)   REQUIRE a.name IS UNIQUE;
CREATE CONSTRAINT genre_name  IF NOT EXISTS FOR (g:Genre)    REQUIRE g.name IS UNIQUE;
CREATE CONSTRAINT subgenre_id IF NOT EXISTS FOR (s:Subgenre) REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT year_value  IF NOT EXISTS FOR (y:Year)     REQUIRE y.value IS UNIQUE;

CREATE VECTOR INDEX track_vibe_index IF NOT EXISTS
FOR (t:Track) ON (t.embedding)
OPTIONS {indexConfig: {`vector.dimensions`: 1536, `vector.similarity_function`: 'cosine'}};

// Valgfri oprydning før ny import (udføres af "Wipe database"-noden):
// MATCH (n) DETACH DELETE n;
