/** Production / Docker: nginx proxies /api → Spring Boot (same origin). */
export const environment = {
  production: true,
  apiUrl: '/api',
  keycloak: {
    url: 'http://localhost:8080',
    realm: 'cis',
    clientId: 'civic-frontend'
  },
  giphyApiKey: ''
};
