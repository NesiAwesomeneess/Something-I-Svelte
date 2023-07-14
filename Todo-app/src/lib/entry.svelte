<script>
    export let completed = false
    export let id
    export let task = "new"
    let newTask = task

    function finishedEdit(){
        if (newTask){
            task = newTask
            return
        }
        newTask = task
        
// I just put this here because I was tired of the error
        id = id
    }

</script>

<!-- this is a list entry essentially -->
<li>
    <input type="checkbox" bind:checked={completed}/>
    {#if completed}
    <span class="completed-task">
        {task}
    </span>
    {:else}
        <input class="entry"
        bind:value={newTask}
        on:focus={(event) => event.target.select()}
        on:blur={finishedEdit}
        on:keypress={(event) => {if (event.key === "Enter"){
            finishedEdit()
        }}}/>
    {/if}


</li>

<style>


    .entry {
        font-size: 1rem;
        resize: horizontal;

        border: none;
        border-style: none;
        background-color: rgba(240, 248, 255, 0);
        padding: 2px;
    }

    .entry:focus {
        margin: 2px;
        resize: horizontal;
    }

    .completed-task {
        background-color: gray;
    }

</style>