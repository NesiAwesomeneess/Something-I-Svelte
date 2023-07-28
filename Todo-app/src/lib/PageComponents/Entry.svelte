<script>
    export let completed = false
    export let id;
    export let task = "new"
    let newTask = task

    const date = new Date().toUTCString().slice(5, 16);;

    let textArea;
    $: if ((newTask.length > 0) && textArea){
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

    export let disablePointer = false;

</script>

<!-- this is a list entry essentially -->
<div class="entry">
    <input type="checkbox" class="checkbox context" bind:checked={completed}/>

    <div class="entry-wrapper">
        {#if completed}
            <span class="completed-task">
                {task}
            </span>
        {:else}
            <textarea class="entry-edit context"
            bind:this={textArea}
            bind:value={newTask}
            on:focus={() => {
                textArea.select(); 
                disablePointer = true;
            }}
            on:blur={() => {
                finishedEdit()
                disablePointer = false;
            }}

            on:keydown={(event) => {
                if (event.key === "Enter"){textArea.blur()
            }}}
            
            />
        {/if}
        
        <br/>
        <span class="entry-date">{date}</span>
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

        color: #ACACAF;
        padding: 0.25rem 0.5rem;

        background-color: #12161F;
        border-radius: 0.6rem;
        cursor: default;
    }

    .checkbox[type="checkbox"] {
        appearance: none;

        min-width: 2.25rem;
        height: 2.125rem;

        border-radius: 1.25rem 0.5rem 1.25rem 1.25rem;

        margin: 0;

        border: solid #12161F;
        border-width: 0.25rem;
        
        background-color: #2C2F3A;
        cursor: pointer;
    }

    .entry-wrapper{
        gap: 0.25em;

        padding: 0.5em; 
        min-width: calc(100% - 3.75em);
        align-items: flex-end;

        border-radius: 0.25em 0.25em 1.2em 1.2em;
        background-color: #2C2F3A;
    }

    .entry-edit {
        position: relative;
        text-align: left;
        resize: none;

        width: 100%;
        
        font-size: 1.125rem;
        line-height: 1.15em;
        height: 1.75rem;
        font-weight: 700;

        border: none;
        color: #F5F5F5;
        background: none;
    }

    .entry-edit::selection{
        background-color: #B8A3A3;
        color: #2B3039;
    }

    .entry-edit:focus-visible {
        border-style: none;
        outline-style: none;
    }

    .completed-task {
        background-color: gray;
    }

</style>