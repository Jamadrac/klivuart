const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const schoolRouter = require("./routes/school");
const morgan = require("morgan")
const doubtRouter = require("./routes/doubts");

const os = require('os');

const PORT = process.env.PORT || 8000;
const app = express();
app.use(morgan('tiny'))
app.use(express.json());
app.use(authRouter);
app.use(schoolRouter);
app.use(doubtRouter);


const DB = "mongodb+srv://rivaan:test123@cluster0.lcq2qaw.mongodb.net/?retryWrites=true&w=majority";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  const networkInterfaces = os.networkInterfaces();
  let ipAddress = 'localhost';
  
  for (const interfaceName in networkInterfaces) {
    const interfaceInfo = networkInterfaces[interfaceName];
    for (const address of interfaceInfo) {
      if (address.family === 'IPv4' && !address.internal) {
        ipAddress = address.address;
        break;
      }
    }
  }

  const url = `http://${ipAddress}:${PORT}`;
  console.log(`Server is running at ${url}`);
});
