process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../../server');
const should = chai.should();
const helpers = require('../util/helpers.js');

chai.use(chaiHttp);

describe('Categories', () => {
  describe('/GET categories', () => {
    it('it should GET all the categories', (done) => {
      chai.request(server)
      .get('/api/categories')
      .end((err, res) => {
        res.should.have.status(200);
        res.body.should.be.a('array');
        done();
      });
    });
  });
});