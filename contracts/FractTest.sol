// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import { Base64 } from "./libraries/Base64.sol";

contract FractNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    constructor() ERC721 ("FractNFT", "FRACT") {
        console.log("Creates NFT. Can parse other NFT of the same type and accrue their data.");
    }

    // Create New NFT, thus no nests or other data to grab from
    function mintNewFractNFT(string memory set_name, string memory add, string memory data) public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Package all the JSON metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        set_name,
                        '", "creator": "',
                        add,
                        '", "nests": "", "data": "',
                        data,'"}'
                    )
                )
            )
        );

        // Base64 encode JSON metadata
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        
        // Update URI
        _setTokenURI(newItemId, finalTokenUri);
    
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }

    // Create NFT from other NFT (one or more) of the same type
    function mintFractNFT(string memory set_name, string memory c_address, string memory nests, string memory data) public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Package all the JSON metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        set_name,
                        '", "creator": "',
                        c_address,
                        '", "nests": "',
                        nests,
                        '", "data": "',
                        data,'"}'
                    )
                )
            )
        );

        // Base64 encode JSON metadata
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        
        // Update URI
        _setTokenURI(newItemId, finalTokenUri);
    
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}