<script>
    import {Canvas} from '@threlte/core'

    import BackgroundLayout from '../lib/Background/BackgroundLayout.svelte';
    import ContainerDecoration from "../lib/ContainDecoration/ContainerDecoration.svelte";
    
    import Entry from "../lib/PageComponents/Entry.svelte";
    import PointerTrailer from "../lib/PageComponents/PointerTrailer.svelte";
    import BookmarkButton from '../lib/PageComponents/BookmarkButton.svelte';

    let todos = [{task : "Sharpen spear.", id : 0, completed: false}]
    let newTask = 'New Task?'

    let mousePosition = {x: 0, y: 0}
    let taskInput;

    $: if ((newTask.length > -1) && taskInput){
        taskInput.style.height = "1.5rem";
        taskInput.style.height = taskInput.scrollHeight - 8 + "px";
    }

    function addTodo(){
        if (newTask){
            todos = [...todos, {task: newTask, id : crypto.randomUUID()}]
        }

        newTask = "New Task?"
    }

    // function taskCompleted(){
    //     todos = todos.filter(({completed}) => {return !(completed)});
    // }

    let currentContext = "null";

</script>

<main class="page"

on:mousemove={(e) => {
    const onContext = e.target.closest(".context") !== null;
    if (onContext){
        currentContext = e.target.closest(".context").classList[0];
    }
    else{
        currentContext = "null";
    }
    
    mousePosition.x = Math.max(0.0, e.clientX); 
    mousePosition.y = Math.max(0.0, e.clientY);
}}>
    
    <div class="content-wrapper">
        <div class="todo-list">
            <div class="entries-wrapper">
                {#each todos as entry (entry.id)}
                <Entry id={entry.id} 
                bind:task={entry.task}
                bind:completed={entry.completed}/>
                {/each}
            </div>
            
            <textarea 

                class="entry-input context"
                bind:this={taskInput}
                bind:value={newTask}
                
                on:focus={() => newTask=""}
                on:blur={() => addTodo()}
                
                on:keydown={(event) => {
                    if (event.key === "Enter"){
                        event.target.blur();
                        return
                    }
                }}

            />
            
            <BookmarkButton/>
        </div>
        
        <div class="decoration-frame">
            <Canvas>
                <ContainerDecoration/>
            </Canvas>
        </div>
        
        <div class="detail-wrapper">
        </div>
    </div>
    
    <div class="background">
        <Canvas>
            <BackgroundLayout 
                bind:mousePosition={mousePosition}
                />
        </Canvas>
    </div>

    <PointerTrailer 
        bind:mousePosition={mousePosition}
        bind:currentContext={currentContext}
        />

</main>

<style>
    * {
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
    }

    .background{
        position: absolute;
        width: 100%;
        height: 100%;

        z-index: -1;
    }
    
    .page {
        position: relative;
        display: grid;
        place-items: center;
    
        margin: 0;
    
        height: 100vh;
        width: 100vw;
        overflow: hidden;
    }

    .content-wrapper{
        position: relative;
        top: -1em;

        display: grid;
        gap: 0.25em 0.75em;
        grid-template-columns: minmax(24em, 2fr) minmax(15em, 1.2fr);
        grid-template-rows: minmax(100%, 30em);
        grid-template-areas: "todo";

        width: 80%;

        max-height: 40em;
        height: 75%;

        place-content: center;
    }

    .detail-wrapper{
        display: flex;

        max-width: 22em;
        width: 100%;
        height: 100%;

        padding: 0.25em;

        border-radius: 1.5em;
        background-color: #12161F;
        box-shadow: 5px 5px 10px -2px rgba(20, 20, 20, 0.345);

    }

    .detail-wrapper::before{
        position: relative;
        content: "";

        width: 0.25em;
        height: 100%;

        left: -0.75em;
        
        border-radius: 0.25em;
        background-color: #12161F;
    }

    .decoration-frame{
        grid-area: todo;
        position: relative;
        left: -4px;

        max-height: 40em;
        height: calc(100% - 0.25em);
        max-width: 36em;
        width: calc(100% - 3.125em);

        justify-self: end;
        align-self: end;
        
        border-radius: 1.5em;
        z-index: 0;

        overflow: hidden;
    }

    .todo-list {
        box-shadow: 5px 5px 5px -2px rgba(20, 20, 20, 0.187);

        grid-area: todo;
        display: flex;
        flex-direction: column;
        
        gap: 0.25em;
        
        justify-content: end;
        align-items: start;
        justify-self: end;
        
        max-width: 36em;
        width: calc(100% - 3.125em);

        height: 100%;
        
        padding: 0.25em;
        border-radius: 1.75em;
        background-color: #12161F;
    }
    
    .entries-wrapper{
        display: flex;
        flex-direction: column;

        gap: 0.25em;
        
        height: 100%;
        width: calc(100% + 2.75em);
        
        align-self: end;
        justify-content: end;
        align-content: end;
        
        border-radius: 1.25em;
        overflow: hidden;
        z-index: 1;
    }
    
    .entry-input {
        border-style: none;
        resize: none;
        
        border-radius: 0.25em 0.25em 1.5em 1.5em;
        
        font-size: 1rem;
        font-weight: 400;
        font-style: italic;
        
        height: 1.5rem;
        color: #ACACAF;
        
        width: calc(100% - 1em);
        padding: 0.25em 0.5em;
        
        background-color: #191C24;
        z-index: 1;

        caret-color: #6961C2;
    }

    .entry-input::selection{
        background-color: #6961C2;
        color: #FFE4D6;
    }
    
    .entry-input:focus-visible {
        border-style: none;
        outline-style: none;
        
        font-style:normal;
        font-weight: 600;
        color: #F5F5F5;
    }
    
</style>
