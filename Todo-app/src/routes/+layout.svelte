<script>
  import { onMount } from "svelte";
  import { userAuthHandler, userDataLoading  } from "../lib/stores/userStore";
  import { auth } from '../lib/firebase/firebase'

  onMount(() => {
    userAuthHandler.signupWithGoogle(auth);
  })

</script>

{#if !$userDataLoading}
    <slot/>
{:else}
    <h1> Logged out </h1>
{/if}