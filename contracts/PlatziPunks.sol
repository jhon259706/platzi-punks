// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./Base64.sol";
import "./PlatziPunkDNA.sol";

contract PlatziPunks is ERC721, ERC721Enumerable, PlatziPunkDNA {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    address payable private owner;
    uint256 public maxSupply;
    mapping(uint256 => uint256) tokenDNA;

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
        tokenDNA[tokenId] = _generateDNA(tokenId, msg.sender); 
        _idCounter.increment();
        Address.sendValue(owner, mintFee);
        emit NotifyTokenMintedId(tokenId);
    }

    function _baseURI() internal pure override returns(string memory) {
        return "https://avataaars.io/";
    }

    function _paramsURI(uint256 _dna) private view returns (string memory)
    {
        bytes memory params = abi.encodePacked(
            "accessoriesType=", getAccessoriesType(_dna),
            "&clotheColor=", getClotheColor(_dna),
            "&clotheType=", getClotheType(_dna),
            "&eyeType=", getEyeType(_dna),
            "&eyebrowType=", getEyeBrowType(_dna),
            "&facialHairColor=", getFacialHairColor(_dna)
        );

        params = abi.encodePacked(
            params,
            "&facialHairType=", getFacialHairType(_dna),
            "&hairColor=", getHairColor(_dna),
            "&hatColor=", getHatColor(_dna),
            "&graphicType=", getGraphicType(_dna),
            "&mouthType=", getMouthType(_dna),
            "&skinColor=", getSkinColor(_dna),
            "&topType=", getTopType(_dna)
        );

        return string(params);
    }

    function imageByDNA(uint256 _dna) public view returns(string memory) {
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);

        return string(abi.encode(baseURI, "?", paramsURI));
    }

    function tokenURI(uint256 tokenId) 
        public 
        view 
        override 
        returns(string memory) 
    {
        require(
            _exists(tokenId), 
            'ERC721 Metadata: URI query for nonexistent token'
        );

        uint256 dna = tokenDNA[tokenId];
        string memory image = imageByDNA(dna);

        string memory encodedData = Base64.encode(
            abi.encodePacked(
                '{', 
                '"name": "PlatziPunks #', tokenId, '", ',
                '"description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", ',
                '"image": "', image, '"',
                '}'
            )
        );

        string memory jsonURI = string(
            abi.encodePacked(
                'data:application/json;base64,', 
                encodedData
            )
        );

        return jsonURI;
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