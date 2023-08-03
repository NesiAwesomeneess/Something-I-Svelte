<script>
    export let step;
    let newStep = step.task

    let textArea;
    $: if ((newStep.length > 0) && textArea){
        resize()
    }

    function resize(){
        textArea.style.height = "1.5rem";
        textArea.style.height = textArea.scrollHeight + "px";
    }

    function finishedEdit(){
        if (newStep){
            step.task = newStep
            return
        }
        newStep = step.task
    }

    import {context, pointerEnabled} from '../stores/pointerStore'

</script>

<input type="checkbox"
class:completed={step.completed}
class="checkbox"
bind:checked={step.completed}

on:click={() => context.set(step.completed ? "done" : "checked")}
on:mouseenter={() => {context.set(step.completed ? "checked" : 'done')}}
on:mouseleave={() => context.set('null')}
/>

<div class="step-wrapper">
    {#if step.completed}
        <p class="step-edit completed-task">{step.task}</p>
    {:else}
        <textarea
        spellcheck="false"
        class="step-edit"

        bind:this={textArea}
        bind:value={newStep}

        on:mouseenter={() => context.set('edit')}
        on:mouseleave={() => context.set('null')}

        on:focus={() => {
            textArea.select(); 
            pointerEnabled.set(false)
            resize()
        }}
        on:blur={() => {
            finishedEdit()
            pointerEnabled.set(true)
        }}

        on:keydown={(event) => {
            if (event.key === "Enter"){textArea.blur()}}}
        />
    {/if}
</div>

<style>
    * {
        margin: 0;
        padding: 0;
        font-family: 'Montserrat';
    }

    .checkbox[type="checkbox"] {
        align-self: center;
        appearance: none;

        min-width: 1.75rem;
        height: 1.75rem;

        border-radius: 0.5rem 0.5rem 0.5rem 0.5rem;

        margin: 0;
        
        background-color: #2C2F3A;
        cursor: pointer;
    }

    .checkbox[type="checkbox"].completed{
        background-color: #12161f;
    }

    .step-wrapper{
        display: grid;
        grid-auto-flow: row;

        justify-self: center;
        padding: 0.5em 0.5em;
        margin-top: 0.25em;
        width: 100%;
    }

    .step-wrapper::after{
        position: relative;
        content: "";

        top: 0.5em;

        height: 2px;
        width: 100%;
        background: #2B3039;
    }

    .step-edit {
        text-align: left;
        resize: none;

        width: calc(100% - 1.25em);

        margin-left: 0.5em;
        
        font-size: 1rem;
        height: 100%;
        font-weight: 600;

        border: none;
        color: #ACACAF;
        background: none;
    }

    .step-edit::selection{
        background-color: #ffd5e4;
        color: #2B3039;
    }

    .step-edit:focus-visible {
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