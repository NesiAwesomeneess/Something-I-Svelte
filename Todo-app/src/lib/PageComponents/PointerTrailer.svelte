<script>
    import { context, pointerEnabled, pointerPosition } from '../stores/pointerStore'
    import { spring } from 'svelte/motion';
    import RiveComponent from '../RiveComponent.svelte';
    import { onMount } from 'svelte';
    
    let coords = spring({x: 0, y: 0}, {
        stiffness: 0.02,
        damping: 0.2
    });

    function handleMouseMove({clientX, clientY}){
        pointerPosition.set({x: clientX, y: clientY});
        coords.set({x: clientX, y: clientY});
        checkContext($context, $pointerEnabled);
    }

    $: checkContext($context, $pointerEnabled)

    let animationInputs;

    let size = spring(24, {
        stiffness: 0.02,
        damping: 0.2
    });
    
    let opacity = spring(100, {
        stiffness: 0.05,
        damping: 0.2,
    })

    let animationOpacity = spring(100, {
        stiffness: 0.5,
        damping: 0.2,
    })

    function checkContext(value, enabled){
        if (!animationInputs){
            return
        }
        
        if (!enabled){
            animationInputs[0].fire()
            opacity.set(0);
            size.set(24);
            return
        }

        opacity.set(100);
        animationOpacity.set(100);
        size.set(42);

        switch (value){
            case "null":
                animationInputs[0].fire()
                size.set(24);
                animationOpacity.set(0);
                break;
            case "add":
                animationInputs[1].fire()
                break;
            case "done":
                animationInputs[2].fire()
                break;
            case "edit":
                animationInputs[3].fire()
                break;
            case "bookmark":
                animationInputs[4].fire()
                break;
            case "checked":
                animationInputs[5].fire()
                break;
            case "interact":
                break;
        }
    }

</script>

<svelte:window on:mousemove={handleMouseMove}/>

<div id="mouse-trail"
    style="
    display: grid;
    width : {$size}px; 
    height : {$size}px;
    left: {$coords.x + ($size / 2)}px;
    top: {$coords.y - ($size) - 10}px;
    opacity: {$opacity}%">

    <div style="
    width: 30px; 
    height: 30px;
    overflow: hidden;
    opacity: {$animationOpacity}%">

        <RiveComponent
            src='/icons.riv' 
            autoplay={true}
            artboard='Icons'
            stateMachines={'State Machine 1'}
            bind:riveInputs={animationInputs}
            canvasNumber=1
            />
    </div>
</div>

<div id="trail-outline" 
    style="width: {$size + 8}px; height : {$size + 8}px;
    left: {$coords.x + ($size / 2) - 4}px; 
    top: {$coords.y - 4 - ($size) - 10}px;
    opacity: {$opacity}%">
</div>

<style>
    #trail-outline {
        position: fixed;
        z-index: -1;

        background-color: #12161F;
        border-radius: 50%;
        
        pointer-events: none;
        box-shadow: 5px 5px 5px -2px rgba(0, 0, 0, 0.094);
    }
    
    #mouse-trail {
        position: fixed;
        place-content: center;
        z-index: 20;
        
        border-radius: 50%;

        background: #acacaf34;
        backdrop-filter: blur(3px);
        -webkit-backdrop-filter: blur(3px);
        box-shadow: 2px 2px 5px 0 rgba(0, 0, 0, 0.128);
    }

</style>