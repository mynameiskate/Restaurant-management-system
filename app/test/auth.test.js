process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../../server');
const should = chai.should();
const expect = chai.expect;
const helpers = require('../util/helpers.js').default;

const DbPool = require('../db/db.pool');
const connectionString = require('../configs/database.config');
const pool = new DbPool(connectionString);

const getUsers = (callback) => {
  pool.executeQuery('exec getUsers', callback); 
}

describe('Auth', () => {
  describe('GET/ users', () => {
    it('it should not GET credentials', (done) => {
      chai.request(server)
      .get('/api/users')
      .end((err, res) => {
        res.should.have.status(404);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if no email and password are provided', (done) => {
      chai.request(server)
      .post('/api/auth')
      .send({})
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if email is empty', (done) => {
      const auth = {
        email: null,
        password: '111111'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if password is empty', (done) => {
      const auth = {
        email: '1@1'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if email consists only of whitespace characters', (done) => {
      const auth = {
        email: '      ',
        password: '111111'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if password consists only of whitespace characters', (done) => {
      const auth = {
        email: '1@1',
        password: '      '
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if password is less than 6 characters long', (done) => {
      const auth = {
        email: '1@1',
        password: '123'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if password is more than 30 characters long', (done) => {
      const auth = {
        email: '1@1',
        password: '123456789101234567891012345678910'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if email is less than 3 characters long', (done) => {
      const auth = {
        email: '1@',
        password: '123456'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('POST/: authorize', () => {
    it('it should not POST if email is invalid', (done) => {
      const auth = {
        email: 'test',
        password: '123456'
      };
      chai.request(server)
        .post('/api/auth')
        .send(auth)
        .end((err, res) => {
          res.should.have.status(400);
          done();
        });
    });
  });
  describe('POST/: authorize', () => {
    it('it should authorize if email & password are valid', (done) => {
      getUsers((result) => {
        if (result && result.recordset && result.recordset.length) {
          const user = result.recordset.pop();
          chai.request(server)
          .post('/api/auth')
          .send({
            email: user.Email,
            password: user.Password
          })
          .end((err, res) => {
            res.should.have.status(200);
            done();
          });
        } else {
          done();
        }
      })
    });
  });
  describe('POST/: authorize', () => {
    it('it should not authorize if password is invalid', (done) => {
      getUsers((result) => {
        if (result && result.recordset && result.recordset.length) {
          const user = result.recordset.pop();
          chai.request(server)
          .post('/api/auth')
          .send({
            email: user.Email,
            password: `${user.Password}111`
          })
          .end((err, res) => {
            res.should.have.status(401);
            done();
          });
        } else {
          done();
        }
      })
    });
  });
  describe('POST/: authorize', () => {
    it('it should POST if email is not in list', (done) => {
      const auth = {
        email: 'test@test',
        password: '123456'
      };
      chai.request(server)
      .post('/api/auth')
      .send(auth)
      .end((err, res) => {
        res.should.have.status(401);
        done();
      });
    });
  });
});