module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.autolink();
  deployer.deploy(HumanStandardToken);
  deployer.deploy(GroundCouncil);
};
