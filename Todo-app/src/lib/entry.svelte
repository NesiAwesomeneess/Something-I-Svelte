<script>
    export let completed = false
    export let id;
    export let task = "new"
    let newTask = task

    let textArea;

    $: if ((newTask.length > -1) && textArea){
        textArea.style.height = "1.75rem";
        textArea.style.height = textArea.scrollHeight + "px";
    }

    function finishedEdit(){
        if (newTask){
            task = newTask
            return
        }
        newTask = task
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
            bind:this={textArea}
            bind:value={newTask}
            on:focus={textArea.select()}
            on:blur={() => finishedEdit()}

            on:keydown={(event) => {
                if (event.key === "Enter"){
                    textArea.blur()
                    return
                }
            }}
            />
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

        align-self: end;

        gap: 0.5rem;
        width: 100%;
    }

    .entry-date{
        font-size: 0.6rem;
        font-weight: 600;

        color: #F4EFE0;
        padding: 0.25rem 0.5rem;

        background-color: #1B1C1F;
        border-radius: 0.6rem;
    }

    .checkbox[type="checkbox"] {
        appearance: none;

        min-width: 2.25rem;
        height: 2.125rem;

        border-radius: 1.25rem 0.5rem 1.25rem 1.25rem;

        margin: 0;

        border: solid #1B1C1F;
        border-width: 0.25rem;
        
        background-color: #E14834;
    }

    .entry-wrapper{
        gap: 0.25em;

        padding: 0.5em;
        min-width: calc(100% - 3.75em);
        align-items: flex-end;

        border-radius: 0.25em 0.25em 1.2em 1.2em;
        background-color: #E14834;
    }

    .entry-edit {
        position: relative;
        text-align: left;
        resize: none;

        width: 100%;
        
        font-size: 1.25rem;
        line-height: 1.15em;
        height: 1.75rem;
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