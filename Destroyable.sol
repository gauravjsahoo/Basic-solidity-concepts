pragma solidity 0.8.7;

import "./Ownable.sol";

contract Destroyable is Ownable {

  function destroy() public onlyOwner {

    selfdestruct( payable(msg.sender));

  }
}
