import { writable } from "svelte/store";

import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signInWithPopup,
  GoogleAuthProvider,
  GithubAuthProvider,
  signOut,
} from "firebase/auth";

import { auth } from "../firebase/firebase";

const googleProvider = new GoogleAuthProvider();
export const githubProvider = new GithubAuthProvider();

export const userData = writable({
  user: null,
  loading: true,
  data: {
    todos: [],
  },
});

export function saveToFireBase() {}

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
        userData.user = result.user;
      })
      .catch((error) => {
        console.log(error);
      });
  },
  signout: async () => {
    signOut(auth);
  },
};
