pragma solidity ^0.4.6;

contract Escrow {
    
    modifier onlyBroker() {
        if (msg.sender != broker) throw;

        _;
    }
    
    modifier onlyParty() {
        if (msg.sender != party1 && msg.sender != party2) throw;

        _;
    }
    
    address public broker;
    address public party1;
    address public party2;
    uint public deposited1;
    uint public deposited2;
    uint public setFee;
    
    bool forceRelease1;
    bool forceRelease2;
    
    
    function Escrow(address p1, address p2, uint fee) {
        broker = msg.sender;
        party1 = p1;
        party2 = p2;
        setFee = fee;
    }
    
    function deposit1() payable{
        deposited1 += msg.value;
    }
    
    function deposit2() payable{
        deposited2 += msg.value;
    }    
    
    function releaseFund1() onlyBroker {
        if (deposited1 - setFee < 0) return;
        broker.send(setFee);
        party1.send(deposited1-setFee);
    }
    
    function releaseFund2() onlyBroker {
        if (deposited2 - setFee < 0) return;
        broker.send(setFee);
        party2.send(deposited2-setFee);
    }
    
    function forceRelease() onlyParty{
        if (msg.sender == party1) forceRelease1 = true;
        else if (msg.sender == party2) forceRelease2 = true;
        
        if (forceRelease1 && forceRelease2)
        {
            party1.send(deposited1-setFee);
            party2.send(deposited2-setFee);
            deposited1 = 0;
            deposited2 = 0;
        }
    }

    function () { throw; }
    
}