// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoApp {
    address public admin;
    uint public taskCount;

    struct Task {
        uint id;
        string name;
        string description;
        address assignedTo;
        bool completed;
    }

    mapping(uint => Task) public tasks;

    event TaskCreated(uint id, string name, string description, address assignedTo);
    event TaskAssigned(uint id, address assignedTo);
    event TaskCompleted(uint id);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    modifier taskExists(uint _taskId) {
        require(_taskId > 0 && _taskId <= taskCount, "Task does not exist");
        _;
    }

    modifier onlyAssigned(uint _taskId) {
        require(tasks[_taskId].assignedTo == msg.sender, "You are not assigned to this task");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function createTask(string memory _name, string memory _description) external onlyAdmin {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _name, _description, address(0), false);
        emit TaskCreated(taskCount, _name, _description, address(0));
    }

    function assignTask(uint _taskId, address _assignedTo) external onlyAdmin taskExists(_taskId) {
        tasks[_taskId].assignedTo = _assignedTo;
        emit TaskAssigned(_taskId, _assignedTo);
    }

    function markTaskCompleted(uint _taskId) external onlyAssigned(_taskId) taskExists(_taskId) {
        tasks[_taskId].completed = true;
        emit TaskCompleted(_taskId);
    }
}
