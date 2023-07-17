
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

// 1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. 
// (Only the owner can mint tokens).
// 2. Transferring tokens: Players should be able to transfer their tokens to others.
// 3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// 4. Checking token balance: Players should be able to check their token balance at any time.
// 5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.



contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

        // Mint function
        function mintTokens(address to, uint256 amount) public onlyOwner{
            _mint(to, amount);
        }

        // Transfer Tokens Function
        function transferTokens(address _reciever, uint amount) external{
            require(balanceOf(msg.sender) >= amount, "Sorry, only owner can mint tokens.");
            approve(msg.sender, amount);
            transferFrom(msg.sender, _reciever, amount);
        }

        // Game Store Items
        function gameShop() public pure returns(string memory) {
            return "1. Conqueror Tag = 800 Tokens\n 2. Ace Tag = 600 Tokens\n 3. Crown Tag = 250 Tokens\n 4. Diamond Tag = 175 Tokens";
        }

        // Function to redeem tokens
        function reedemTokens(uint choice) external payable{
            require(choice<=4,"Invalid Choice");

            if(choice ==1){
                require(balanceOf(msg.sender)>=800, "Insufficient Tokens");
                approve(msg.sender, 800);
                transferFrom(msg.sender, owner(), 800);
            }
            else if(choice ==2){
                require(balanceOf(msg.sender) >= 600, "Insufficient Tokens");
                approve(msg.sender, 600);
                transferFrom(msg.sender, owner(), 600);
            }

            else if(choice == 3){
                require(balanceOf(msg.sender) >= 250, "Insufficient Tokens");
                approve(msg.sender, 250);
                transferFrom(msg.sender, owner(), 250);
            }

            else{
                require(balanceOf(msg.sender) >= 175, "Insufficient Tokens");
                approve(msg.sender, 175);
                transferFrom(msg.sender, owner(), 175);
            }
        }

        // Function to check token balance
        function checkTokenBalance() external view returns(uint){
           return balanceOf(msg.sender);
        }

        // Function to burn tokens
        function burnTokens(uint amount) external{
            require(balanceOf(msg.sender)>= amount, "You don't have enough tokens!");
            _burn(msg.sender, amount);
        }

}