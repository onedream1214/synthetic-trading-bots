// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

//OpenZeppelin
import "../openzeppelin-solidity/contracts/Ownable.sol";

// Interfaces
import '../interfaces/IUbeswapAdapter.sol';

//Inheritance
import '../interfaces/IBackupMode.sol';

contract BackupMode is IBackupMode, Ownable {
    bool public override useBackup;
    uint256 public override startTime;
    uint256 public override priceOfTGEN;

    IUbeswapAdapter public immutable ubeswapAdapter;
    address public immutable TGEN;

    constructor(address _ubeswapAdapter, address _TGEN) Ownable() {
        ubeswapAdapter = IUbeswapAdapter(_ubeswapAdapter);
        TGEN = _TGEN;

        useBackup = false;
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    /**
    * @dev Turns on backup mode.
    * @notice Only the contract owner can call this function.
    * @notice When backup mode is on, minting will be paused for synthetic bot tokens.
    * @notice Users can withdraw their cost basis in TGEN from the escrow contract.
    * @notice Backup mode will only be turned on if the majority of users want to exit their synthetic bot token positions and are unable to do so through the marketplace.
    */
    function turnOnBackupMode() external override onlyOwner {
        require(!useBackup, "BackupMode: already using backup mode.");

        useBackup = true;
        startTime = block.timestamp;
        priceOfTGEN = ubeswapAdapter.getPrice(TGEN);

        emit TurnedOnBackupMode();
    }

    /* ========== EVENTS ========== */

    event TurnedOnBackupMode();
}