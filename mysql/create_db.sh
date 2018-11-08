if [ $# -ne 1 ]; then
    echo "Usage $0 <dbname>"
    exit -1
fi

DB_NAME=$1
DB_USER="sbmvt"
DB_PASS="hehehe"

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARSET utf8mb4;"
echo "CREATE USER $DB_USER IDENTIFIED by '$DB_PASS';"
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* to $DB_USER;"
echo "FLUSH PRIVILEGES;"
