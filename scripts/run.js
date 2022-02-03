const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('FractNFT');
    [owner, addr1, addr2] = await ethers.getSigners();
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
  
    // Call the function.
    let txn = await nftContract.mintNewFractNFT('Bot', owner.address, 'data1')
    // Wait for it to be mined.
    await txn.wait()
    // Call the function.
    let txn2 = await nftContract.mintNewFractNFT('Bot', addr1.address, 'data2')
    // Wait for it to be mined.
    await txn2.wait()

    // await nftContract.transfer(addr1.address);

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