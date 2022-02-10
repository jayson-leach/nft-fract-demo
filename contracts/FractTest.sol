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
    int private max_tokens;
    
    constructor() ERC721 ("FractNFT", "FRACT") {
        console.log("Creates NFT. Can parse other NFT of the same type and accrue their data.");
    }

    // Create NFT set with a maximum number of tokens
    // set_name: the name of the NFT
    // add: the address intended for the NFT
    // data: any data to be stored within the NFT
    // max: maximum number of NFTs
    // reset: true if new NFT, false if continuing
    function mintCountFractNFT(string memory set_name, string memory add, string memory data, int max) public {
        // set token id and maximum tokens
        uint256 newItemId = _tokenIds.current();
        max_tokens = max;

        if (int(_tokenIds.current()) == max_tokens) {
            console.log("Maxmimum NFTs have been minted.");
        } else {
            // Package all the JSON metadata
            string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{"name": "',
                            set_name,
                            '", "creator": "',
                            add,
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

    // Create NFT with no maximum count
    // set_name: the name of the NFT
    // add: the address intended for the NFT
    // data: any data to be stored within the NFT
    // reset: true if new NFT, false if continuing
    function mintFractNFT(string memory set_name, string memory add, string memory data) public {
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