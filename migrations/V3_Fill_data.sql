INSERT INTO source (name)
SELECT random_string(40)
from generate_series(1, 1000)