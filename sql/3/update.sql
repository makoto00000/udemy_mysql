# UPDATE文
UPDATE people SET birth_day="1900-01-01", name="";

SELECT * FROM people;

# UPDATE where 
UPDATE people SET name="Taro", birth_day="2000-01-01" WHERE id=3;

UPDATE people SET name="Jiro", birth_day="2000-01-01" WHERE id>4;
