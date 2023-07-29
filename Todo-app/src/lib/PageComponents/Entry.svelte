<script>
  import { fade } from 'svelte/transition';

    export let completed = false
    export let id;
    export let task = "new"
    let newTask = task

    const date = new Date().toUTCString().slice(5, 16);;

    let textArea;
    $: if ((newTask.length > 0) && textArea){
        textArea.style.height = "1.5rem";
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

    import {context, pointerEnabled} from '../pointerStore'

</script>

<!-- this is a list entry essentially -->
<input type="checkbox" 
    class:completed={completed}
    class="checkbox" 
    bind:checked={completed}

    on:click={() => context.set(completed ? "done" : "checked")}
    on:mouseenter={() => {context.set(completed ? "checked" : 'done')}}
    on:mouseleave={() => context.set('null')}
    />

<div class="entry-wrapper">
    {#if completed}
        <p class="entry-edit completed-task">{task}</p>
    {:else}
        <textarea
        class="entry-edit"
        bind:this={textArea}
        bind:value={newTask}

        on:mouseenter={() => context.set('edit')}
        on:mouseleave={() => context.set('null')}

        on:focus={() => {
            textArea.select(); 
            pointerEnabled.set(false)
        }}
        on:blur={() => {
            finishedEdit()
            pointerEnabled.set(true)
        }}

        on:keydown={(event) => {
            if (event.key === "Enter"){textArea.blur()
        }}}
        
        />
    {/if}
    
    <span class="entry-date">{date}</span>
</div>

<style>
    * {
        
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
    }

    .entry-date{
        font-size: 0.6rem;
        font-weight: 600;

        color: #ACACAF;
        padding: 0.25rem 0.5rem;

        background-color: #12161F;
        border-radius: 0.6rem;
        cursor: default;
        user-select: none;
    }

    .checkbox[type="checkbox"] {
        appearance: none;

        min-width: 2.375rem;
        height: 2.25rem;

        border-radius: 1.25rem 0.5rem 1.25rem 1.25rem;

        margin: 0;

        border: solid #12161F;
        border-width: 0.25rem;
        
        background-color: #6961C2;
        cursor: pointer;
    }

    .checkbox[type="checkbox"].completed{
        background-color: #2C2F3A;
    }

    .entry-wrapper{
        display: flex;
        flex-direction: column;
        gap: 0.25em;

        padding: 0.75em; 
        width: calc(100% - 4.25em);
        align-items: flex-start;

        border-radius: 0.25em 0.25em 1.2em 1.2em;
        background-color: #2C2F3A;
    }

    .entry-edit {
        text-align: left;
        resize: none;

        width: 100%;
        
        font-size: 1.125rem;
        line-height: 1.15em;
        height: 1.5em;
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
        text-decoration: line-through;
        text-decoration-thickness: 2px;
        color: #ACACAF;

        word-wrap: break-word;
        height: auto;
    }

</style>