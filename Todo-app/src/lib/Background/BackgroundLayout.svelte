<script>
    import {OrthographicCamera, Mesh, useFrame} from '@threlte/core'
    import {PlaneGeometry, ShaderMaterial, Vector2} from 'three'

    import fragmentShader from './Shaders/fragment.glsl'
    import vertexShader from './Shaders/vertex.glsl'
    import { spring } from 'svelte/motion';

    export let mousePosition = new Vector2();
    let mouseUV = spring(mousePosition,{
        stiffness: 0.01,
        damping: 0.2,
        precision : 0.0005
    })

    let uniforms = {
        uTime : {value: 0.0},
        uMouseUV : {value: mouseUV}
    }

    const planeMaterial = new ShaderMaterial({
        uniforms,
        vertexShader,
        fragmentShader
    });

    
    useFrame(({ clock }) => {
        uniforms.uTime.value = clock.getElapsedTime();
        mouseUV.set(new Vector2(
            1.0 - ((mousePosition.x * 0.6) / window.innerWidth),
            1.0 - ((mousePosition.y * 0.8) / window.innerHeight)
            ));
        })
        
    $: uniforms.uMouseUV.value = $mouseUV;
    
</script>

<OrthographicCamera
position={{ x: 0, y: 0, z: 1 }} 
lookAt={{ x: 0, y: 0, z: 0 }}
zoom=200.0
/>

<Mesh
interactive
geometry={new PlaneGeometry(9, 8)}
material={planeMaterial}
on:pointermove={(event) => mouseUV.set(
    {x: event.detail.uv.x , y : event.detail.uv.y}
)}

/>