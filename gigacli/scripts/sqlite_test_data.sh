#!/bin/bash

DB_FILE="test_db.sqlite"

sqlite3 $DB_FILE <<'EOF'
CREATE TABLE IF NOT EXISTS test_data (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER
);
EOF

generate_random_name() {
    local names=(
        "Alice" "Bob" "Charlie" "David" "Eve" "Frank"
        "Grace" "Hannah" "Ivan" "Julia" "Kevin" "Liam"
        "Mia" "Noah" "Olivia" "Peter" "Quinn" "Rachel"
        "Sam" "Tina" "Uma" "Victor" "Wendy" "Xander"
        "Yara" "Zach"
    )
    echo "${names[$RANDOM % ${#names[@]}]}"
}

for i in $(seq 1 50); do
    NAME=$(generate_random_name)
    AGE=$((RANDOM % 60 + 18))
    sqlite3 $DB_FILE "INSERT INTO test_data (name, age) VALUES ('$NAME', $AGE);"
done

echo "50 random records inserted into $DB_FILE"
