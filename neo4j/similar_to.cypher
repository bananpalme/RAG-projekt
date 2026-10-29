// Køres EFTER importen. Opretter (:Track)-[:SIMILAR_TO {score}]->(:Track) fra vektorindekset.
// I Neo4j Browser (delt i transaktioner, undgår timeout):
:auto
MATCH (t:Track)
CALL (t) {
  CALL db.index.vector.queryNodes('track_vibe_index', 6, t.embedding)
  YIELD node, score
  WHERE node <> t AND score >= 0.85
  MERGE (t)-[r:SIMILAR_TO]->(node)
  SET r.score = score
} IN TRANSACTIONS OF 200 ROWS;
