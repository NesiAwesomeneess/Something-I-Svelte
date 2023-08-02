<script>
    import {OrthographicCamera, Mesh, useFrame} from '@threlte/core'
    import {PlaneGeometry, ShaderMaterial} from 'three'

    import fragmentShader from './Shaders/fragment.glsl'
    import vertexShader from './Shaders/vertex.glsl'

    let uniforms = {
        uTime : {value: 0.0}
    }

    const material = new ShaderMaterial({
        uniforms,
        vertexShader,
        fragmentShader,
    });
    
</script>

<OrthographicCamera
position={{ x: 0, y: 0, z: 1 }} 
lookAt={{ x: 0, y: 0, z: 0 }}
zoom=200.0
/>

<Mesh
interactive
geometry={new PlaneGeometry(4, 4)}
material={material}
position={{y: 0.25}}
/>