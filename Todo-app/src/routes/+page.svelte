<script>
    import ContainerDecoration from "../lib/containerDecoration.svelte";
    import Entry from "../lib/entry.svelte";
    import PointerTrailer from "../lib/pointerTrailer.svelte";

    let todos = [{task : "Sharpen spear.", id : 0, completed: false}]
    let newTask = 'New Task?'

    function addTodo(){
        if (newTask){
            todos = [...todos, {task: newTask, id: crypto.randomUUID()}]
        }

        newTask = "New Task?"
    }

    function taskCompleted(){
        todos = todos.filter(({completed}) => {return !(completed)});
    }

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
            on:input={(event) => {
                const input = event.target;
                input.style.height = "1.rem";
                input.style.height = input.scrollHeight + "px"}
            }
            on:focus={() => newTask=""}
            bind:value={newTask} 
            on:blur={addTodo} 
            on:keypress={(event) => {if (event.key === "Enter"){
                addTodo()
            }}}/>

        </div>

        <ContainerDecoration/>

        <div class="detail-wrapper">
            
        </div>

        <svg class='bookmark' width="32" height="39" viewBox="0 0 32 39" fill="none" xmlns="http://www.w3.org/2000/svg">
            <g id="BookMark">
            <mask id="path-1-inside-1_4_11" fill="white">
            <path d="M0 36.2387V8C0 3.58172 3.58172 0 8 0H24C28.4183 0 32 3.58172 32 8V36.2387C32 37.8409 30.21 38.7927 28.8817 37.8968L18.2367 30.717C16.885 29.8053 15.1151 29.8053 13.7633 30.717L3.11834 37.8968C1.78998 38.7927 0 37.8409 0 36.2387Z"/>
            </mask>
            <path d="M0 36.2387V8C0 3.58172 3.58172 0 8 0H24C28.4183 0 32 3.58172 32 8V36.2387C32 37.8409 30.21 38.7927 28.8817 37.8968L18.2367 30.717C16.885 29.8053 15.1151 29.8053 13.7633 30.717L3.11834 37.8968C1.78998 38.7927 0 37.8409 0 36.2387Z" fill="#2B3039" stroke="#1B1C1F" stroke-width="8" mask="url(#path-1-inside-1_4_11)"/>
            </g>
        </svg>

    </div>

</main>

<style>
    * {
        margin: 0;
        padding: 0;

        font-family: 'Montserrat';
    }
    
    .page {
        display: grid;
        place-items: center;
    
        margin: 0;
    
        height: 100vh;
        width: 100vw;
        background-color: #2B3039;
    }

    .content-wrapper{
        display: grid;
        gap: 0.25em 0.75em;
        grid-template-columns: minmax(26em, 2fr) minmax(15em, 1.5fr);
        grid-template-areas: "todo";

        width: 80%;
        place-content: center;
    }

    .detail-wrapper{
        display: flex;

        max-width: 18em;
        width: 100%;
        height: 100%;

        border-radius: 1.4em;
        background-color: #1B1C1F;
    }

    .detail-wrapper::before{
        position: relative;
        content: "";

        width: 4px;
        height: 100%;

        left: -0.5em;
        
        border-radius: 0.25em;
        background-color: #1B1C1F;
    }

    .todo-list {
        grid-area: todo;
        display: flex;
        flex-direction: column;
        
        gap: 0.25em;
        
        justify-content: end;
        align-items: end;
        justify-self: end;
        
        max-width: 30em;
        width: calc(100% - 3.125em);
        height: 26em;
        
        padding: 0.25em;
        border-radius: 1.4em;
        background-color: #1B1C1F
    }
    
    .entries-wrapper{
        display: flex;
        gap: 0.25em;
        
        height: 100%;
        width: calc(100% + 2.5em);
        
        justify-items: end;
        align-items: end;
        
        border-radius: 1.2em;
        overflow: hidden;
        z-index: 1;
    }
    
    .entry-input {
        border-style: none;
        resize: none;
        
        border-radius: 0.25em 0.25em 1.2em 1.2em;
        
        justify-self: end;
        
        font-size: 1rem;
        font-weight: 600;
        font-style: italic;
        
        height: 1.4rem;
        color: #1B1C1F;
        
        width: calc(100% - 1em);
        padding: 0.25em 0.5em;
        
        background-color: #2B3039;
        z-index: 1;
    }
    
    .entry-input:focus-visible {
        border-style: none;
        outline-style: none;
    }

    .bookmark{
        margin: 0 0.5em;
    }
    
</style>
