const BigNumber = require('bignumber.js')

const main = async () => {
  const votingContractFactory = await hre.ethers.getContractFactory("Voting");
  const votingContract = await votingContractFactory.deploy();
  await votingContract.deployed();
  console.log("Contract address:", votingContract.address);

  const proposalTxn1 = await votingContract.proposeCandidate("George");
  await proposalTxn1.wait();

  const candidatesCheck1 = await votingContract.getCandidates();
  console.log(`There are ${candidatesCheck1.length} candidates so far`);

  const proposalTxn2 = await votingContract.proposeCandidate("John");
  await proposalTxn2.wait();
  
  const candidatesCheck2 = await votingContract.getCandidates();
  console.log(`There are ${candidatesCheck2.length} candidates so far`);


  const voteTxn1 = await votingContract.vote("George");
  await voteTxn1.wait();
  
  const candidatesCheck3 = await votingContract.getCandidates();
  const votesRaw = candidatesCheck3.find(item => item.name === 'George').votes
  console.log("🚀 ~ main ~ votesRaw", typeof votesRaw)
  // const georgeVotes = new BigNumber(votesRaw).toNumber(),
  // console.log("🚀 ~ main ~ georgesVotes", georgesVotes)
  // console.log(`George has ${candidatesCheck3}`);

};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();