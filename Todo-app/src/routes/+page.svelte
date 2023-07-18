<script>
    import Entry from "../lib/entry.svelte";
    import PointerTrailer from "../lib/pointerTrailer.svelte";

    let todos = [{task : "sharpen spear", id : 0, completed: false}]
    let newTask = 'New Task?'

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

<body class="page-container">
    <div class="todo-list">
        {#each todos as entry (entry.id)}
            <Entry id={entry.id} 
            bind:task={entry.task}
            bind:completed={entry.completed}/>
        {/each}
        
        <input class="entry-input"
        bind:value={newTask} 
        on:blur={addTodo} 
        on:keypress={(event) => {if (event.key === "Enter"){
            addTodo()
        }}}/>
    
        <!-- <button on:click={taskCompleted}>clear completed</button> -->
    </div>
    
</body>

<PointerTrailer/>

<style>
    * {
        margin: 0;
        padding: 0;
    }

    .todo-list {
        display: grid;
        grid-auto-flow: row;

        gap: 4px;

        justify-self: center;
        align-self: center;

        justify-content: end;
        align-content: end;

        width: 312px;
        height: 360px;

        padding: 4px;
        border-radius: 28px;
        background-color: #1B1C1F
    }

    .entry-input {
        border: none;
        border-radius: 8px 8px 24px 24px;

        justify-self: end;

        font-size: 16px;
        color: #1B1C1F;

        min-width: 280px;
        padding: 8px 16px;

        background-color: #2B3039;
    }

    .page-container {
        display: grid;

        position: absolute;
        margin: 0;

        height: 100vh;
        width: 100vw;
        background-color: #2B3039;
    }
    
</style>