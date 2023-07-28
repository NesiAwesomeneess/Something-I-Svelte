<script>
    import RiveComponent from "../RiveComponent.svelte";
    let animationInputs;
</script>


<div class="bookmark context">
    <button
    on:mouseenter={(e) => {animationInputs[0].value = true}}
    on:mouseleave={(e) => {animationInputs[0].value = false}}
    on:click={(e) => {animationInputs[1].fire()}}
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
        left: 8px;
        padding: 0;

        appearance: none;
        border: none;
        background: none;
        width: 32px;
        height: 56px;

        cursor: pointer;
    }
</style>