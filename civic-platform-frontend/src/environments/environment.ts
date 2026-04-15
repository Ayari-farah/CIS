export const environment = {
  production: false,
  /** Local `mvn spring-boot:run` default (see application.yml). Docker stack uses nginx /api on :4200. */
  apiUrl: 'http://localhost:8082/api',
  /** Optional: https://developers.giphy.com/dashboard/ — enables GIF search in post/comment composer */
  giphyApiKey: ''
};
