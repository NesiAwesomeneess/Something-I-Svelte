<script>
    let todos = [{todo : "wash car", id : 0}, {todo: "find food", id : 1}]
    let newTodo = ''

    function addTodo(){
        todos = [...todos, {todo: newTodo, id: crypto.randomUUID()}]
        newTodo = ""
    }

    function completedTodo(entry){
        todos = todos.filter(({id}) => {return entry.id !== id })
    }

</script>

<main>
    <h1>Todo List</h1>

    <ul class="todo-list">
        {#each todos as item (item.id)}
        <li><input 
            type="checkbox" 
            on:click={completedTodo(item)}/> {item.todo} </li>
        {/each}
        <input bind:value={newTodo}/>

    </ul>

    <button class="add-button" on:click={addTodo}> Add Entry</button>

</main>

<style>
    * {
        font-family: Arial, Helvetica, sans-serif;
    }

    h1{
        margin: 20px;
    }

    .todo-list{
        list-style: none;
    }

    .add-button {
        margin-top: 10px;
    }
    
</style>