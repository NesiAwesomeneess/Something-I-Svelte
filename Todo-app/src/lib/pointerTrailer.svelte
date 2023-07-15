<script>
    import { spring } from 'svelte/motion';
    import { onMount } from 'svelte';

    let coords = spring({x: 0, y: 0}, {
		stiffness: 0.02,
		damping: 0.2
    })

    let size = 40

    onMount(() => {
        onmousemove = e => {
            coords.set({ x: e.clientX, y: e.clientY});
            console.log(e.target);
        }
    })

</script>

<div 
id="mouse-trail" 
style="width: {size}px; height : {size}px;
left: {$coords.x + (size / 2)}px; 
top: {$coords.y - (size)}px;"></div>


<style>
    #mouse-trail {
        position: fixed;
        z-index: 200;

        background-color: rgb(255, 255, 255);
        border-radius: 50%;

        pointer-events: none;
        box-shadow: 5px 5px 5px -2px rgba(0, 0, 0, 0.094);
    }

</style>