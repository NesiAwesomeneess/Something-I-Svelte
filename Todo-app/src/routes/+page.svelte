<script>
    import BackgroundDecorations from "../lib/BackgroundDecorations.svelte";
    import ContainerDecoration from "../lib/ContainerDecoration.svelte";
    import Entry from "../lib/Entry.svelte";
    import PointerTrailer from "../lib/PointerTrailer.svelte";

    let todos = [{task : "Sharpen spear.", id : 0, completed: false}]
    let newTask = 'New Task?'

    let taskInput;

    $: if ((newTask.length > -1) && taskInput){
        taskInput.style.height = "1.75rem";
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

</script>

<main class="page">
    <PointerTrailer/>

    <div class="content-wrapper">
        <div class="todo-list">
            <div class="entries-wrapper">
                
                {#each todos as entry (entry.id)}
                <Entry id={entry.id} 
                bind:task={entry.task}
                bind:completed={entry.completed}/>
                {/each}
            </div>
            
            <textarea class="entry-input"
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
            
            <button class='bookmark'>
                <svg width="32" height="39" viewBox="0 0 32 39" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <g id="BookMark">
                    <mask id="path-1-inside-1_4_11" fill="white">
                    <path d="M0 36.2387V8C0 3.58172 3.58172 0 8 0H24C28.4183 0 32 3.58172 32 8V36.2387C32 37.8409 30.21 38.7927 28.8817 37.8968L18.2367 30.717C16.885 29.8053 15.1151 29.8053 13.7633 30.717L3.11834 37.8968C1.78998 38.7927 0 37.8409 0 36.2387Z"/>
                    </mask>
                    <path d="M0 36.2387V8C0 3.58172 3.58172 0 8 0H24C28.4183 0 32 3.58172 32 8V36.2387C32 37.8409 30.21 38.7927 28.8817 37.8968L18.2367 30.717C16.885 29.8053 15.1151 29.8053 13.7633 30.717L3.11834 37.8968C1.78998 38.7927 0 37.8409 0 36.2387Z" fill="#2B3039" stroke="#1B1C1F" stroke-width="8" mask="url(#path-1-inside-1_4_11)"/>
                    </g>
                </svg>
            </button>
        </div>

        <ContainerDecoration/>

        <div class="detail-wrapper">
            
        </div>
    </div>

    <BackgroundDecorations/>
</main>


<style>
    * {
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
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
        background-color: #1B1C1F;
        box-shadow: 5px 5px 5px -2px rgba(20, 20, 20, 0.187);

    }

    .detail-wrapper::before{
        position: relative;
        content: "";

        width: 0.25em;
        height: 100%;

        left: -0.75em;
        
        border-radius: 0.25em;
        background-color: #1B1C1F;
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
        background-color: #1B1C1F;
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
        
        border-radius: 0.25em 0.25em 1.25em 1.25em;
        
        justify-self: end;
        
        font-size: 1.25rem;
        font-weight: 600;
        font-style: italic;
        
        height: 1.6rem;
        color: #1B1C1F;
        
        width: calc(100% - 1em);
        padding: 0.25em 0.5em;
        
        background-color: #2B3039;
        z-index: 1;
    }
    
    .entry-input:focus-visible {
        border-style: none;
        outline-style: none;

        font-style:normal;
    }

    .bookmark{
        position: absolute;
        
        appearance: none;
        border: none;
        background: none;
    }

    .bookmark svg {
        position: relative;
        margin: 0 0.5em;
        
        top: 3.75em;
    }
    
</style>
