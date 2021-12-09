const assert = require('chai').expect;
const page = require('../page/list-page.js.js');

const testCase = {
 "positive" : {
    "getAllVehicleList" : "As a User, I want to be able to get all vehicles list",
    "getVehicleByFirstId" : "As a User, I want to be able to get vehicles list by first Id",
    "getVehicleBySecondId" : "As a User, I want to be able to get vehicles list by second Id",
    "getVehicleByThirdId" : "As a User, I want to be able to get vehicles list by third Id",
    "createNewData" : "As a User, I want to be able to create new data of vehicles"
 },
 "negative" : {
    "invalidId" : "As a User, I should got error 404 when I send request with invalid Id"
 }
}

describe(`Vehicles List`, () => {
 it(`@get ${testCase.positive.getVehicleList}`, async() => {
  const response = await page.getVehicleList();
  assert(response.status).to.equal(200);
 })
})