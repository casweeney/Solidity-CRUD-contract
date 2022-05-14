const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TodoContract", async function () {
  // Calling todo and Todo here in other to make them globally available 
  let Todo;
  let todo;
  
  // This function is called everytime before any test block is executed and that's pretty much it
  beforeEach(async function () {
    // Here we call our contract 'TodoContract' to be precise, it's the same as the name of the contract we just wrote 
    Todo = await ethers.getContractFactory("TodoContract");
    // Here the contract is deployed in a test environment
    todo = await Todo.deploy();
    await todo.deployed();
  });

  it("Should Create a todo", async function () {
    const creatTodoTx = await todo.createTodo("Morning", "Brush your teeth");
    await creatTodoTx.wait();

    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("title")
      .to.equal("Morning");
    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("description")
      .to.equal("Brush your teeth");

    const updateTodoTx = await todo.updateTodo(
      0,
      "Morning Duties",
      "Take your bath"
    );
    await updateTodoTx.wait();

    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("title")
      .to.equal("Morning Duties");
    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("description")
      .to.equal("Take your bath");

    const deleteTodoTx = await todo.deleteTodo(0);
    await deleteTodoTx.wait();

    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("title")
      .to.equal("");
    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("description")
      .to.equal("");
  });

  it("Should Update a todo", async function () {
    const creatTodoTx = await todo.createTodo("Morning", "Brush your teeth");
    await creatTodoTx.wait();

    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("title")
      .to.equal("Morning");
    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("description")
      .to.equal("Brush your teeth");

    const updateTodoTx = await todo.updateTodo(
      0,
      "Morning Duties",
      "Take your bath"
    );
    await updateTodoTx.wait();

    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("title")
      .to.equal("Morning Duties");
    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("description")
      .to.equal("Take your bath");
  });
  it("Should Delete a todo", async function () {
    const creatTodoTx = await todo.createTodo("Morning", "Brush your teeth");
    await creatTodoTx.wait();

    const deleteTodoTx = await todo.deleteTodo(0);
    await deleteTodoTx.wait();

    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("title")
      .to.equal("");
    expect(await todo.fetchTodoWithIndex(0))
      .to.have.property("description")
      .to.equal("");
  });

  it("Should Fetch a List of todos", async function () {
    const creatTodoTx = await todo.createTodo("Morning", "Brush your teeth");
    const creatTodoTx1 = await todo.createTodo("Afternoon", "Eat");
    await creatTodoTx.wait();
    await creatTodoTx1.wait();


    expect(await todo.fetchAllTodo())
      .to.have.lengthOf(2);
  });
});