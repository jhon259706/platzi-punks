// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract PlatziPunks is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    address payable private owner;
    uint256 public maxSupply;

    constructor(uint256 _maxSupply) ERC721("PlatziPunk", "PLPKS") {
        maxSupply = _maxSupply;
        owner = payable(msg.sender);
    }

    event NotifyTokenMintedId(uint256 tokenId);

    function mint() public payable {
        uint256 mintFee = msg.value;
        require(mintFee > 5000000000000000, "Insufficient funds");
        uint tokenId = _idCounter.current();
        require(tokenId < maxSupply, "No PlatziPunks left :c");

        _safeMint(msg.sender, tokenId);
        _idCounter.increment();
        Address.sendValue(owner, mintFee);
        emit NotifyTokenMintedId(tokenId);
    }

    // Override required for enumerable tokens
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}