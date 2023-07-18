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
            <textarea class="entry-edit"
            on:input={(event) => {
                const input = event.target;
                input.style.height = "1.6rem";
                input.style.height = input.scrollHeight + "px"}
            }
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
    * {
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
    }

    .entry {
        display: flex;
        flex-direction: row;

        gap: 0.5rem;
        width: 100%;
    }

    .entry-date{
        font-size: 0.57143rem;
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

        padding: 0.5em;
        min-width: calc(100% - 3.5em);
        align-items: flex-end;

        border-radius: 0.25em 0.25em 1.2em 1.2em;
        background-color: #E14834;
    }

    .entry-edit {
        position: relative;
        text-align: left;
        resize: none;

        width: 100%;

        font-size: 1rem;
        line-height: 1.15em;
        height: 1.6rem;
        font-weight: 700;

        border: none;
        color: #1B1C1F;
        background: none;
    }

    .entry-edit:focus-visible {
        border-style: none;
        outline-style: none;
    }

    .completed-task {
        background-color: gray;
    }

</style>