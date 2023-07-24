<script>
    import {OrthographicCamera, Mesh, useFrame} from '@threlte/core'
    import {Color, PlaneGeometry, ShaderMaterial, Vector2} from 'three'

    import fragmentShader from './Shaders/fragment.glsl'
    import vertexShader from './Shaders/vertex.glsl'
    import { spring } from 'svelte/motion';

    let mouseUV = spring({
        x : 0,
        y : 0
    },{
        stiffness: 0.01,
        damping: 0.2,
        precision : 0.0005
    })

    window.innerHeight
    export let mousePosition = {x: 0, y: 0}
    $: mouseUV.set({
        x: 1.0 - ((mousePosition.x * 0.6) / window.innerWidth),
        y: 1.0 - ((mousePosition.y * 0.8) / window.innerHeight)
    });


    let uniforms = {
        uColor : {value: new Color(1.0, 0.0, 0.0)},
        uTime : {value: 0.0},
        uMouseUV : {value: new Vector2()}
    }

    const planeMaterial = new ShaderMaterial({
        uniforms,
        vertexShader,
        fragmentShader
    });

    $: uniforms.uMouseUV.value = new Vector2($mouseUV.x, $mouseUV.y)

    useFrame(({ clock }) => {
        uniforms.uTime.value = clock.getElapsedTime();
    })

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