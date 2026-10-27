function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  // El token se lee de la variable de entorno GOREST_TOKEN (nunca escrito en el código)
  var token = java.lang.System.getenv('GOREST_TOKEN');
  if (!token) {
    throw 'Falta la variable de entorno GOREST_TOKEN';
  }
  var config = {
    env: env,
    baseUrl:'https://gorest.co.in/public/v2',
    authHeader: 'Bearer ' + token
  }

  config.randomEmail = function() {
    return 'test' + Math.floor(Math.random() * 1000000) + '@gmail.com';
  };
  config.randomTitle = function() {
    var titles = ['Mi primer post', 'Notas rápidas', 'Reflexiones del día', 'Post de prueba'];
    return titles[Math.floor(Math.random() * titles.length)] + ' ' + java.lang.System.currentTimeMillis();
  };

  config.randomBody = function() {
    return 'Contenido de prueba generado por Karate - ' + java.util.UUID.randomUUID();
  };
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}