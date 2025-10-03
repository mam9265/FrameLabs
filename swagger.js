const swaggerAutogen = require('swagger-autogen')();

const doc = {
info: {
title: 'API Documentation',
description: 'Automatically generated API documentation',
version: '1.0.0',
},
host: 'localhost:3000',
basePath: '/',
schemes: ['http'],
};

const outputFile = './swagger-output.json';
const endpointsFiles = ['./server.js'];

swaggerAutogen(outputFile, endpointsFiles, doc);