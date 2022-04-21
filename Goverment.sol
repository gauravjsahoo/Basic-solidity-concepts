pragma solidity 0.8.7;

contract GovermentInterface{

    struct Transaction{

        address from;
        address to;
        uint amount;
        uint index;

    }

    Transaction[] logs;

      function addTransaction(address _from, address _to, uint _amount) external {

                 logs.push(Transaction(_from,_to,_amount,logs.length));
      }

      function getTransaction(uint _index) public view returns(address, address, uint)
      {

          return ( logs[_index].from, logs[_index].to, logs[_index].amount); 
      }

}
