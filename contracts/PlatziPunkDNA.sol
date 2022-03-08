// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlatziPunkDNA {
    string[] private _accessoriesType = [
        "Blank",
        "Kurt",
        "Prescription01",
        "Prescription02",
        "Round",
        "Sunglasses",
        "Wayfarers"
    ];

    string[] private _clotheColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _clotheType = [
        "BlazerShirt",
        "BlazerSweater",
        "CollarSweater",
        "GraphicShirt",
        "Hoodie",
        "Overall",
        "ShirtCrewNeck",
        "ShirtScoopNeck",
        "ShirtVNeck"
    ];

    string[] private _eyeType = [
        "Close",
        "Cry",
        "Default",
        "Dizzy",
        "EyeRoll",
        "Happy",
        "Hearts",
        "Side",
        "Squint",
        "Surprised",
        "Wink",
        "WinkWacky"
    ];

    string[] private _eyebrowType = [
        "Angry",
        "AngryNatural",
        "Default",
        "DefaultNatural",
        "FlatNatural",
        "RaisedExcited",
        "RaisedExcitedNatural",
        "SadConcerned",
        "SadConcernedNatural",
        "UnibrowNatural",
        "UpDown",
        "UpDownNatural"
    ];

    string[] private _facialHairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "Platinum",
        "Red"
    ];

    string[] private _facialHairType = [
        "Blank",
        "BeardMedium",
        "BeardLight",
        "BeardMagestic",
        "MoustacheFancy",
        "MoustacheMagnum"
    ];

    string[] private _hairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "PastelPink",
        "Platinum",
        "Red",
        "SilverGray"
    ];

    string[] private _hatColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _graphicType = [
        "Bat",
        "Cumbia",
        "Deer",
        "Diamond",
        "Hola",
        "Pizza",
        "Resist",
        "Selena",
        "Bear",
        "SkullOutline",
        "Skull"
    ];

    string[] private _mouthType = [
        "Concerned",
        "Default",
        "Disbelief",
        "Eating",
        "Grimace",
        "Sad",
        "ScreamOpen",
        "Serious",
        "Smile",
        "Tongue",
        "Twinkle",
        "Vomit"
    ];

    string[] private _skinColor = [
        "Tanned",
        "Yellow",
        "Pale",
        "Light",
        "Brown",
        "DarkBrown",
        "Black"
    ];

    string[] private _topType = [
        "NoHair",
        "Eyepatch",
        "Hat",
        "Hijab",
        "Turban",
        "WinterHat1",
        "WinterHat2",
        "WinterHat3",
        "WinterHat4",
        "LongHairBigHair",
        "LongHairBob",
        "LongHairBun",
        "LongHairCurly",
        "LongHairCurvy",
        "LongHairDreads",
        "LongHairFrida",
        "LongHairFro",
        "LongHairFroBand",
        "LongHairNotTooLong",
        "LongHairShavedSides",
        "LongHairMiaWallace",
        "LongHairStraight",
        "LongHairStraight2",
        "LongHairStraightStrand",
        "ShortHairDreads01",
        "ShortHairDreads02",
        "ShortHairFrizzle",
        "ShortHairShaggyMullet",
        "ShortHairShortCurly",
        "ShortHairShortFlat",
        "ShortHairShortRound",
        "ShortHairShortWaved",
        "ShortHairSides",
        "ShortHairTheCaesar",
        "ShortHairTheCaesarSidePart"
    ];

    uint8 constant SECTION_SIZE = 2;

    function _generateDNA(uint256 _tokenId, address _minter)
        public
        pure
        returns (uint256)
    {
        uint256  combinedParams = _tokenId + uint160(_minter);
        bytes memory encodedParams = abi.encodePacked(combinedParams);
        bytes32 hashedParams = keccak256(encodedParams);
        
        return uint256(hashedParams);
    }

    function _getDNASection(uint256 _dna, uint8 _section)
        internal 
        pure 
        returns (uint8)
    {
        uint256 dnaShiftedLeft = _dna % (10 ** (_section * SECTION_SIZE));
        uint8 dnaSection = uint8(dnaShiftedLeft / (10 ** ((_section - 1) * SECTION_SIZE)));
        return dnaSection;
    }

    function getAccessoriesType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = _getDNASection(_dna, 1);
        return _accessoriesType[dnaSection % _accessoriesType.length];
    }

    function getClotheColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 2);
        return _clotheColor[dnaSection % _clotheColor.length];
    }

    function getClotheType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 3);
        return _clotheType[dnaSection % _clotheType.length];
    }

    function getEyeType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 4);
        return _eyeType[dnaSection % _eyeType.length];
    }

    function getEyeBrowType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 5);
        return _eyebrowType[dnaSection % _eyebrowType.length];
    }

    function getFacialHairColor(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = _getDNASection(_dna, 6);
        return _facialHairColor[dnaSection % _facialHairColor.length];
    }

    function getFacialHairType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = _getDNASection(_dna, 7);
        return _facialHairType[dnaSection % _facialHairType.length];
    }

    function getHairColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 8);
        return _hairColor[dnaSection % _hairColor.length];
    }

    function getHatColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 9);
        return _hatColor[dnaSection % _hatColor.length];
    }

    function getGraphicType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 10);
        return _graphicType[dnaSection % _graphicType.length];
    }

    function getMouthType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 11);
        return _mouthType[dnaSection % _mouthType.length];
    }

    function getSkinColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 12);
        return _skinColor[dnaSection % _skinColor.length];
    }

    function getTopType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 13);
        return _topType[dnaSection % _topType.length];
    }
}