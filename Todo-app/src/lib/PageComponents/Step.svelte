<script>
    export let step = {task: '', completed: false}
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

    .step-wrapper{
        background-color: #2C2F3A;
        border-radius: 0.75em;

        height: calc(100% - 0.75em);
        padding: 0.25em 0.75em;
    }

    .step-edit {
        text-align: left;
        resize: none;

        width: 100%;
        
        font-size: 1rem;
        height: 100%;
        font-weight: 600;

        border: none;
        color: #F5F5F5;
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

    
</style>