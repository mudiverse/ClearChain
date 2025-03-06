// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PropertyRegistry {
    // The admin (e.g., government office) who can register properties
    address public admin;

    // Each property has a unique propertyId, an ownership proof id, the current owner, and a description/address
    struct Property {
        string propertyId;       // Unique ID for the property
        string ownershipProofId; // Identifier for the ownership proof document
        address owner;           // Current owner of the property
        string propertyAddress;  // Human-readable address or description
    }

    // Mapping from propertyId to Property details
    mapping(string => Property) public properties;
    // Array to keep track of registered property IDs (for iteration if needed)
    string[] public propertyIds;

    // Events for logging key actions
    event PropertyRegistered(string indexed propertyId, address indexed owner);
    event PropertyTransferred(string indexed propertyId, address indexed previousOwner, address indexed newOwner);

    // Only admin can perform certain actions
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Constructor sets the deployer as admin
    constructor() {
        admin = msg.sender;
    }

    /**
     * @dev Registers a new property. Only admin can call this function.
     * @param _propertyId Unique identifier for the property.
     * @param _ownershipProofId Identifier for the ownership proof document.
     * @param _owner Address of the initial owner.
     * @param _propertyAddress Description or address of the property.
     */
    function registerProperty(
        string memory _propertyId,
        string memory _ownershipProofId,
        address _owner,
        string memory _propertyAddress
    ) external onlyAdmin {
        require(properties[_propertyId].owner == address(0), "Property already registered");

        properties[_propertyId] = Property({
            propertyId: _propertyId,
            ownershipProofId: _ownershipProofId,
            owner: _owner,
            propertyAddress: _propertyAddress
        });

        propertyIds.push(_propertyId);
        emit PropertyRegistered(_propertyId, _owner);
    }

    /**
     * @dev Allows the current owner to transfer the property to a new owner.
     * @param _propertyId The unique property identifier.
     * @param _newOwner Address of the new owner.
     */
    function transferProperty(string memory _propertyId, address _newOwner) external {
        Property storage prop = properties[_propertyId];
        require(prop.owner != address(0), "Property not registered");
        require(msg.sender == prop.owner, "Only property owner can transfer");

        address previousOwner = prop.owner;
        prop.owner = _newOwner;
        emit PropertyTransferred(_propertyId, previousOwner, _newOwner);
    }

    /**
     * @dev Returns the details of a property.
     * @param _propertyId The unique property identifier.
     * @return propertyId, ownershipProofId, owner, and propertyAddress.
     */
    function getProperty(string memory _propertyId) external view returns (
        string memory, string memory, address, string memory
    ) {
        Property memory prop = properties[_propertyId];
        require(prop.owner != address(0), "Property not registered");
        return (prop.propertyId, prop.ownershipProofId, prop.owner, prop.propertyAddress);
    }
}
