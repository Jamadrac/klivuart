const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const schoolRouter = require("./routes/school");

const PORT = process.env.PORT || 8000;
const app = express();

app.use(express.json());
app.use(authRouter);
app.use(schoolRouter)

const DB =
  "mongodb+srv://rivaan:test123@cluster0.lcq2qaw.mongodb.net/?retryWrites=true&w=majority";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
