// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

interface ISyntheticBotToken {
    // Views

    /**
     * @dev Given a position ID, returns the position info.
     * @param _positionID ID of the position NFT.
     * @return (uint256, uint256, uint256, uint256, uint256, uint256) total number of tokens in the position, timestamp the position was created, timestamp the rewards will end, timestamp the rewards were last updated, number of rewards per token, number of rewards per second.
     */
    function getPosition(uint256 _positionID) external view returns (uint256, uint256, uint256, uint256, uint256, uint256);

    /**
     * @dev Returns the latest timestamp to use when calculating available rewards.
     * @param _positionID ID of the position NFT.
     * @return (uint256) The latest timestamp to use for rewards calculations.
     */
    function lastTimeRewardApplicable(uint256 _positionID) external view returns (uint256);

    /**
     * @dev Returns the number of rewards available per token for the given position.
     * @param _positionID ID of the position NFT.
     * @return (uint256) Number of rewards per token.
     */
    function rewardPerToken(uint256 _positionID) external view returns (uint256);

    /**
     * @dev Returns the amount of rewards the user has earned for the given position.
     * @param _account Address of the user.
     * @param _positionID ID of the position NFT.
     * @return (uint256) Amount of rewards earned
     */
    function earned(address _account, uint256 _positionID) external view returns (uint256);

    // Mutative

    /**
     * @dev Mints synthetic bot tokens.
     * @param _numberOfTokens Number of synthetic bot tokens to mint.
     */
    function mintTokens(uint256 _numberOfTokens) external;

    /**
     * @dev Claims available rewards for the given position.
     * @notice Only the position owner can call this function.
     * @param _positionID ID of the position NFT.
     */
    function claimRewards(uint256 _positionID) external;
}