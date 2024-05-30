## TREx Token

# WARNING - Testing Token - Not for Production!


| Contract        | Deployment                                 | Network |
| --------------- | ------------------------------------------ | ------- |
| ProxyAdmin      | 0x48707AA23F0eB7A37C239a87fc0486489a293C8f | Sepolia |
| TREx            | 0xe628A0B8304100695887b0b57d196e7CDEbF3894 | Sepolia |
| SimplePriceFeed | 0x66C4924Cc30dC47D0c8484143236F465F4e37c9E | Sepolia |

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
# tokenfeed
