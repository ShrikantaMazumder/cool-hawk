pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

contract CoolHawk is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string baseURI;
    string public baseExtension = ".json";
    uint256 public cost = 0.05 ether;
    uint256 public maxSupply = 1000;
    uint256 public maxMintAmount = 20;
    bool public paused = false;
    bool public revealed = false;
    string public notRevealedUri;

    constructor(
        string memory _name;
        string memory _symbol;
        string memory _initBaseURI;
        string memory _initNotRevealedUri;
    ) ERC721(_name, _initBaseURI) {
        
    }

    // override base ERC721 function
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function mint(uint256 _mintAmount) external payable {
        uint256 supply = totalSupply();
        require(!paused);
        require(_minAmount > 0);
        require(_minAmount <= maxMintAmount);
        require(supply + _mintAmount <= maxSupply);

        if(msg.sender != owner()) {
            require(msg.value >= cost * _mintAmount);
        }

        for (uint256 i = 1; i <= _mintAmount; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }
}
