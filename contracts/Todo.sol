// SPDX-License-Identifier: MIT

/***
// This tells the compiler what version of solidity you are using and in this case we are using 0.8.1,
// as for the '^' it is basically saying you can use higher versions, if you wanted too, you could easily do
// pragma solidity 0.8.1 
// and this will tell the compiler that you strictly want to use only 0.8.1
*/
 pragma solidity ^0.8.1;
 
 /**
 // Now 'contract' is the same thing as declaring 'class' (you can mess around with it and you'll see that it really checks all the boxes for a class)
 */

  contract TodoContract{
  
    /**
    // Now remember how we already established that a 'TODO' should have a 'title' and 'description'
    // A 'struct' is a way to pair up a bunch of related variables instead of declaring them everytime over and over again
    // So our 'struct' is holding the 2 variables that we need 'title' and 'description' as we go down you see how to use this
    */

    struct Todo{
        string  title;
        string  description;
    }

    /**
    // So we'll be creating a list of To-Do's we need to create a 'state' variable, that will be an un-initialized list of todo's
    // A state variable is basically a variable that is registered on the blockchain forever, so a record of it is kept on the blockchain
    // state variables are also created in the class like your 'instance variables' (you can google.com what it means too :)).
    // There are local variables too, and this are the ones that you see within functions and these ones are ephemeral (the don't last too long),
    // They are also never recorded on the blockchain too.
    // If you are wondering why they are called 'state variables', well that answer is simple, the EVM(it compiles your ethereum code),
    // is a state machine so it handes states (states help us know what to register to the block).
    // So to indicate that something is going to be a list we use '[]' and that way we have said something similar to 'List<Todo>' or List<int> e.t.c you get the point now
    */
    
    Todo [] public todos;
      
    /**
    // Now as we go further down, you'll see things like 'storage' and 'memory'
    // 'memory' is used to indicate that this is 'ephemeral', so it is used with local variables.
    // 'storage' is used to indicate that this is a 'not ephemeral', so it is used with state variables.
    */


    // I am thinking this functions name gives it away already, it's a 'createTodo' function and it just take two paramenters
    // It also returns nothing too so we just use only the 'public' function modifier (explaining it is outside the scope of this article :))
    // A fuction modifier is just code that states how the function should behave.
    // PS: There are so many function modifiers in solidity but I'll try to focus on the ones in this article, 
    // but you could do your futher readings on others

    function createTodo(string memory _title, string memory _description) public{
        // Just like list in  some programming languages, we use the 'push' method to create a new entry to a list 
        // remember that 'todos' is a state variable so yes this is added straight to the blockchain (in simpler terms it has been saved).
        todos.push(Todo({title: _title, description: _description}));
    }
      
    //This function fetches a single todo based on it's index  
    function fetchTodoWithIndex(uint _index) public view returns (string memory title, string memory description){
        // view function modifier lets the EVM know that the function does not modify any varibles 
        // returns function modifier, lets the EVM know that the function would have to rerurn something and in this case 
        // we are returning 'title' and 'description', the arguments '(string memory title, string memory description)'
        // it allows the function know the types that it's expected to return, so in this case we have 2 strings
    
        Todo storage todo = todos[_index];
        
        // notice how we are returning the 'title' and 'description',
        // we did not return only one but 2 because of the 'returns' function modifier
        // well if you wanted to return a third parameter, just add it (but then again do you think this is the best? :))
    
        return(todo.title, todo.description);
    }
      
    // this is very similar to the createTodo function 
    function updateTodo(uint _index, string memory _title, string memory _description ) public {
        Todo storage todo = todos[_index];
        todo.title = _title;
        todo.description = _description;
    }
     
    // so here notice how many arguments are in the 'returns' function modifier 
    // notice how many things the 'return' statment is returning and the type it is returning too
    function fetchAllTodo() public view returns (Todo[] memory){
        return todos;
    }
      
    //this is the last function that deletes a todo from the list with it's index 
    // yeah I noticed too, it's too convenient ;)
    function deleteTodo(uint _index) public{
        delete todos[_index];
    }
 }