pragma solidity ^0.4.21;

contract Escrow {
    
    enum State {Awaiting_Payment, Awaiting_Delivery,Complete}
    
    State public currentState;
    address buyer;
    address seller;
    
    modifier buyerOnly(){require(msg.sender == buyer);_;}
    modifier inState(State expectedState){require(currentState == expectedState);_;}
    
    constructor(address _buyer,address _seller) public {
        buyer = _buyer;
        seller = _seller;
    }
    
    function confirmPayment() buyerOnly inState(State.Awaiting_Payment) public payable {
        
        currentState = State.Awaiting_Delivery;
        
    }
    
    function confirmDelivery() buyerOnly inState(State.Awaiting_Delivery) public {
        
        seller.send(this.balance);
        currentState = State.Complete;
    }   
}