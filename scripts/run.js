// Called by npx hardhat run scripts/run.js

const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('FractNFT');
    [owner, addr1, addr2] = await ethers.getSigners();
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
  
    for (let i=0; i<12; i++){
      // Call the function.
      let txn = await nftContract.mintCountFractNFT('Bot', owner.address, 'data1', 10)
      // Wait for it to be mined.
      await txn.wait()
    }

    for (let i=0; i<100; i++) {
      // Call the function.
      let txn2 = await nftContract.mintFractNFT('Bot', addr1.address, 'data2')
      // Wait for it to be mined.
      await txn2.wait()
    }
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