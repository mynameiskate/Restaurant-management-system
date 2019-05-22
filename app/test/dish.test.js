process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../../server');
const should = chai.should();
const expect = chai.expect;
const helpers = require('../util/helpers.js');

chai.use(chaiHttp);

describe('Dishes', () => {
  describe('/GET dishes', () => {
    it('it should GET all the dishes', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        res.body.should.be.a('array');
        done();
      });
    });
  });
  describe('/GET:id dishes', () => {
    it('it should not GET the dish by negative value', (done) => {
      chai.request(server)
      .get('/api/dishes/-1')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/GET:id dishes', () => {
    it('it should not GET the dish by string value', (done) => {
      chai.request(server)
      .get('/api/dishes/1test')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/GET:id dishes', () => {
    it('it should not GET the dish by non-integer value', (done) => {
      chai.request(server)
      .get('/api/dishes/1.5')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/GET:id dishes', () => {
    it('it should not GET the dish by null value', (done) => {
      chai.request(server)
      .get('/api/dishes/null')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/GET:id dishes', () => {
    it('it should GET the dish by existing id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          chai.request(server)
          .get(`/api/dishes/${dishes[0].id}`)
          .end((err, res) => {
            res.should.have.status(200);
            res.body.should.have.property('id').eql(dishes[0].id);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/GET:id dishes', () => {
    it('it should not GET the dish by non-existing id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = helpers
            .randomValueNotInArray(dishes.map(dish => dish.id));
          chai.request(server)
          .get(`/api/dishes/${id}`)
          .end((err, res) => {
            res.should.have.status(404);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT the dish by non-existing id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = helpers
            .randomValueNotInArray(dishes.map(dish => dish.id));
          const dish = {
            name: 'test dish',
            description: 'test description',
            cost: 200,
            weight: 400,
            nutritionalValue: 300,
            category: { id: 2},
            isAvailable: 0
          };
          chai.request(server)
          .put(`/api/dishes/${id}`)
          .send(dish)
          .end((err, res) => {
            chai.request(server)
            .get('/api/dishes')
            .end((err, res) => {
              expect(res.body.find(dish => dish.id == id)).to.not.exist;
              done();
            });
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT an empty dish', (done) => {
      const dish = {};
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without name', (done) => {
      const dish = {
        description: 'test description',
        cost: 200,
        weight: 400
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without weight', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without cost', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without category', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should PUT a dish with a name, cost, weight, category', (done) => {
      const dish = {
        name: 'test put dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0
      };
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .put(`/api/dishes/${id}`)
          .send(dish)
          .end((err, res) => {
            res.should.have.status(200);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish by a negative id', (done) => {
      const dish = {
        name: 'test put dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0
      };
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .put(`/api/dishes/-${id}`)
          .send(dish)
          .end((err, res) => {
            res.should.have.status(200);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a non-float weight', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        weight: 'test string'
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a non-float cost', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        cost: 'test string'
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a negative weight', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        weight: -10
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a negative category ID', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: -2},
        isAvailable: 0,
        weight: 10
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a negative cost', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        cost: -5
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a string category id', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0,
        category: {
          id: 'test string'
        }
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a non-integer category id', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0,
        category: {
          id: 12.5
        }
      };
      chai.request(server)
      .put(`/api/dishes/${0}`)
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a non-existing category.', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        if (!res.body || !res.body.length) {
          done();
          return;
        }
        const dish = res.body.pop();
        chai.request(server)
        .get('/api/categories')
        .end((err, res) => {
          res.should.have.status(200);
          const categories = res.body;

          if (categories.length > 0) {
            dish.category = { 
              id: helpers
                .randomValueNotInArray(categories.map(category => 
                  category.id
                ))
            };
            dish.name = 'no category'
            chai.request(server)
            .put(`/api/dishes/${dish.id}`)
            .send(dish)
            .end((err, res) => {
              res.should.have.status(400);
              done();
            });
          } else {
            done();
          }
        });
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST an empty dish', (done) => {
      const dish = {};
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish without name', (done) => {
      const dish = {
        description: 'test description',
        cost: 200,
        weight: 400
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish without weight', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish without cost', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish without category', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should POST a dish with a name, cost, weight, category', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2 },
        isAvailable: 0
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(200);
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a non-float weight', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        weight: 'test string'
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a non-float cost', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        cost: 'test string'
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a string category id', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0,
        category: {
          id: 'test string'
        }
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a negative weight', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        weight: -10
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a negative cost', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        weight: 400,
        nutritionalValue: 300,
        category: { id: 2},
        isAvailable: 0,
        cost: -10
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a negative category id', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0,
        category: {
          id: -10
        }
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a non-integer category id', (done) => {
      const dish = {
        name: 'test dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0,
        category: {
          id: 12.5
        }
      };
      chai.request(server)
      .post('/api/dishes')
      .send(dish)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish with a non-existing category.', (done) => {
      const dish = {
        name: 'test put dish',
        description: 'test description',
        cost: 200,
        weight: 400,
        nutritionalValue: 300,
        isAvailable: 0,
      };
      chai.request(server)
      .get('/api/categories')
      .end((err, res) => {
        res.should.have.status(200);
        const categories = res.body;

        if (categories.length > 0) {
          dish.category = { 
            id: helpers
              .randomValueNotInArray(categories.map(category => 
                category.id
              ))
          };
          chai.request(server)
          .post(`/api/dishes`)
          .send(dish)
          .end((err, res) => {
            res.should.have.status(400);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/DELETE:id dish', () => {
    it('it should not DELETE the dish by non-existing id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = helpers
            .randomValueNotInArray(dishes.map(dish => dish.id));
          chai.request(server)
          .delete(`/api/dishes/${id}`)
          .end((err, res) => {
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/DELETE dish', () => {
    it('it should DELETE the dish by existing id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .delete(`/api/dishes/${id}`)
          .end((err, res) => {
            res.should.have.status(200);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/DELETE dish', () => {
    it('it should not DELETE the dish by negative id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .delete(`/api/dishes/-${id}`)
          .end((err, res) => {
            res.should.have.status(400);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/DELETE dish', () => {
    it('it should not DELETE the dish by non-integer id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .delete(`/api/dishes/${id}.5`)
          .end((err, res) => {
            res.should.have.status(400);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/DELETE dish', () => {
    it('it should not DELETE the dish by string id', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .delete(`/api/dishes/${id}.test`)
          .end((err, res) => {
            res.should.have.status(400);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/DELETE dish', () => {
    it('it should not DELETE the dish by null value', (done) => {
      chai.request(server)
      .get('/api/dishes')
      .end((err, res) => {
        res.should.have.status(200);
        const dishes = res.body;

        if (dishes.length > 0) {
          const id = dishes.pop().id;
          chai.request(server)
          .delete(`/api/dishes/null`)
          .end((err, res) => {
            res.should.have.status(400);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
});