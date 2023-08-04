<script>
    import {Canvas} from '@threlte/core'

    import BackgroundLayout from '../lib/Background/BackgroundLayout.svelte';
    import ContainerDecoration from "../lib/ContainDecoration/ContainerDecoration.svelte";

    import EntryDetails from '../lib/PageComponents/EntryDetails.svelte';
    import Entry from "../lib/PageComponents/Entry.svelte";
    import PointerTrailer from "../lib/PageComponents/PointerTrailer.svelte";
    import BookmarkButton from '../lib/PageComponents/BookmarkButton.svelte';

    import { onMount } from 'svelte';
    import { tweened } from 'svelte/motion';
    import { fade, slide } from 'svelte/transition';
    import { cubicOut, cubicIn, elasticOut, quadOut } from 'svelte/easing';

    import { userData, saveTodos } from '../lib/stores/userStore';

    let expandedEntry = {task: '', id: 0};
    let newTask = ''
    let todos = []

    onMount(() => {
        todos = userData.todos
    })
    
    function addTodo(){
    if (newTask){
            const entry = {task: newTask, 
                id : crypto.randomUUID(), 
                steps: [],
                date: new Date().toUTCString().slice(5, 16)}

            todos = [...todos, entry]
            expandedEntry = entry
        }
        newTask = ''
    }
    
    function removeCompleted(){
        todos = todos.filter(({completed}) => {return !(completed)});
    }
    
    $: {
        saveTodos(todos);
        expandedEntry = expandedEntry;
    }

    let placeHolder = 'New Task'

    let taskInput;
    $: if ((newTask.length > 0) && taskInput){
        resize()
    }

    function resize(){
        taskInput.style.height = "1.25rem";
        taskInput.style.height = taskInput.scrollHeight - 24 + "px";
    }
    
    //pointer stuff.
    import { context, pointerEnabled } from "../lib/stores/pointerStore";

    //RESIZE ANIMATIONS.
    
    let width = 0;
    let entryMode = true
    $: desktopMode = Number(width > 690)
    $: entryMode = !desktopMode

    let viewOffset = tweened(0, {
        duration: 250,
        easing: quadOut
    })

    $: viewOffset.set(Number(!desktopMode) * Number(!entryMode) * 50)
    
    let pageOffset = tweened( 0 , {
        duration: 600,
        easing: elasticOut
    })

    $: pageOffset.set(Number(!desktopMode) * -2)

    let contentHeight = tweened( 72 , {
        duration: 100,
        easing: cubicOut
    })

    $: contentHeight.set(
        (Number(desktopMode) * 72) + (Number(!desktopMode) * 80)
    )

</script>

<svelte:window bind:innerWidth={width}/>

<main class="page">
    <div class="content-wrapper"
        style="
        right: {$pageOffset + $viewOffset}%;
        height: {$contentHeight}%;">
        <div class="todo-list">
            <div class="entries-wrapper">
                {#each todos as entry (entry.id)}
                    <div class="entry"
                    transition:slide={{duration : 200, easing: cubicOut}}>
                        {#if entry.id === expandedEntry.id}
                            <Entry bind:entry={expandedEntry}/>
                        {:else}
                            <Entry bind:entry={entry}
                            on:expand={() => {
                                expandedEntry = entry;
                                entryMode = false
                            }}/>
                        {/if}
                    </div>
                {/each}
            </div>
            
            <textarea 
                placeholder={placeHolder}
                class="entry-input"
                
                bind:this={taskInput}
                bind:value={newTask}
                
                on:mouseenter={() => context.set('add')}
                on:mouseleave={() => context.set('null')}

                on:focus={() => {
                    newTask="";
                    placeHolder=''
                    pointerEnabled.set(false)
                }}

                on:blur={() => {
                    addTodo();
                    taskInput.style.height = "1.25rem";
                    placeHolder='New Task'
                    pointerEnabled.set(true)
                }}
                
                on:keydown={(event) => {
                    if (event.key === "Enter"){
                        event.target.blur();
                        return
                    }
                }} 
                
                
                />
            
            <BookmarkButton on:clicked={removeCompleted}/>
        </div>
        
        <div class="decoration-frame">
            <Canvas>
                <ContainerDecoration/>
            </Canvas>
        </div>
        
        <div class="steps-wrapper">
            {#key expandedEntry.id}
                <div class="steps-container"
                transition:fade={{
                    duration: 200, 
                    easing: cubicIn,
                    }}>
                    {#if expandedEntry.task}
                        <EntryDetails bind:entry={expandedEntry}/>
                    {/if}
                </div>
            {/key}
        </div>
    </div>
    
    <div class="background">
        <Canvas>
            <BackgroundLayout/>
        </Canvas>
    </div>

    <PointerTrailer/>
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
        top: -2em;

        display: grid;
        gap: 0.25em 0.75em;
        grid-template-columns: minmax(24em, 2fr) minmax(16em, 1.4fr);
        grid-template-rows: minmax(100%, 30em);
        grid-template-areas: "todo";

        width: 80%;

        place-content: center;
    }

    .steps-wrapper{
        display: flex;
        flex-direction: column;
        
        max-width: 28em;
        width: 100%;
        height: 100%;

        padding: 0.25em;

        border-radius: 1.25em;
        background-color: #12161ffa;
        backdrop-filter: blur(5px);
        -webkit-backdrop-filter: blur(5px);

        box-shadow: 5px 5px 10px -2px rgba(20, 20, 20, 0.345);

    }

    .steps-wrapper::after{
        position: relative;
        content: "";

        width: 0.25em;
        height: 100%;

        left: -0.75em;
        
        border-radius: 0.25em;
        background-color: #12161F;
    }

    .steps-container{
        height: 0;
        width: 100%;
    }

    .decoration-frame{
        grid-area: todo;
        position: relative;
        left: -4px;

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
        border-radius: 1.75em 1.75em 1.25em 1.25em;
        background-color: #12161F;
    }

    .entries-wrapper{
        display: flex;
        flex-direction: column;

        gap: 0.25em;
        
        height: 100%;
        width: calc(100% + 2.875em);
        
        align-self: end;
        justify-content: end;
        align-content: end;
        
        border-radius: 1.25em;
        overflow: hidden;
        z-index: 1;
    }

    .entry {
        display: flex;
        flex-direction: row;

        align-self: end;

        gap: 0.5rem;
        width: 100%;
    }
    
    .entry-input {
        border-style: none;
        resize: none;
        
        border-radius: 0.25em 0.25em 1em 1em;
        
        font-size: 1rem;
        font-weight: 400;
        font-style: italic;
        
        height: 1.25rem;
        color: #ACACAF;
        
        width: calc(100% - 1.5em);
        padding: 0.75em;
        
        background-color: #191C24;
        z-index: 1;
        cursor: pointer;
    }
    
    .entry-input::selection{
        caret-color: #6961C2;
        background-color: #6961C2;
        color: #ffd5e4;
    }
    
    .entry-input:focus-visible {
        border-style: none;
        outline-style: none;
        
        font-style:normal;
        font-weight: 600;
        color: #F5F5F5;
        cursor: text;
    }

    @media (max-width: 690px){
        .content-wrapper{
            grid-template-columns: 90vw 75vw;
        }
    }
    
</style>
