// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    // Product structure
    struct Product {
        uint id;
        string name;
        address currentOwner;
        string status; // e.g., "Manufactured", "Shipped", "Delivered"
    }

    // Store products
    mapping(uint => Product) public products;
    uint public productCount = 0;

    // Events for tracking
    event ProductAdded(uint id, string name, address owner);
    event StatusUpdated(uint id, string status, address owner);

    // Function to add a new product
    function addProduct(string memory _name) public {
        productCount++;
        products[productCount] = Product(productCount, _name, msg.sender, "Manufactured");
        emit ProductAdded(productCount, _name, msg.sender);
    }

    // Function to update product status
    function updateStatus(uint _id, string memory _status) public {
        require(_id > 0 && _id <= productCount, "Invalid product ID");
        Product storage product = products[_id];
        product.status = _status;
        product.currentOwner = msg.sender;
        emit StatusUpdated(_id, _status, msg.sender);
    }

    // Function to view product details
    function getProduct(uint _id) public view returns (uint, string memory, address, string memory) {
        require(_id > 0 && _id <= productCount, "Invalid product ID");
        Product memory product = products[_id];
        return (product.id, product.name, product.currentOwner, product.status);
    }
}
