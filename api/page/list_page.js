const supertest = require('supertest');
const env = require('dotenv').config();

const api = supertest(process.env.Base_URL);

const getVehicleList = api.get('')
 .set('Content-Type', 'application/json')
 .set('Accept', 'application/json')

module.exports = {
   getVehicleList,
}