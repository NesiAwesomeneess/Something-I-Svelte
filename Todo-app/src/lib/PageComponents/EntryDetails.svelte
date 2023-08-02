<script>
    import { Canvas } from "@threlte/core";
    import { slide } from 'svelte/transition';
    import { cubicOut } from 'svelte/easing';
    import { createEventDispatcher } from 'svelte';
    const dispatch = createEventDispatcher();
    
    import BackgroundLayout from "../Background/BackgroundLayout.svelte";
    import Step from "./Step.svelte";
    
    export let entry = {task: '', steps: []};

    let stepInput;
    let newStep = '';
    let placeHolder = 'Next step'

    function addStep(){
        if (newStep){
            entry.steps = [...entry.steps, {task : newStep, id : crypto.randomUUID(), completed: false}]
        }
        newStep = ''
    }

    import { context, pointerEnabled } from "../stores/pointerStore"

</script>

<div class="wrapper">
    <div class="task-title">
        <span>{entry.task}</span>
    </div>
    <div class="canvas">
        <Canvas>
            <BackgroundLayout/>
        </Canvas>
    </div>

    <div class="steps-wrapper">
        {#each entry.steps as step (step.id)}
            <div class="step" transition:slide={{duration : 200, easing: cubicOut}}>
                <Step bind:step={step}/>
            </div>
        {/each}
        
        <textarea class="step-input"
            placeholder={placeHolder}
            bind:this={stepInput}
            bind:value={newStep}
            
            on:mouseenter={() => context.set('add')}
            on:mouseleave={() => context.set('null')}

            on:focus={() => {
                newStep="";
                placeHolder=''
                pointerEnabled.set(false)
            }}

            on:blur={() => {
                addStep();
                stepInput.style.height = "1.25rem";
                placeHolder='New Task'
                pointerEnabled.set(true)
            }}
            
            on:keydown={(event) => {
                if (event.key === "Enter"){
                    event.target.blur();
                    return
                }
            }} />
    </div>
</div>

<style>
    * {
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
    }
    .wrapper{
        display: grid;

        max-width: 100%;
        border-radius: 1em;
        overflow: hidden;
    }

    .steps-wrapper{
        display: flex;
        flex-direction: column;
        gap: 0.125em;

        grid-row: 2;
        grid-column: 1;

        margin-top: 0.375em;
        width: 100%;
    }

    .step-input{
        margin: 0;
        border-style: none;
        resize: none;
        
        border-radius: 1em;
        
        font-size: 1rem;
        font-weight: 400;
        font-style: italic;
        
        height: 1.25rem;
        color: #ACACAF;
        
        width: calc(100% - 1.5em);
        padding: 0.75em;
        
        background-color: #191C24;
        z-index: 1;
        cursor: pointer;
    }

    .step-input::selection{
        caret-color: #6961C2;
        background-color: #6961C2;
        color: #ffd5e4;
    }
    
    .step-input:focus-visible {
        border-style: none;
        outline-style: none;
        
        font-style:normal;
        font-weight: 600;
        color: #F5F5F5;
    }

    .canvas{
        grid-row: 2;
        grid-column: 1;

        position: relative;
        bottom: 100%;

        height: 100vh;

        border-radius: 1em;
        max-width: 100%;
        overflow: hidden;
        z-index: -1;
    }

    .task-title{
        display: grid;
        grid-auto-flow: column;
        grid-template-columns: 0.25em;
        gap: 0.75em;

        padding: 0.75em 1em;

        background: #6961C235;
        border-radius: 1em;
        cursor: default;
        user-select: none;
    }

    .task-title::before{
        position: relative;
        content: "";
        background-color: #ffd5e4;

        border-radius: 0.25em;
        width: 100%;
        height: 100%;
    }

    .task-title span{
        color: #ffd5e4;

        width: 100%;
        font-size: 1.5rem;
        line-height: 1em;
        font-weight: 700;
    }
</style>