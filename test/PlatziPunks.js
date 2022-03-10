const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Platzi Punks NFT contract", function () {
  const setup = async ({ maxSupply = 1000 }) => {
    const [owner] = await ethers.getSigners();
    const PlatziPunks = await ethers.getContractFactory("PlatziPunks");
    const deployed = await PlatziPunks.deploy(maxSupply);

    return {
      owner,
      deployed,
    };
  };

  describe("Deployment", () => {
    it("Sets max suppy to passed param", async () => {
      const maxSupply = 4000;
      const { deployed } = await setup({ maxSupply });
      const returnedMaxSupply = await deployed.maxSupply();
      expect(maxSupply).to.equal(returnedMaxSupply);
    });
  });

  describe("Minting", () => {
    it("Mints a new token and assign it to owner", async () => {
      const { owner, deployed } = await setup({});

      await deployed.mint({
        value: ethers.utils.parseEther("0.01"),
      });
      const ownerOfMinted = await deployed.ownerOf(0);

      expect(ownerOfMinted).to.equal(await owner.getAddress());
    });

    it("Has a mingting limit", async () => {
      const maxSupply = 2;
      const mintingParams = { value: ethers.utils.parseEther("0.01") };
      const { deployed } = await setup({ maxSupply });

      await Promise.all([
        await deployed.mint(mintingParams),
        await deployed.mint(mintingParams),
      ]);

      await expect(deployed.mint(mintingParams)).to.be.revertedWith(
        "No PlatziPunks left :c"
      );
    });
  });

  describe("tokenURI", () => {
    it("Valid metadata", async function () {
      const { deployed } = await setup({});
      await deployed.mint({ value: ethers.utils.parseEther("0.01") });

      const tokenURI = await deployed.tokenURI(0);
      const stringifiedTokenURI = await tokenURI.toString();
      const [, base64JSON] = stringifiedTokenURI.split(
        "data:application/json;base64,"
      );
      const stringifiedMetadata = await Buffer.from(
        base64JSON,
        "base64"
      ).toString("ascii");

      const metadata = JSON.parse(stringifiedMetadata);

      expect(metadata).to.have.all.keys("name", "description", "image");
    });
  });
});
