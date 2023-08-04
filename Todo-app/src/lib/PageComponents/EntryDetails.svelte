<script>
    import { Canvas } from "@threlte/core";
    import { slide } from 'svelte/transition';
    import { cubicOut } from 'svelte/easing';
    
    import BackgroundLayout from "../Background/BackgroundLayout.svelte";
    import Step from "./Step.svelte";
    
    export let entry;
    
    let stepInput;
    $: resize(newStep.length)

    function resize(){
        if (!stepInput){
            return
        }

        stepInput.style.height = "1.25rem";
        stepInput.style.height = stepInput.scrollHeight - 24 + "px";
    }

    let newStep = '';
    let placeHolder = 'Next Step'

    function addStep(){
        if (newStep){
            entry.steps = [...entry.steps, {task : newStep, id : crypto.randomUUID(), completed: false}]
        }
        newStep = ''
    }

    import { context, pointerEnabled } from "../stores/pointerStore"
    import { entryMode } from "../stores/pageStore";

</script>

<div class="wrapper">
    <div class="task-title">
        <button class="backbutton"
        on:click={() => entryMode.set(true)}></button>
        <span>{entry.task}</span>
    </div>
    <div class="canvas-container">
        <div class="canvas">
            <Canvas>
                <BackgroundLayout/>
            </Canvas>
        </div>
    </div>

    <div class="entry-steps-container">
        <div class="steps-container">
            {#each entry.steps as step (step.id)}
                <div class="step" transition:slide={{duration : 200, easing: cubicOut}}>
                    <Step bind:step={step}/>
                </div>
            {/each}
            
            <div class="step-input-wrapper">
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
                        placeHolder='New Step'
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
    </div>
</div>

<style>
    * {
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
    }

    .wrapper{
        position: relative;
        display: grid;
        grid-template-columns: 100%;

        border-radius: 1em;
        overflow: hidden;
    }

    .step{
        display: flex;
    }

    .steps-container{
        position: relative;
        display: flex;
        flex-direction: column;
        
        width: 100%;

        padding-left: 0.75em;
        padding-top: 0.25em;
        margin-left: 0.25em;

        align-self: start;

        background-color: #191C24;
        border-radius: 0.5em;
        overflow: hidden;
    }

    .entry-steps-container{
        display: flex;
        flex-direction: column;

        align-items: center;

        grid-row: 2;
        grid-column: 1;

        margin-top: 0.5em;
        width: 100%;
    }

    .step-input-wrapper{
        display: grid;
        grid-auto-flow: row;
    }

    .step-input-wrapper::before{
        position: relative;
        content: '';
        justify-content: center;
        
        background-color: #2B3039;
        top: -2px;
        height: 2px;
        width: 100%;
    }

    .step-input{
        margin: 0;
        border-style: none;
        resize: none;
        
        font-size: 1rem;
        font-weight: 400;
        font-style: italic;
        
        width: calc(100% - 4.5em);
        height: 1.25rem;
        color: #ACACAF;
        
        padding: 0.75em 0;

        background: none;
        z-index: 1;
        cursor: pointer;
    }

    .step-input::selection{
        caret-color: #6961C2;
        background-color: #6961C2;
        color: #ffd5e4;
        cursor: text;
    }
    
    .step-input:focus-visible {
        border-style: none;
        outline-style: none;
        
        font-style:normal;
        font-weight: 600;
        color: #F5F5F5;
        cursor: text;
    }

    /* Title card. */

    .canvas-container{
        display: flex;
        grid-row: 2;
        grid-column: 1;

        position: relative;
        bottom: 100%;
        
        height: 100%;
        border-radius: 1em;
        max-width: 100%;
        overflow: hidden;
        z-index: -1;
    }

    .canvas{
        width: 100%;
        align-self: flex-end;
    }

    .task-title{
        display: grid;
        grid-auto-flow: column;
        grid-template-columns: 0.25em;
        gap: 1.5em;

        padding: 0.75em 1em;

        background: #6961C235;
        border-radius: 1em;
        cursor: default;
        user-select: none;
        width: auto;
    }

    .backbutton{
        appearance: none;
        border: none;
        
        align-self: center;
        justify-self: center;

        background-color: #12161ffa;

        border-radius: 0.5em;
        width: 100%;
        height: 24px;
    }

    .task-title span{
        color: #ffd5e4;

        width: 100%;
        font-size: 1.5rem;
        line-height: 1em;
        font-weight: 700;
    }

    @media (max-width: 690px){
        .task-title{
            grid-template-columns: 1.75em;
            gap: 1em;
            padding: 1em;
        }

        .backbutton{
            height: 28px;
        }

    }

</style>