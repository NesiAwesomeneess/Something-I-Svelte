<script>
    import RiveComponent from "../RiveComponent.svelte";
    let animationsInputs;

</script>


<div class="bookmark">
    <button>
        <RiveComponent
            src='/bookmark.riv' 
            autoplay={false}
            artboard='BookMark'
            stateMachines='State Machine 1'
            bind:stateMachineInputs={animationsInputs}
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
        width: 36px;
        height: 64px;
    }
</style>