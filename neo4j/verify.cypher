MATCH (n) RETURN labels(n)[0] AS type, count(*) AS antal ORDER BY antal DESC;
MATCH (t:Track) WHERE t.embedding IS NULL RETURN count(t);
SHOW VECTOR INDEXES YIELD name, state, populationPercent;
MATCH ()-[r:SIMILAR_TO]->() RETURN count(r), min(r.score), max(r.score);
MATCH (t:Track)-[:SIMILAR_TO]-() RETURN count(DISTINCT t) AS sange_med_naboer;
MATCH (a:Artist)<-[:PERFORMED_BY]-(t:Track) RETURN a.name, count(t) AS tracks ORDER BY tracks DESC LIMIT 5;
