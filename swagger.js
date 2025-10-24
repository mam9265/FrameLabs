const swaggerAutogen = require('swagger-autogen')();

const doc = {
  info: {
    title: 'FrameLabs API',
    description: 'API documentation for FrameLabs — includes JWT authentication and role-based access control.',
    version: '1.0.0',
  },
  host: 'localhost:3000',
  basePath: '/',
  schemes: ['http'],
  components: {
    securitySchemes: {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
      },
    },
  },
  security: [
    {
      bearerAuth: [],
    },
  ],
  tags: [
    {
      name: 'Community',
      description: 'Community-created content (guides, trials, characters, etc.)',
    },
    {
      name: 'System',
      description: 'System-level content (playstyles, trials, tutorials, etc.)',
    },
    {
      name: 'User',
      description: 'User and account management routes',
    },
  ],
};

const outputFile = './swagger-output.json';
const endpointsFiles = ['./server.js'];

swaggerAutogen(outputFile, endpointsFiles, doc);