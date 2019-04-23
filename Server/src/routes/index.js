const router = require("express").Router();
const authMiddleware = require("../middlewares/auth");
const user = require("./user");
const auth = require("./auth");

const helloWorld = (req, res) => {
  res.json({
    message: "Hello World!"
  });
};

router.get("/", helloWorld);
router.use("/user", authMiddleware, user);

router.use("/auth", auth);

module.exports = router;
