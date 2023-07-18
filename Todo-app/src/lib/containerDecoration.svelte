<div class="decoration-frame">
    <svg width="100%" height="50%">
        <circle class="circle circle-1" filter= blur(20px) fill=#838DED
        cx="60%" r=200 opacity=0.9/>

        <circle class="circle circle-3" filter= blur(16px) fill=#CB73B8
        cx="10%" r=80/>

        <circle class="circle circle-2" filter= blur(20px) fill=#E57D5C
        cx="50%" r=160 opacity=0.9/>
    </svg>
</div>

<style>
    .decoration-frame{
        grid-area: todo;
        position: relative;

        height: calc(100% - 0.25em);
        max-width: 30em;
        width: calc(100% - 3.2em);
        left: -4px;

        justify-self: end;
        align-self: end;

        border-radius: 1.2em;
        overflow: hidden;

        background: linear-gradient(178deg, #E04834 -100%, #1B1C1F 50%);
        z-index: 0;
    }

    .circle-1 {
        transform: scaleY(0.6) rotate(3deg);
    }

    .circle-2 {
        transform: scaleY(0.5);
    }
</style>