// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Vouch {
    struct Credential {
        address issuer;
        uint8 serviceType;
        uint256 issuedAt;
        bool revoked;
    }

    address public owner;

    mapping(bytes32 => Credential) public credentials;
    mapping(address => bool) public authorizedOrgs;

    event OrgAuthorized(address indexed org);
    event CredentialIssued(bytes32 indexed personId, address indexed issuer, uint8 serviceType);
    event DeliveryRecorded(bytes32 indexed personId, address indexed org, uint8 serviceType);
    event CredentialRevoked(bytes32 indexed personId, address indexed org);

    error NotOwner();
    error NotAuthorized();
    error AlreadyIssued();
    error NotFound();
    error Revoked();

    constructor() {
        owner = msg.sender;
        authorizedOrgs[msg.sender] = true;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    modifier onlyAuthorized() {
        if (!authorizedOrgs[msg.sender]) revert NotAuthorized();
        _;
    }

    function authorizeOrg(address org) external onlyOwner {
        authorizedOrgs[org] = true;
        emit OrgAuthorized(org);
    }

    function issueCredential(bytes32 personId, uint8 serviceType) external onlyAuthorized {
        if (credentials[personId].issuedAt != 0) revert AlreadyIssued();

        credentials[personId] = Credential({
            issuer: msg.sender,
            serviceType: serviceType,
            issuedAt: block.timestamp,
            revoked: false
        });

        emit CredentialIssued(personId, msg.sender, serviceType);
    }

    function recordDelivery(bytes32 personId, uint8 serviceType) external onlyAuthorized {
        Credential memory cred = credentials[personId];
        if (cred.issuedAt == 0) revert NotFound();
        if (cred.revoked) revert Revoked();

        emit DeliveryRecorded(personId, msg.sender, serviceType);
    }

    function revokeCredential(bytes32 personId) external onlyAuthorized {
        Credential storage cred = credentials[personId];
        if (cred.issuedAt == 0) revert NotFound();

        cred.revoked = true;
        emit CredentialRevoked(personId, msg.sender);
    }

    function isValid(bytes32 personId) external view returns (bool) {
        Credential memory cred = credentials[personId];
        return cred.issuedAt != 0 && !cred.revoked;
    }
}
