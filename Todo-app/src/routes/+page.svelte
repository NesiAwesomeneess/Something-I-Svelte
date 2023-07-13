<script>
    import Entry from "../lib/entry.svelte";
    let todos = [{todo : "sharpen spear", id : 0}, {todo: "find food", id : 1}]
    let newTodo = ''

    function addTodo(){
        if (newTodo){
            todos = [...todos, {todo: newTodo, id: crypto.randomUUID()}]
            newTodo = ""
        }
    }

    function completedTodo(entry){
        todos = todos.filter(({id}) => {return entry.id !== id })
    }

</script>

<main>
    <h1>Todo List</h1>

    <ul class="todo-list">
        {#each todos as item (item.id)}
            <Entry todo={item.todo}/>
        {/each}
        <input bind:value={newTodo} on:blur={addTodo}/>
    </ul>

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
    
</style>