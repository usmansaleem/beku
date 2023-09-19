# Deneb Web3Siogner Besu Teku test

Based on
https://github.com/siladu/beku-timestamp which is a fork of
https://github.com/rolfyone/playground/tree/main/capella/beku
(which is based on https://github.com/ajsutton/merge-scripts/tree/main/beku)

## Setup

- Use whichever [besu](https://github.com/hyperledger/besu), [teku](https://github.com/ConsenSys/teku) and 
[web3signer](https://github.com/ConsenSys/web3signer) branch you want to test, build them respectively with `./gradlew installDist`
- Update `config.sh` with home locations of Besu, Teku and Web3Signer generated builds. For example:

```shell
WEB3SIGNER_HOME=$HOME/work/web3signer/build/install/web3signer
BESU_HOME=$HOME/work/besu/build/install/besu
TEKU_HOME=$HOME/work/teku/build/install/teku
```

# Start Network
Run scripts in following order (in multiple terminal windows if required):

1. Run `startWeb3Signer.sh`. This will start web3signer with Teku's interop validator keys and our custom config file.
2. Run `setup.sh`. This will generate Teku's mock genesis ssz with genesis time to 60 seconds from now. It 
will also update Besu's `execution-genesis.json` with `shanghaiTime` and `cancunTime` 24 seconds apart from genesis to 
simulate fork transition. You should see an output similar to:
```
********************
TEKU Genesis : 1695102574
BESU Shanghai: 1695102598
BESU Cancun/Deneb: 1695102622
********************
Generating mock genesis state for 256 validators at genesis time 1695102574
Saving genesis state to file: /Users/user/work/beku/beku-genesis.ssz
Genesis state file saved: /Users/user/work/beku/beku-genesis.ssz
```
3. Run `startBesu.sh`. We need to start Besu before Teku so that we can read the genesis hash block.
4. Run `startTeku.sh`. This script will internally call `update-genesis-hash.sh` which will update `genesis-header.json` 
file with genesis root hash. This allows Teku to use genesis root hash from our provided file.

## Cleanup
Terminate Web3Signer, Besu and Teku if they are running i.e. CTRL+C.  Run `cleanup.sh` to clean artifacts of these scripts.

