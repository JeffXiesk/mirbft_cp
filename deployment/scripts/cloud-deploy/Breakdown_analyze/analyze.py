import sqlite3

conn = sqlite3.connect('./eventDB.sqlite')

cursor = conn.cursor()

cursor.execute('SELECT * FROM request;')

rows = cursor.fetchall() 

for row in rows:
    print(row)

cursor.close()
conn.close()
