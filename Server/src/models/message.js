const mongoose = require("mongoose");

const Schema = mongoose.Schema;
const ObjectId = mongoose.Schema.Types.ObjectId;

const messageSchema = new Schema({
  text: { type: String, default: "" },
  timeStamp: { type: Date, default: Date.now },
  userId: { type: ObjectId, ref: "User" },
  channelId: { type: ObjectId, ref: "Channel" },
  username: { type: String, default: "" }
});

module.exports = mongoose.model("Message", messageSchema);
