pragma solidity ^0.4.24;
contract market
{
    
    uint private  currentItemPrice;
    uint private currentItemQuantity;
    uint private currentTotal;
    uint private incomingPayment;
    uint private inventorySize;
    string private currentItemName;
    string private mOTD;
    string private transactionStatus;
    string private pubKey;
    string private customerContact;
    address private owner;
    uint private i;
    uint private k;
    Inventory[] public inventory;
    Customers[] private customers;
    
    struct Inventory{
        string itemName;
        uint itemPrice;
        uint itemAmount;
        
        
    }
    
    struct Customers{
        string contactInfo;
        string itemName;
        uint numBought;
        uint amountSpent;
    }
    
     function() public{
        pubKey = "null";
        owner = msg.sender;
        mOTD = "null";
        i=0;
    }
    
    constructor (string incPubKey, uint numItems, string message) public{
        pubKey = incPubKey;
        inventorySize = numItems;
        mOTD = message;
        owner = msg.sender;
        i=0;
        k=0;
        
    }
    
    function addItem(string name, uint amount, uint price) public returns (string){
        Inventory memory newItem;
        newItem.itemName = name;
        newItem.itemPrice = price;
        newItem.itemAmount = amount;
        
        inventory.push(newItem);
        return "Item has been successfully added to the list";
    }
    
    function itemLookUp(uint indexPosition) view public returns (string){
    
        return inventory[indexPosition].itemName;
    }
    
    function itemRelabel(uint indexPosition, string newName, uint newPrice, uint newQuantity) public returns (string){
        
        inventory[indexPosition].itemName = newName;
        inventory[indexPosition].itemPrice = newPrice;
        inventory[indexPosition].itemAmount = newQuantity;
        
        return "The item has been successfuly updated with its new values";
    }
    
    function dailyFlyer() view public returns (string){
        return mOTD;
    }
    
    function blowThisPopsicleStand()  public returns(string){
        if (owner == msg.sender){
            selfdestruct(owner);
        }
        else{
            return "ahahahah you didnt say the magc word";
        }
    }
    
    function buyItem(uint indexPosition, uint quantity, string contactMethod)  public payable returns (string){
        
        if (indexPosition <= inventorySize && quantity <= inventory[indexPosition].itemAmount && msg.value > 0 ){
            if(msg.value / inventory[indexPosition].itemPrice == quantity){
                address(owner).transfer(msg.value);
                inventory[indexPosition].itemAmount = inventory[indexPosition].itemAmount - quantity;
                
                Customers memory newCustomer;
                newCustomer.contactInfo = contactMethod;
                newCustomer.itemName = inventory[indexPosition].itemName;
                newCustomer.numBought = quantity;
                newCustomer.amountSpent = msg.value;
                customers.push(newCustomer);
                return "Your order has been processed succesfully, you will be contacted shortly";
            }
        }
        else{
            return "There was an issue with your input please try agian";
        }
    }
    
    function grabCustomers() public returns(string) {
        if (customers.length == 0){
            return "Sorry there are no new customers";
        }
        else{
            customerContact = customers[k].contactInfo;
            k++;
        }
        return customerContact;
    }
      
     
}
