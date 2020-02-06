const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

pool.connect()

pool.query('SELECT $1::text as message', ['Hello world!']), (err, res) => {
  console.log(err ? err.stack : res.row[0].message)
  pool.end()
}

pool.query(`
SELECT *
FROM students
LIMIT 5;
`)
.then(res => {
  res.rows.forEach(user => {
    // console.log(`${user.name} has an id of ${user.id} and was in the ${user.cohort_id} cohort`);
    console.log(user);
  })
});