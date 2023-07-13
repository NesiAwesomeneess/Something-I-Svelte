<script>
    import Entry from "../lib/entry.svelte";

    let todos = [{task : "sharpen spear", id : 0, completed: false}]
    let newTask = ''

    function addTodo(){
        if (newTask){
            todos = [...todos, {task: newTask, id: crypto.randomUUID()}]
            newTask = ""
        }
    }

    function taskCompleted(){
        todos = todos.filter(({completed}) => {return !(completed)});
    }

</script>

<main>
    <h1>Todo List</h1>

    <ul class="todo-list">
        {#each todos as entry (entry.id)}
            <Entry entry={entry} 
            bind:task={entry.task}
            />
        {/each}
        <input bind:value={newTask} on:blur={addTodo}/>
        <button on:click={taskCompleted}>clear completed</button>
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