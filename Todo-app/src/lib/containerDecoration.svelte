<div class="decoration-frame">
    <svg width="100%" height="50%">
        <circle class="circle circle-1" filter= blur(36px) fill=#838DED
        cx="30%" r=250 opacity=0.9/>

        <circle class="circle circle-3" filter= blur(16px) fill=#CB73B8
        cy="5%" r=100/>

        <circle class="circle circle-2" filter= blur(30px) fill=#E57D5C
        cy="10%" cx="30%" r=180 opacity=0.9/>
    </svg>
</div>

<style>
    .decoration-frame{
        grid-area: todo;
        position: relative;
        left: -4px;

        max-height: 40em;
        height: calc(100% - 0.25em);
        max-width: 38em;
        width: calc(100% - 3.125em);

        justify-self: end;
        align-self: end;
        
        border-radius: 1.2em;
        background: linear-gradient(178deg, #E04834 -100%, #1B1C1F 50%);
        z-index: 0;

        overflow: hidden;
    }

    .circle-1 {
        transform: scaleY(0.5) rotate(10deg) scaleX(2);
    }

    .circle-2 {
        transform: scaleY(0.5) rotate(-10deg) scaleX(2);
    }
</style>