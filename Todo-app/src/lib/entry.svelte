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

    <div class="entry-wrapper">
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
        
        <br/>
        <span class="entry-date"> Mon 12 12 2012</span>
    </div>


</div>

<style>
    .entry {
        display: flex;
        flex-direction: row;

        gap: 8px;
    }

    .entry-date{
        font-size: 8px;
        font-weight: 600;

        color: #F4EFE0;
        padding: 4px 8px;

        background-color: #1B1C1F;
        border-radius: 8px;
    }

    .checkbox[type="checkbox"] {
        appearance: none;

        width: 34px;
        height: 32px;

        border-radius: 24px 8px 24px 24px;

        margin: 0;

        border: solid #1B1C1F;
        border-width: 4px;
        
        background-color: #E14834;
    }

    .entry-wrapper{
        gap: 4px;

        padding: 8px 16px;
        
        min-width: 280px;
        border-radius: 4px 4px 20px 20px;
        background-color: #E14834;
    }

    .entry-edit {
        position: relative;
        text-align: left;

        font-size: 16px;
        font-weight: 600;

        border: none;
        color: #1B1C1F;
        background: none;
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