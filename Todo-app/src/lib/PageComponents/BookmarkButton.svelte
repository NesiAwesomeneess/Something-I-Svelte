<script>
    import { createEventDispatcher } from "svelte";
    import RiveComponent from "../RiveComponent.svelte";
    import { context } from "../stores/pointerStore";
    let animationInputs;

    const clicked = createEventDispatcher()
</script>


<div class="bookmark">
    <button
    on:mouseenter={(e) => {
        animationInputs[0].value = true
        context.set("bookmark")}}
    on:mouseleave={(e) => {
        animationInputs[0].value = false
        context.set("null")}}
    on:click={(e) => {
        animationInputs[1].fire()
        clicked('clicked')
        }}

    >
        <RiveComponent
            src='/bookmark.riv' 
            autoplay={true}
            artboard='BookMark'
            stateMachines={'State Machine 1'}
            bind:riveInputs={animationInputs}
            />
    </button>
</div>

<style>
    .bookmark{
        position: absolute;
        width: 0;
        height: 0;
    }
    
    .bookmark button{
        position: relative;

        top: 8px;
        left: 12px;
        padding: 0;

        appearance: none;
        border: none;
        background: none;
        width: 32px;
        height: 56px;

        cursor: pointer;
    }
</style>