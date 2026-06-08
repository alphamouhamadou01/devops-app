const request = require('supertest');
const app = require('./index');

describe('Tests de lAPI', () => {
  it('GET / doit retourner pong', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toBe('pong');
  });

  it('GET /health doit retourner status OK', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('OK');
  });
});
