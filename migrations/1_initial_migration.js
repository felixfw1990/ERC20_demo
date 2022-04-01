const ERC = artifacts.require("ERC20.sol");

module.exports = function (deployer) {
  deployer.deploy(ERC);
};
