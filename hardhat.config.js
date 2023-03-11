const hre = require("hardhat");

require("@nomiclabs/hardhat-waffle");

module.exports = {
  defaultNetwork: "goerli",
  networks: {
    hardhat: {
    },
    goerli: {
      url: "https://goerli.infura.io/v3/",
      accounts: [c68ab45dc9f95dc3574c50d138642a28ef7249e0966196ed814d67df0b2c9af6
      ]
    }
  },

  solidity: "0.8.4",
  paths: {
    artifacts: "./src/backend/artifacts",
    sources: "./src/backend/contracts",
    cache: "./src/backend/cache",
    tests: "./src/backend/test"
  },
};
