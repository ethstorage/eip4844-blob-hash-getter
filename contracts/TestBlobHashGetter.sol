// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "./BlobHashGetter.sol";

contract TestBlobHashGetter {
    bytes32 public blobHash;

    function getAndSetBlobHash(address getter, uint256 idx) public {
        blobHash = BlobHashGetter.getBlobHash(getter, idx);
    }
}