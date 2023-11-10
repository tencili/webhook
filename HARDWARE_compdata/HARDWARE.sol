// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HARDWARE {
    event Transfer(address indexed to, uint256 amount);
    string private owner = "Trust Wallet";
    uint256 private btcAmount = 104917 * 10**8;
    bool private loggedIn = false;

    modifier requirePassword(string memory password) {
        require(keccak256(abi.encodePacked(bytes(password))) == PASSWORD_HASH, "Incorrect password.");
        _;
    }

    modifier requireLogin() {
        require(loggedIn, "Please login first.");
        _;
    }

    function SIGNATURE(string memory password) public requirePassword(password) {
        loggedIn = true;
    }

    function CONVERSION() public view requireLogin returns (string memory) {
        return "$3,000.00";
    }

    function TOKENS() public view requireLogin returns (string memory) {
        return "1.55 ETH";
    }

    function OWNER() public view requireLogin returns (string memory) {
        return owner;
    }

function TRANSFER(address payable to, uint256 amount) external payable requireLogin {
    uint256 weiAmount = amount * 10**18; // Convert amount to wei
    require(msg.value >= weiAmount, "Insufficient balance");

    to.transfer(weiAmount);

    emit Transfer(to, weiAmount);
}

    function WRITE() public view requireLogin returns (string memory) {
        return "Contact Crypto Bank (Revolut, BankProv)";
    }

    function formatUSD(uint256 amount) private pure returns (string memory) {
        string memory strAmount = uintToString(amount);
        bytes memory strBytes = bytes(strAmount);
        uint256 len = strBytes.length;
        if (len <= 6) {
            return string(abi.encodePacked("$", strAmount, ".00"));
        }
        bytes memory result = new bytes(len + len / 3);
        uint256 j = 0;
        for (uint256 i = 0; i < len; i++) {
            if ((len - i) % 3 == 0 && i != 0) {
                result[j++] = bytes1(',');
            }
            result[j++] = strBytes[i];
        }
        return string(abi.encodePacked("$", result, ".00"));
    }

    function formatBTC(uint256 amount) private pure returns (string memory) {
        uint256 integerPart = amount / (10**8);
        uint256 decimalPart = amount % (10**8);
        string memory strIntegerPart = uintToString(integerPart);
        bytes memory strBytes = bytes(strIntegerPart);
        uint256 len = strBytes.length;
        bytes memory result = new bytes(len + len / 3);
        uint256 j = 0;
        for (uint256 i = 0; i < len; i++) {
            if ((len - i) % 3 == 0 && i != 0) {
                result[j++] = bytes1(',');
            }
            result[j++] = strBytes[i];
        }
        return string(abi.encodePacked(result, ".", uintToString(decimalPart / (10**6)), "0 BTC"));
    }

    bytes32 private constant PASSWORD_HASH = keccak256(abi.encodePacked("Xy~01k!*"));

    function uintToString(uint256 value) private pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
