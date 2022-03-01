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
    const mintReturn = PlatziPunksContract.mint({
      value: ethers.utils.parseEther("0.01"),
    });
  });

  it("Check the owner", async function () {
    expect(await PlatziPunksContract.ownerOf(0)).to.equal(
      await owner.getAddress()
    );
  });

  it("Check token URI", async function () {
    expect(await PlatziPunksContract.tokenURI(0)).to.equal(
      "data:application/json;base64,eyAibmFtZSI6ICJQbGF0emlQdW5rcyAj" +
        "IgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIiwgImRlc2NyaXB0aW" +
        "9uIjogIlBsYXR6aSBQdW5rcyBhcmUgcmFuZG9taXplZCBBdmF0YWFhcnMgc3Rv" +
        "cmVkIG9uIGNoYWluIHRvIHRlYWNoIERBcHAgZGV2ZWxvcG1lbnQgb24gUGxhdH" +
        "ppIiwgImltYWdlIjogIi8vIFRPRE86IENhbGN1bGF0ZSBpbWFnZSBVUkwifQ=="
    );
  });
});
