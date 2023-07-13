<script>
    import {createEventDispatcher} from 'svelte'

    const dispatcher = createEventDispatcher()

    export let entry = {task: "new", id: 0, completed: false}
    export let task = entry.task
    let editing = false

    function initialEntryEdit(){
        editing = true
    }

    function finishEntryEdit(){
        editing = false
        dispatcher("edit", {entry: entry})
    }

</script>

<!-- this is a list entry essentially -->
<li>
    <input type="checkbox" bind:checked={entry.completed}/>
    {#if editing}
        <input class="edit-entry"
        bind:value={task}
        on:blur={finishEntryEdit}/>
    {:else}
        <button class="entry" 
        on:click={initialEntryEdit}>
        {entry.task}
        </button>
    {/if}
</li>

<style>
    .edit-entry {
        position: absolute;
    }

    .entry {
        font-size: 1rem;

        border-style: none;
        background-color: rgba(240, 248, 255, 0);
        padding: 2px;
    }
</style>