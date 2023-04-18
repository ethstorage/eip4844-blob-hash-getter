# eip4844-blob-hash-getter




## Motivation
EIP-4844 introduces the binary large object (BLOB) and adds DATAHASH (0x49) opcode to retrieve the hash of the BLOB.  Unfortunately, it takes some time for solidity to support the new opcode. As a result, it will be difficult for developers to experiment with the BLOB features on devnet.


This repo provides a simple solidity implementation to support getting the data hash of a BLOB.  The basic idea is to deploy a customized assembly code in a contract, where the assembly code accepts 32-byte input as data index and outputs 32 bytes as datahash.  Then a solidity library is created to hide the details of the underlying assembly code call.




## Assembly Code to Support DATAHASH opcode


The assembly code we use is `0x6000354960005260206000F3`, and the disassembly description is


```
0x6000
0x35    # calldataload msg[0:32]
0x49    # datahash
0x6000
0x52    # mstore offset=0, value=datahash
0x6020
0x6000
0xF3    # return offset=0, length=32
```


## How to Test?


First, you need to run an EIP-4844 devnet.  Next, you need to deploy the assembly code by calling `BlobHashGetterDeployer.deploy()`.  Now, you can use `BlobHashGetter.getBlobHash()` to retrieve the blob hash.