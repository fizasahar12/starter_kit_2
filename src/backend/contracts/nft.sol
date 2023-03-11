nft.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";
import "@openzeppelin/contracts@4.7.3/utils/math/SafeMath.sol";
contract MyToken is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using SafeMath for uint;
 address public treasury;
 address public marketing;
 address public dev;
mapping (address => uint256) public mintCount;
uint256 public poolAmount;
mapping(uint256 => bool) public claimAt;

    Counters.Counter private _tokenIdCounter;


    constructor(address _treasury, address _marketing, address _dev) ERC721("MyToken", "MTK") {
        treasury = _treasury;
        marketing = _marketing;
        dev=_dev;
    }


    function safeMint(address to, string memory uri) payable public onlyOwner {
        _tokenIdCounter.increment();
        require(msg.value == 10000000000000000, "you can buy each nft for 0.01 eth only");
        payable(msg.sender).transfer(address(this).balance);

        require(_tokenIdCounter.current() < 500, "Out of limit");
        require(mintCount[msg.sender] < 3, "cant mint more than 3 NFTS");
        mintCount[msg.sender]++;
       

        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        payable(treasury).transfer((msg.value.div(100).mul(80)));
         payable(marketing).transfer((msg.value.div(100).mul(10)));
          payable(dev).transfer((msg.value.div(100).mul(5)));
          poolAmount += msg.value.div(100).mul(5);
    }
    function claim(uint256 _nftid) external {
        require(_exists(_nftid));
        require(ownerOf(_nftid) == msg.sender, "youre not a owner");
        require(!claimAt[_nftid], "Already Claimed");
        //ager claim true hai tw agay nh janay deraha because of !, becayse require ki condition 
    //true per chalti hai
        payable(msg.sender).transfer((poolAmount).div(_tokenIdCounter.current()));
        //0.002/4 = 0.00005 1 nft walay bandy ko mile 0.0005
        claimAt[_nftid] = true;
    }

    // The following functions are overrides required by Solidity.
    
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
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
