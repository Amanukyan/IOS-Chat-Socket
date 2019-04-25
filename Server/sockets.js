const sockets = server => {
  // socket.io setup
  var io = require("socket.io").listen(server);

  io.sockets.on("connection", socket => {
    console.log("socket connected");

    socket.on("message", message => {
      console.log("message:", message);

      //Send message to user
      io.emit("message", message);

      //Save Message To DB
    });
  });
};

module.exports = sockets;
