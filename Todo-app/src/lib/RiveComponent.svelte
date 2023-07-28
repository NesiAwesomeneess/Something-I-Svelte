<script>
    import { Alignment, Fit, Layout, Rive } from '@rive-app/canvas'
    import { onMount } from 'svelte';

    export let src;
    export let autoplay;
    export let artboard;
    export let stateMachines;
    export let riveInstance;
    export let riveInputs;
    export let canvasNumber = 0;

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
            canvas : document.getElementById(canvasNumber+""),
            onLoad: () => {
                riveInstance.resizeDrawingSurfaceToCanvas();
                riveInputs = riveInstance.stateMachineInputs(stateMachines);
            }
        })
    })

    
</script>

<canvas id="{canvasNumber}" style="width: 100%; height: 100%;"/>

