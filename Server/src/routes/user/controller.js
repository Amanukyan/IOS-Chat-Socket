const User = require("../../models/user");

/* 
    GET /api/user/list
*/

exports.list = (req, res) => {
  User.find({}, "-password")
    .exec()
    .then(users => {
      res.json(users);
    });
};
