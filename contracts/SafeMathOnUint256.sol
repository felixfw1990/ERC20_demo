// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

/**
* @title safe math on uint256.
* @dev use addition subtraction multiplication division and mod.
*/
library SafeMathOnUint256 {

    // ------------------------------------------------------------------------------

    function add(uint256 a, uint256 b) internal pure returns (uint256){
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    // ------------------------------------------------------------------------------

    function sub(uint256 a, uint256 b) internal pure returns (uint256){
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    // ------------------------------------------------------------------------------

    function mul(uint256 a, uint256 b) internal pure returns (uint256){
        // about cheaper gas
        if (a == 0)
            return 0;

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    // ------------------------------------------------------------------------------

    function div(uint256 a, uint256 b) internal pure returns (uint256){
        require(b > 0); // Solidity only automatically asserts when dividing by 0

        uint256 c = a / b;

        return c;
    }

    // ------------------------------------------------------------------------------

    function mod(uint256 a, uint256 b) internal pure returns (uint256){
        require(b != 0);

        uint256 c = a % b;

        return c;
    }

    // ------------------------------------------------------------------------------
}
