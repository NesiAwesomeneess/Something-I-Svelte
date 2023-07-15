<script>
    import Entry from "../lib/entry.svelte";
    import PointerTrailer from "../lib/pointerTrailer.svelte";

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

<body class="page-container">
    <h1>Plans</h1>
    

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

    h1{
        margin: 20px;
        color: rgb(255, 255, 255);
    }

    .todo-list {
        display: grid;
        flex-direction: column;
        gap: 4px;

        justify-self: center;
        align-self: center;

        /* padding: 30px;
        border-radius: 20px;
        background-color: rgb(52, 52, 51) */
    }

    .entry-input {
        border: solid;
        border-radius: 20px;
        border-width: 1.4px;

        justify-self: center;

        min-height: 30px;
        width: 200px;
        padding: 5px 20px;

        background-color: wheat;
    }

    .page-container {
        display: grid;
        grid-template-rows: 1fr 400px 1fr;

        position: absolute;
        margin: 0;

        height: 100vh;
        width: 100vw;
        background-color: rgb(0, 0, 0);
    }
    
</style>