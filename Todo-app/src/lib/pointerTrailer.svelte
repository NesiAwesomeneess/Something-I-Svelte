<script>
    import { spring } from 'svelte/motion';
    
    let coords = spring({x: 0, y: 0}, {
		stiffness: 0.02,
		damping: 0.2
    })

    export let mousePosition = {x: 0, y: 0}
    $: coords.set({x: mousePosition.x, y: mousePosition.y})

    let size = 30

</script>

<div id="mouse-trail" style="width: {size + 8}px; height : {size + 8}px;
left: {$coords.x + (size / 2)}px; 
top: {$coords.y - (size)}px;">

<div id="trail-outline" style="width:{size}px; height : {size}px;
left: {4}px; 
top: {4}px;">

</div></div>

<style>
    #mouse-trail {
        position: fixed;
        z-index: 200;

        background-color: #1B1C1F;
        border-radius: 50%;
        
        pointer-events: none;
        box-shadow: 5px 5px 5px -2px rgba(0, 0, 0, 0.094);
    }
    
    #trail-outline {
        position: absolute;
        z-index: -1;
        
        border-radius: 50%;
        background-color: #F4EFE0;
    }

</style>