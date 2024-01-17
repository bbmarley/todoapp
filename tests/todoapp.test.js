// TodoApp.test.js
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TodoApp", function () {
  let TodoApp;
  let todoApp;
  let admin;
  let user;

  beforeEach(async function () {
    [admin, user] = await ethers.getSigners();
    TodoApp = await ethers.getContractFactory("TodoApp");
    TodoApp = await TodoApp.deploy();
    await TodoApp.deployed();
  });

  it("should create a task", async function () {
    await TodoApp.connect(admin).createTask("Task 1", "Description 1");
    const task = await TodoApp.getTask(0);

    expect(task.name).to.equal("Task 1");
    expect(task.description).to.equal("Description 1");
    expect(task.assignedTo).to.equal(ethers.constants.AddressZero);
    expect(task.completed).to.equal(false);
  });

  it("should assign a task to a user", async function () {
    await TodoApp.connect(admin).createTask("Task 1", "Description 1");
    await TodoApp.connect(admin).assignTask(0, user.address);
    const task = await TodoApp.getTask(0);

    expect(task.assignedTo).to.equal(user.address);
  });

  it("should mark a task as completed", async function () {
    await TodoApp.connect(admin).createTask("Task 1", "Description 1");
    await TodoApp.connect(admin).assignTask(0, user.address);
    await TodoApp.connect(user).markTaskCompleted(0);
    const task = await TodoApp.getTask(0);

    expect(task.completed).to.equal(true);
  });
});
