const http = require('http');

const PORT = 80;
const HOST = '0.0.0.0';

const requestHandler = async (request, response) => {
    const body = await getBody(request);

    const responseText = 'Hello: ' + body;

    response.statusCode = 200;
    response.setHeader('Content-Type', 'text/plain');
    response.setHeader('Content-Length', responseText.length);
    response.end(responseText);
};

// Create HTTPS server with the provided SSL credentials and request handler
const server = http.createServer(requestHandler);

server.listen(PORT, HOST, () => {
    console.log(`Server listening on http://${HOST}:${PORT}`);
});

function getBody(request) {
    return new Promise((resolve) => {
        const bodyParts = [];
        let body;
        request.on('data', (chunk) => {
            bodyParts.push(chunk);
        }).on('end', () => {
            body = Buffer.concat(bodyParts).toString();
            resolve(body)
        });
    });
}
