<div class="background">
    
    <svg class="circle-2" width="300" height="300" preserveAspectRatio="none">
        <circle cy=50% cx=50% r=80 fill="#F4EFE0" filter="blur(16px)"/>
    </svg>

    <svg class="circle-3" width="300" height="300" preserveAspectRatio="none">
        <circle cy=50% cx=50% r=80 fill="#3C5BAE" filter="blur(16px)"/>
    </svg>

    <svg class="circle-1" width="300" height="300" preserveAspectRatio="none">
        <circle cy=50% cx=50% r=80 fill="#6D8FEA" filter="blur(16px)"/>
    </svg>

    <svg class="curve-1" width="500" height="500" preserveAspectRatio="none">
        <svg class="curve" width="1231" height="707" preserveAspectRatio="none">
            <path opacity="0.9" filter="blur(4px)" fill="#2B3039" d="M329.815 94.3733C614.27 69.8051 1148.24 -42.0175 1210.27 69.8051C916.776 200.537 778.583 315.295 554.457 499.319C330.332 683.342 98.3541 741.873 36.3209 630.05C-25.7123 518.228 105.69 278.397 329.815 94.3733Z"/>
        </svg>
    </svg>
</div>

<style>
    .background {
        
        position: absolute;
        
        width: 100vw;
        height: 100vh;
        z-index: -1;
        
        background-color: #2B3039;
    }
    
    .circle-1 {
        --positionX: 50%;
        --positionY: 75%;

        position: absolute;
        top: var(--positionY);
        left: var(--positionX);
        transform:
        translateY(calc(var(--positionY) * -1))
        translateX(calc(var(--positionX) * -1)) 
        rotate(-20deg) 
        scaleY(2) 
        scaleX(5);
    }

    .circle-2 {
        --positionX: 60%;
        --positionY: 75%;

        position: absolute;
        top: var(--positionY);
        left: var(--positionX);

        transform:
        translateY(calc(var(--positionY) * -1))
        translateX(calc(var(--positionX) * -1)) 
        rotate(20deg) 
        scaleY(1.8) 
        scaleX(3);
    }

    .circle-3 {
        --positionX: 40%;
        --positionY: 35%;

        position: absolute;
        top: var(--positionY);
        left: var(--positionX);
        transform:
        translateY(calc(var(--positionY) * -1))
        translateX(calc(var(--positionX) * -1)) 
        rotate(-30deg) 
        scaleY(3) 
        scaleX(6.5);
    }

    .curve {
        transform: scale(0.45);
    }

    .curve-1 {
        --positionX: 30%;
        --positionY: 0%;

        position: absolute;
        top: var(--positionY);
        left: var(--positionX);
        transform:
        translateY(calc(var(--positionY) * -1))
        translateX(calc(var(--positionX) * -1)) 
        rotate(0deg) 
        scaleY(2) 
        scaleX(2);
    }

</style>