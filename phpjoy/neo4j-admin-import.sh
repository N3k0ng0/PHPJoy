#!/bin/bash

# Stop any running Neo4j instance in the target folder
../"$1"/bin/neo4j stop

# Remove existing database folder if it exists
rm -rf ../neo4j/"$1"

# Copy your installed Neo4j into a new folder for this import
cp -r ../neo4j ../"$1"

# Import the E-CPG CSVs into Neo4j
../"$1"/bin/neo4j-admin import --database=neo4j \
  --nodes=nodes.csv \
  --relationships=rels.csv \
  --relationships=cpg_edges.csv \
  --trim-strings=true \
  --skip-duplicate-nodes=true \
  --skip-bad-relationships=true \
  --multiline-fields=true \
  --id-type=INTEGER \
  --force=true

# Configure Neo4j ports and allow remote connections
# $2 = Bolt port, $3 = HTTP port
sed -i "s/#dbms.connector.bolt.listen_address=:7687/dbms.connector.bolt.listen_address=:$2/g" ../"$1"/conf/neo4j.conf
sed -i "s/#dbms.connector.http.listen_address=:7474/dbms.connector.http.listen_address=:$3/g" ../"$1"/conf/neo4j.conf
sed -i "s/#dbms.default_listen_address=0.0.0.0/dbms.default_listen_address=0.0.0.0/g" ../"$1"/conf/neo4j.conf

# Enable authentication (or disable if you prefer)
sed -i "s/#dbms.security.auth_enabled=false/dbms.security.auth_enabled=false/g" ../"$1"/conf/neo4j.conf
