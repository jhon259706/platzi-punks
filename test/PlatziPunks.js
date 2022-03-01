const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Platzi Punks NFT contract", function () {
  var owner;
  var PlatziPunks;
  var PlatziPunksContract;

  beforeEach(async function () {
    [owner] = await ethers.getSigners();
    PlatziPunks = await ethers.getContractFactory("PlatziPunks");
    PlatziPunksContract = await PlatziPunks.deploy(10);
  });

  it("Check the owner", async function () {
    const mintReturn = PlatziPunksContract.mint({
      value: ethers.utils.parseEther("0.01"),
    });

    expect(await PlatziPunksContract.ownerOf(0)).to.equal(
      await owner.getAddress()
    );
  });
});
