import { writable } from "svelte/store";

import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signInWithPopup,
  GoogleAuthProvider,
  GithubAuthProvider,
  signOut,
} from "firebase/auth";

import { auth, db } from "../firebase/firebase";
import { doc, getDoc, setDoc } from "firebase/firestore";

const googleProvider = new GoogleAuthProvider();
export const githubProvider = new GithubAuthProvider();

let user;
export let userData = { username: "", todos: [] };
export const userDataLoading = writable(true);

export async function saveTodos(tasks) {
  if (!tasks.length) {
    return;
  }

  const userDocReference = doc(db, "users", user.uid);
  const data = { todos: tasks };
  console.log(tasks);
  await setDoc(userDocReference, data, { merge: true });
}

export async function syncData() {
  // you're effectievly making a reference to the specific data in
  // the users collection in the db datatbase.
  const userDocReference = doc(db, "users", user.uid);
  const docSnapShot = await getDoc(userDocReference);

  if (docSnapShot.exists()) {
    userData = docSnapShot.data();
  } else {
    // Set the data.
    await setDoc(userDocReference, userData, { merge: true });
  }
}

// LOGIN DETAILS

//This is called when any change is made to the authenticator.
const authorityChange = auth.onAuthStateChanged(async (currentUser) => {
  if (!currentUser) {
    return;
  }

  user = currentUser;
  await syncData();
  userDataLoading.set(false);
});

export const userAuthHandler = {
  signup: async (email, password) => {
    await createUserWithEmailAndPassword(auth, email, password);
  },
  login: async (email, password) => {
    await signInWithEmailAndPassword(auth, email, password);
  },
  signupWithGoogle: async () => {
    signInWithPopup(auth, googleProvider)
      .then((result) => {
        const credential = GoogleAuthProvider.credentialFromResult(result);
        const token = credential.accessToken;
      })
      .catch((error) => {
        console.log(error);
      });
  },
  signout: async () => {
    signOut(auth);
  },
};
