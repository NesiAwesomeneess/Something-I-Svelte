<script>
    import {Alignment, Fit, Layout, Rive} from '@rive-app/canvas'
    import { onMount } from 'svelte';

    export let src;
    export let autoplay;
    export let artboard;
    export let stateMachines;
    export let riveInstance;
    export let stateMachineInputs;

    onMount(() =>{
        riveInstance = new Rive({
            src,
            autoplay,
            artboard,
            layout: new Layout({
                fit: Fit.Cover,
                alignment: Alignment.Center
            }),
            stateMachines,
            canvas : document.getElementById("canvas"),
            onLoad: () => {
                riveInstance.resizeDrawingSurfaceToCanvas();
            }
        })

        stateMachineInputs = riveInstance.stateMachineInputs(stateMachines);
    })

    
</script>

<canvas id="canvas"/>

<style>
    #canvas{
        width: 100%;
        height: 100%;
    }
</style>