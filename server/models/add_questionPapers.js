const mongoose = require("mongoose");

const add_questionPapersSchema = mongoose.Schema({
  subject: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  image: {
    type: String, // Base64 encoded image or URL
  },
});

const add_questionPapers = mongoose.model("add_questionPapers", add_questionPapersSchema);
module.exports = add_questionPapers;
