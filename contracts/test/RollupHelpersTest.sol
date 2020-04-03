pragma solidity ^0.6.1;

import "../lib/RollupHelpers.sol";

contract RollupHelpersTest is RollupHelpers{

  constructor( address _poseidonContractAddr) RollupHelpers(_poseidonContractAddr) public {}

  function testHashGeneric(uint256[] memory inputs) public view returns(uint256) {
    return hashGeneric(inputs);
  }

  function testHashNode(uint256 left, uint256 right) public view returns(uint256) {
    return hashNode(left, right);
  }

  function testHashFinalNode(uint256 key, uint256 value) public view returns (uint256){
    return hashFinalNode(key, value);
  }

  function smtVerifierTest(uint256 root, uint256[] memory siblings,
    uint256 key, uint256 value, uint256 oldKey, uint256 oldValue,
    bool isNonExistence, bool isOld, uint256 maxLevels) public view returns (bool){
    return smtVerifier(root, siblings, key, value, oldKey,
      oldValue, isNonExistence, isOld, maxLevels);
  }

  function testEcrecover(bytes32 msgHash, bytes memory rsv) public pure returns (address) {
    return checkSig(msgHash, rsv);
  }

  function buildEntryFeePlanTest(bytes32[2] memory feePlan)
    public pure returns (bytes32, bytes32, bytes32, bytes32, bytes32) {

    Entry memory entry = buildEntryFeePlan(feePlan);
    return (entry.e1,
            entry.e2,
            entry.e3,
            entry.e4,
            entry.e5);
  }

  function calcTokenTotalFeeTest(bytes32 tokenIds, bytes32 fee, bytes32 nTxToken, uint nToken)
    public pure returns (uint, uint) {
    return calcTokenTotalFee(tokenIds, fee, nTxToken, nToken);
  }

  function buildTreeStateTest(uint256 amount, uint16 token, uint256 Ax, uint256 Ay,
    address withAddress, uint32 nonce) public pure returns (bytes32, bytes32, bytes32, bytes32, bytes32) {
    Entry memory entry = buildTreeState(amount, token, Ax, Ay, withAddress, nonce);
    return (entry.e1,
            entry.e2,
            entry.e3,
            entry.e4,
            entry.e5);
  }

  function hashTreeStateTest(uint256 amount, uint16 token, uint256 Ax, uint256 Ay,
    address withAddress, uint32 nonce) public view returns (bytes32) {
    Entry memory entry = buildTreeState(amount, token, Ax, Ay, withAddress, nonce);
    return bytes32(hashEntry(entry));
  }

  function buildTxDataTest(
    uint16 amountF,
    uint16 token,
    uint32 nonce,
    uint16 maxFee,
    uint8 rqOffset,
    bool onChain,
    bool newAccount
  ) public pure returns (bytes32){
    return buildTxData(amountF, token, nonce, maxFee, rqOffset, onChain, newAccount);
  }

  function buildOnChainHashTest(
    uint256 oldOnChainHash,
    uint256 txData,
    uint128 loadAmount,
    uint256 hashOnChainData
  ) public pure returns (bytes32, bytes32, bytes32, bytes32){
    Entry memory entry = buildOnChainHash(oldOnChainHash, txData, loadAmount, hashOnChainData);
    return (entry.e1,
            entry.e2,
            entry.e3,
            entry.e4);
  }

  function hashOnChainHashTest(
    uint256 oldOnChainHash,
    uint256 txData,
    uint128 loadAmount,
    uint256 hashOnChainData
  ) public view returns (uint256){
    Entry memory entry = buildOnChainHash(oldOnChainHash, txData, loadAmount, hashOnChainData);
    return hashEntry(entry);
  }


  function buildOnChainDataTest(
    address fromEthAddr,
    uint256 fromAx,
    uint256 fromAy,
    address toEthAddr,
    uint256 toAx,
    uint256 toAy
    ) public pure returns (bytes32, bytes32, bytes32, bytes32, bytes32, bytes32) {
     Entry memory entry = buildOnChainData(fromEthAddr, fromAx, fromAy, toEthAddr, toAx, toAy);
    return (entry.e1,
            entry.e2,
            entry.e3,
            entry.e4,
            entry.e5,
            entry.e6);
  }

  function hashOnChainDataTest(
    address fromEthAddr,
    uint256 fromAx,
    uint256 fromAy,
    address toEthAddr,
    uint256 toAx,
    uint256 toAy
    ) public view returns (uint256) {
     Entry memory entry = buildOnChainData(fromEthAddr, fromAx, fromAy, toEthAddr, toAx, toAy);
     return hashEntry(entry);
  }

  function buildAndHashOnChain(
    address fromEthAddr,
    uint256 fromAx,
    uint256 fromAy,
    address toEthAddr,
    uint256 toAx,
    uint256 toAy,
    uint256 oldOnChainHash,
    uint256 txData,
    uint128 loadAmount
    ) public view returns (uint256) {
     Entry memory onChainData = buildOnChainData(fromEthAddr, fromAx, fromAy, toEthAddr, toAx, toAy);
     uint256 hashOnChainData = hashEntry(onChainData);
     Entry memory onChainHash = buildOnChainHash(oldOnChainHash, txData, loadAmount, hashOnChainData);
     return hashEntry(onChainHash);
  }

  function testUnZipAddressTokens(uint256 zip)
    public pure returns (address, uint32) {
   return unZipAddressTokens(zip);
  }
  function float2FixTest(uint16 float) public pure returns (uint256){
    return float2Fix(float);
  }
}