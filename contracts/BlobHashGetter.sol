// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract ContractFactory {
    constructor(bytes memory code) payable {
        uint256 size = code.length;
        assembly {
            return(add(code, 0x020), size)
        }
    }
}

contract BlobHashGetterDeployer {
    bytes internal CODE = hex"6000354960005260206000F3";

    function deploy() public returns (address) {
        return  address(new ContractFactory(CODE));
    }
}

library BlobHashGetter {
    function getBlobHash(address getter, uint256 idx) internal view returns (bytes32) {
        bool success;
        bytes32 blobHash;
        assembly {
            mstore(0x0, idx)

            success := staticcall(gas(), getter, 0x0, 0x20, 0x0, 0x20)

            blobHash := mload(0x0)
        }

        require(success, "failed to get");
        return blobHash;
    }
}