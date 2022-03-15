require("@nomiclabs/hardhat-waffle");
require("dotenv").config();
const { MUMBAI_API_URL, PRIVATE_KEY } = process.env;

module.exports = {
  solidity: "0.8.0",
  networks: {
    localhost: {
      chainId: 31337, // Chain ID should match the hardhat network's chainid
      accounts: [`0x${PRIVATE_KEY}`]
    },
    polygon_mumbai: {
      url: MUMBAI_API_URL,
      accounts: [`0x${PRIVATE_KEY}`]
   }    
  }
};
