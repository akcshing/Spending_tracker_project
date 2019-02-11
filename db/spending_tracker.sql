DROP TABLE IF EXISTS transactions;
-- DROP TABLE IF EXISTS budget_relations;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS budgets;

CREATE TABLE budgets (
  id SERIAL4 PRIMARY KEY,
  amount DECIMAL(5,2),
  time_frame VARCHAR(255) -- day / week / month
);

CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);
--
-- CREATE TABLE budget_relations(
--   id SERIAL4 PRIMARY KEY,
--   budget_id INT4 REFERENCES budgets(id),
--   tag_id INT4 REFERENCES tags(id)
-- );

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  amount DECIMAL(5,2), -- 5 bytes, 2 decimal places
  merchant_id INT4 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT4 REFERENCES tags(id) ON DELETE CASCADE,
  time_stamp TIMESTAMP DEFAULT NOW()
);
