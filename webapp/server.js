var connect = require('connect'),
    serveStatic = require('serve-static');

connect().use(serveStatic("./static")).listen(8080);
