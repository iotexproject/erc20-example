pragma solidity 0.6.0-0.8.0;

import "@openzeppelin/contracts-ethereum-package/contracts/access/ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol";

contract RewardToken is ERC20UpgradeSafe, OwnableUpgradeSafe {
    event OperatorAdded(address);
    event OperatorRemoved(address);

    mapping(address => bool) public operators;

    function initialize() public initializer {
        __ERC20_init("RewardToken", "RT");
        OwnableUpgradeSafe.__Ownable_init();
    }

    function mint(address _account, uint256 _amount) external {
        require(operators[_msgSender()], "invalid operator");
        _mint(_account, _amount);
    }

    function burn(uint256 _amount) external {
        _burn(_msgSender(), _amount);
    }

    function addOperator(address _account) external onlyOwner {
        require(!operators[_account], "already an operator");
        operators[_account] = true;
        emit OperatorAdded(_account);
    }

    function removeOperator(address _account) external onlyOwner {
        require(operators[_account], "not an operator");
        operators[_account] = false;
        emit OperatorRemoved(_account);
    }
}
