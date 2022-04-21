pragma solidity 0.8.7;
import "./Ownable.sol";
import "./Destroyable.sol";

interface govermentInterface{
function addTransaction(address _from, address _to, uint _amount) external;
}


contract Bank is Ownable, Destroyable {

     govermentInterface instanceGov = govermentInterface(0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B);

    mapping(address => uint) balance;
    
    event depositDone(uint amount, address indexed depositedTo);
    
    function deposit() public payable returns (uint)  {
        balance[msg.sender] += msg.value;
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
    }
    
    function withdraw(uint amount) public onlyOwner returns (uint){
        require(balance[msg.sender] >= amount);
        payable(msg.sender).transfer(amount);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");
        
        uint previousSenderBalance = balance[msg.sender];
        
        _transfer(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == previousSenderBalance - amount);
    }
    
    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;

        instanceGov.addTransaction(from,to,amount);
    }
    
}
