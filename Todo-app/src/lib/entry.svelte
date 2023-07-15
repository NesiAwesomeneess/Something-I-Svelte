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
<div class="entry">
    <input type="checkbox" class="checkbox" bind:checked={completed}/>

    {#if completed}
        <span class="completed-task">
            {task}
        </span>
    {:else}
        <input class="entry-edit"
        bind:value={newTask}
        on:focus={(event) => event.target.select()}
        on:blur={finishedEdit}
        on:keypress={(event) => {if (event.key === "Enter"){
            finishedEdit()
        }}}/>
    {/if}

</div>

<style>
    .entry {
        display: flex;
        flex-direction: row;

        border-radius: 20px;
        background-color: rgb(223, 139, 112);

    }

    .checkbox[type="checkbox"] {
        appearance: none;

        position: relative;
        display: grid;

        place-content: center;

        width: 16px;
        height: 16px;

        left: 6px;

        border-radius: 50%;

        background-color: rgba(255, 255, 255, 0.12);
        align-self: center;
    }

    .checkbox[type="checkbox"]::before{
        content: "";

        width: 24px;
        height: 24px;

        border: 2px solid rgba(255, 255, 255, 0.12);
        border-radius: 50%;
        
    }


    .entry-edit {
        position: relative;
        
        font-size: 1rem;
        font-weight: 600;
        resize: vertical;

        
        min-height: 30px;
        width: 200px;
        padding: 5px 20px;
        
        border: none;
        background-color: rgba(255, 255, 255, 0);
    }

    .entry-edit:focus-visible {
        resize: horizontal;

        border-style: none;
        outline-style: none;
    }

    .completed-task {
        background-color: gray;
    }

</style>