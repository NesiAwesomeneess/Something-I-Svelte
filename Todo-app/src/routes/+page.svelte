<script>
    import Entry from "../lib/entry.svelte";

    let todos = [{task : "sharpen spear", id : 0, completed: false}]
    let newTask = ''

    let mouseX = 0
    let mouseY = 0

    function addTodo(){
        if (newTask){
            todos = [...todos, {task: newTask, id: crypto.randomUUID()}]
            newTask = ""
        }
    }

    function taskCompleted(){
        todos = todos.filter(({completed}) => {return !(completed)});
    }

    window.onmousemove = e => {
        mouseX = e.clientX
        mouseY = e.clientY
    }


</script>

<main>
    <h1>Todo List</h1>

    <ul class="todo-list">
        {#each todos as entry (entry.id)}
            <Entry id={entry.id} 
            bind:task={entry.task}
            bind:completed={entry.completed}/>
        {/each}

        <input 
        bind:value={newTask} 
        on:blur={addTodo} 
        on:keypress={(event) => {if (event.key === "Enter"){
            addTodo()
        }}}/>

        <button on:click={taskCompleted}>clear completed</button>
    </ul>

    <div class="mouse-trail" x="{mouseX}px"></div>

</main>

<style>

    h1{
        margin: 20px;
    }

    .todo-list{
        list-style: none;
    }

    .mouse-trail {
        position: fixed;
        left: var(x);
        top: 0px;
        z-index: 200;

        background-color: rgb(53, 52, 52);

        width: 40px;
        height: 40px;
        border-radius: 50%;

        pointer-events: none;

    }
    
</style>