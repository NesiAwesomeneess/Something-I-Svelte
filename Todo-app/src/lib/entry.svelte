<script>
    export let todo = 'new'
    let beingEditted = false

    function initialEntryEdit(){
        beingEditted = true

    }

</script>

<!-- this is a list entry essentially -->
<li>
    <input type="checkbox"/>
    {#if beingEditted}
        <input class="edit-entry"
        bind:value={todo}
        on:blur={beingEditted = !beingEditted}/>
    {:else}
        <button class="entry" 
        on:click={initialEntryEdit}>
        {todo}
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