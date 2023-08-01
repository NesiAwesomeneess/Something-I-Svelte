<script>
    import { onMount } from "svelte";
    import { userAuthHandler, userData  } from "../lib/stores/userStore";
    import { auth, db } from '../lib/firebase/firebase'
    import { doc, getDoc, setDoc } from "firebase/firestore";

    let authorised = false

  onMount(() => {
    userAuthHandler.signupWithGoogle(auth);

    //This is called when any change is made to the authenticator.
    const authorityChange = auth.onAuthStateChanged(async user => {
        if (!user){
            return
        }

        authorised = true;
        // you're effectievly making a reference to the specific data in
        // the users collection in the db datatbase.
        const userDocReference = doc(db, "users", user.uid);
        const docSnapShot = await getDoc(userDocReference);
        // if this specific user has anydata.
        if (!docSnapShot.exists()) {
            // set the data.
            await setDoc(userDocReference, $userData.data, {merge: true})
        }else{
            userData.update(currentData => {
                return {
                    ...currentData,
                    data: docSnapShot.data()
                }
            })
        }

        userData.update(currentData => {
            return {
                ...currentData,
                loading : false
            }
        })
    })
  })

</script>

{#if !$userData.loading}
    <slot/>
{:else}
    <h1> Logged out </h1>
{/if}