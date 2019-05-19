process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../../server');
const should = chai.should();
const expect = chai.expect;
const helpers = require('../util/helpers.js');

describe('Orders', () => {
  describe('/PUT order: assign cook to dish', () => {
    it('it should not PUT if cookId is empty', (done) => {
      chai.request(server)
      .put('/api/orders?dishId=1&orderId=1')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if orderId is empty', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&dishId=1')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if dishId is empty', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&orderId=1')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if cookId is string', (done) => {
      chai.request(server)
      .put('/api/orders?orderId=1&dishId=1&cookId=cook')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if orderId is string', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&dishId=1&orderId=order')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if dishId is string', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&orderId=1&dishId=dish')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if cookId is non-integer', (done) => {
      chai.request(server)
      .put('/api/orders?orderId=1&dishId=1&cookId=-13.2')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if orderId is non-integer', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&dishId=1&orderId=0.6')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if dishId is non-integer', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&orderId=1&dishId=15.2')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if cookId is negative', (done) => {
      chai.request(server)
      .put('/api/orders?orderId=1&dishId=1&cookId=-13')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if dishId is negative', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&orderId=1&dishId=-2')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/PUT order: assign cook to order', () => {
    it('it should not PUT if orderId is negative', (done) => {
      chai.request(server)
      .put('/api/orders?cookId=1&dishId=1&orderId=-5')
      .end((err, res) => {
        res.should.have.status(400);
        done();
      });
    });
  });
  describe('/GET orders', () => {
    it('it should GET all the orders', (done) => {
      chai.request(server)
      .get('/api/orders')
      .end((err, res) => {
        res.should.have.status(200);
        res.body.should.be.a('array');
        done();
      });
    });
  });
  describe('/GET:id orders', () => {
    it('it should GET the order by existing id', (done) => {
      chai.request(server)
      .get('/api/orders')
      .end((err, res) => {
        res.should.have.status(200);
        const orders = res.body;

        if (orders.length > 0) {
          chai.request(server)
          .get(`/api/orders/${orders[0].id}`)
          .end((err, res) => {
            res.should.have.status(200);
            res.body.should.have.property('id').eql(orders[0].id);
            done();
          });
        } else {
          done();
        }
      });
    });
  });
  describe('/GET:id orders', () => {
    it('it should not GET the order by non-existing id', (done) => {
      chai.request(server)
      .get('/api/orders')
      .end((err, res) => {
        res.should.have.status(200);
        const orders = res.body;

        if (orders.length > 0) {
          const id = helpers
            .randomValueNotInArray(orders.map(order => order.id));
          chai.request(server)
          .get(`/api/orders/${id}`)
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
  describe('/POST dish', () => {
    it('it should not POST a dish without table number', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [],
        created: new Date()
      };
      chai.request(server)
      .post('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST a dish without name of the quest', (done) => {
      const order = {
        dishes: [],
        tableNum: 10,
        created: new Date()
      };
      chai.request(server)
      .post('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST order', () => {
    it('it should not POST an order without dishes', (done) => {
      const order = {
        guestName: 'Kate',
        tableNum: 10,
        created: new Date()
      };
      chai.request(server)
      .post('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST dish', () => {
    it('it should not POST an order with empty dish array', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [],
        tableNum: 10,
        created: new Date()
      };
      chai.request(server)
      .post('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/POST order', () => {
    it('it should POST an empty order', (done) => {
      chai.request(server)
      .post('/api/orders')
      .send({})
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without table number', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [],
        waiterId: 0,
        statusId: 0
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without name of the quest', (done) => {
      const order = {
        dishes: [],
        tableNum: 10,
        waiterId: 0,
        statusId: 0
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT order', () => {
    it('it should not PUT an order without dishes', (done) => {
      const order = {
        guestName: 'Kate',
        tableNum: 10,
        waiterId: 0,
        statusId: 0
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with empty dish array', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [],
        tableNum: 10,
        waiterId: 0,
        statusId: 0
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT order', () => {
    it('it should PUT an empty order', (done) => {
      chai.request(server)
      .put('/api/orders')
      .send({})
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without ID of the waiter', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [1, 2, 4],
        tableNum: 10,
        statusId: 0
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish without ID of the order status', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [1, 2, 4],
        tableNum: 10,
        waiterId: 0
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a negative table number', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [1, 2, 4],
        tableNum: -10,
        statusId: 0,
        waiterId: 5
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a negative ID of the waiter', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [1, 2, 4],
        tableNum: 10,
        statusId: 0,
        waiterId: -5
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
  describe('/PUT dish', () => {
    it('it should not PUT a dish with a negative order status', (done) => {
      const order = {
        guestName: 'Kate',
        dishes: [1, 2, 4],
        tableNum: 10,
        waiterId: 0,
        statusId: -5
      };
      chai.request(server)
      .put('/api/orders')
      .send(order)
      .end((err, res) => {
        res.should.have.status(400);
        res.body.should.be.a('object');
        res.body.should.have.property('error');
        done();
      });
    });
  });
});