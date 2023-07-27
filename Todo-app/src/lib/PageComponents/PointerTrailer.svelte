<script>
    import { spring } from 'svelte/motion';
    import RiveComponent from '../RiveComponent.svelte';
    
    let coords = spring({x: 0, y: 0}, {
        stiffness: 0.02,
        damping: 0.2
    });
    export let mousePosition = {x: 0, y: 0}
    $: {
        coords.set({x: mousePosition.x, y: mousePosition.y});
        checkContext();
    }
    
    let size = spring(24, {
        stiffness: 0.02,
        damping: 0.2
    });


    export let currentContext = "null";
    let animationInputs;

    function checkContext(){
        if (animationInputs){
            if (currentContext === "null"){
                animationInputs[0].fire()
                size.set(24);
            }
            else{
                size.set(42);
                
                switch (currentContext){
                    case "entry-input":
                        animationInputs[1].fire()
                        break;
                    case "checkbox":
                        animationInputs[2].fire()
                        break;
                    case "entry-edit":
                        animationInputs[3].fire()
                        break;
                    case "bookmark":
                        animationInputs[4].fire()
                        break;
                }
            }
        }
    }
        


</script>

<div id="trail-outline" 
    style="width: {$size + 8}px; height : {$size + 8}px;
    left: {$coords.x + ($size / 2)}px; 
    top: {$coords.y - ($size) - 10}px;">
    
    <div id="mouse-trail" 
        style="
        position: relative;
        width : {$size}px; 
        height : {$size}px;
        left: {4}px;
        top: {4}px;">

        <div style="
        position: absolute;
        padding: 0;
        top: 50%;
        left: calc(50% - 1px);
        transform: translateX(-50%) translateY(-50%);
        width: 30px; 
        height: 30px;">

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

</div>

<style>
    #trail-outline {
        position: fixed;
        z-index: 200;

        background-color: #12161F;
        border-radius: 50%;
        
        pointer-events: none;
        box-shadow: 5px 5px 5px -2px rgba(0, 0, 0, 0.094);
    }
    
    #mouse-trail {
        position: absolute;
        z-index: 0;
        
        border-radius: 50%;
        background-color: #FFAF85;
    }

</style>