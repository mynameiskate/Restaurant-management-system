process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../../server');
const should = chai.should();
const helpers = require('../util/helpers.js');

chai.use(chaiHttp);

describe('Images', () => {
  describe('/GET images', () => {
    it('it should GET all images', (done) => {
      chai.request(server)
      .get('/api/images')
      .end((err, res) => {
        res.should.have.status(200);
        res.body.should.be.a('array');
        done();
      });
    });
  });
  describe('/GET:id images', () => {
    it('it should not GET an image by negative value', (done) => {
      chai.request(server)
      .get('/api/images/-1')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
});