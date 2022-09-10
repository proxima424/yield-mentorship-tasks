// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;


contract Registry {

//Users (identified by an address) can claim a name, which is recorded on-chain
//Once a name has been claimed, no other user can claim it.  
//A name owner can release a name. 
//A user can claim any number of names.

  mapping ( string => address ) name_owner;
  error AlreadyClaimed();
  error Unauthorized();
  event NameClaimed ( string indexed, address indexed);

  function claim_name(string memory p) external {
      if( name_owner[p] != address(0)){
          revert Unauthorized();
      }
      name_owner[p] = msg.sender;
      emit NameClaimed(p,msg.sender);
  }

  function release_name(string memory p) external {
      if(  name_owner[p] != msg.sender  ){
          revert AlreadyClaimed();
      }
      delete name_owner[p];
  }


}