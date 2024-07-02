///imports from packages
const express = require("express");
const mongoose = require("mongoose");
const DB =
  "mongodb+srv://lakshit:7jJRWgPe1lipdkWh@cluster0.su5u0pa.mongodb.net/?retryWrites=true&w=majority";
//imports from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
//init
const PORT = 3000;
const app = express();
//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
// GET, PUT, POST, DELETE, UPDATE -> CRUD

//Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Succesful");
  })
  .catch((e) => {
    console.log(e);
  });
app.listen(PORT, "192.168.1.17", () => {
  console.log(`Connected at port ${PORT}`);
});
