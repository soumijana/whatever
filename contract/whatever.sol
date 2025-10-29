// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GameLedger {
    struct Player {
        string name;
        uint256 score;
        bool exists;
    }

    mapping(address => Player) public players;

    event PlayerRegistered(address indexed player, string name);
    event ScoreUpdated(address indexed player, uint256 newScore);

    function registerPlayer(string memory _name) public {
        require(!players[msg.sender].exists, "Player already registered");
        players[msg.sender] = Player(_name, 0, true);
        emit PlayerRegistered(msg.sender, _name);
    }

    function updateScore(uint256 _newScore) public {
        require(players[msg.sender].exists, "Player not registered");
        players[msg.sender].score = _newScore;
        emit ScoreUpdated(msg.sender, _newScore);
    }

    function getPlayer(address _playerAddress) public view returns (string memory, uint256) {
        require(players[_playerAddress].exists, "Player not found");
        Player memory p = players[_playerAddress];
        return (p.name, p.score);
    }
}

