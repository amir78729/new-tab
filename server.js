const http = require("http");
const fs = require("fs");
const path = require("path");

const PORT = 1378;

const server = http.createServer((req, res) => {
  if (req.method === "GET" && req.url === "/") {
    const filePath = path.join(__dirname, "index.html");

    fs.readFile(filePath, "utf8", (err, data) => {
      if (err) {
        res.statusCode = 500;
        res.setHeader("Content-Type", "text/plain");
        res.end("Error loading HTML file.");
        console.error(err);
      } else {
        res.statusCode = 200;
        res.setHeader("Content-Type", "text/html");
        res.end(data);
      }
    });
  } else {
    res.statusCode = 404;
    res.setHeader("Content-Type", "text/plain");
    res.end("Not Found");
  }
});

server.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
