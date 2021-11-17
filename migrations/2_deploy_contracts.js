const Diamonds = artifacts.require("Diamonds");

module.exports = function (deployer) {
  deployer.deploy(Diamonds);
};
