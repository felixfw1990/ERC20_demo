const {ethers} = require("ethers");
const fs = require("fs");

const ABI = JSON.stringify(JSON.parse(fs.readFileSync('./build/contracts/ERC20.json', 'utf8')).abi)
const ADDRESS = '0x46AeB339E0fAD193c2127BdC4e48AD8f758aaC4A';
const URI = 'HTTP://127.0.0.1:7545';
const PROVIDER = new ethers.providers.JsonRpcProvider(URI);
const contract = new ethers.Contract(ADDRESS, ABI, PROVIDER);

const getContract = () => {
  const provider = new ethers.providers.JsonRpcProvider(URI);
  return new ethers.Contract(ADDRESS, ABI, provider);
}

const getDaiWithSinger = () => {
   const provider = new ethers.providers.JsonRpcProvider(URI);
   const singer = provider.getSigner();
   return contract.connect(singer);
}

describe("deploy", () => {
  it('init', async () => {
  });

  it('demo', async () =>
  {
  });

  it('getName', async () => {
    console.log(await getContract().name());
  });

  it('get total supply', async () => {
    const decimals = await getContract().decimals()
    const result = await getContract().totalSupply()
    console.log(ethers.utils.formatUnits(result, decimals));
  });

  it('mint', async () => {

    const toAddress = '0x07637E260bdAfd820255Eb30e34EB3472800Eb87';

    const result = await getDaiWithSinger().mint(toAddress, 100*100000000);

    console.log(result);
  });

  it('burn', async () => {
    const result = await getDaiWithSinger().burn(100*100000000);

    console.log(result);
  });
});
