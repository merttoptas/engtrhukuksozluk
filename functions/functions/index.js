const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');
const algoliaFunctions = require('algolia-firebase-functions');
const firestore = require('firebase/firestore');
const firebase = require('firebase');
var serviceAccount = require("./serviceAccountKey.json");
const admin = require('firebase-admin');



admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://hukukengtrsozluk.firebaseio.com"
});

ALGOLIA_APP_ID="WZFSBELAA6"
ALGOLIA_ADMIN_KEY="4c14584cc213e038c3cd6a24650bda91"
ALGOLIA_INDEX_NAME='word'
FIREBASE_DATABASE_URL="https://hukukengtrsozluk.firebaseio.com"
ALGOLIA_SEARCH_KEY = "0c4ad49e09fc85c8a1e024d474e51fa3"

// configure algolia
const algolia = algoliasearch(
  ALGOLIA_APP_ID,
  ALGOLIA_ADMIN_KEY
);

const index = algolia.initIndex(process.env.ALGOLIA_INDEX_NAME);


    const records = [];
    firebase.initializeApp({projectId: "hukukengtrsozluk",databaseURL: process.env.FIREBASE_DATABASE_URL})
    const db = firebase.firestore();

    db.collection("words").get()
        .then((snapshot) => {
            snapshot.forEach((doc) => {
                // get the key and data from the snapshot
                const childKey = doc.id;
                const childData = doc.data();
                // We set the Algolia objectID as the Firebase .key
                childData.objectID = childKey;
                // Add object for indexing
                records.push(childData);
                return console.log(doc.id, '=>', doc.data());
            });
            // Add or update new objects
            index.saveObjects(records).then(() => {
                console.log('Documents imported into Algolia');
                process.exit(0);
            })
            .catch(error => {
                console.error('Error when importing documents into Algolia', error);
                process.exit(1);
                return null;
            });
        })
        .catch((error) => {
            console.error('Error getting documents', error);
            return null;
        });

        /*
        const algolia = algoliasearch(functions.config().algolia.app,
                              functions.config().algolia.key);
const index = algolia.initIndex(functions.config().algolia.index);
// Name fo the algolia index for Blog posts content.
        */


exports.syncAlgoliaWithFirestoreCreate = functions.firestore.document('/word/{id}').onCreate(
  (change, context) => algoliaFunctions.syncAlgoliaWithFirestoreCreate(index, change));


exports.syncAlgoliaWithFirebase = functions.firestore.document('/words/{id}').onUpdate(
  (change, context) => algoliaFunctions.syncAlgoliaWithFirebase(index, change));

  exports.syncAlgoliaWithFirestore = functions.firestore.document('/words/{id}').onWrite(
    (change, context) => algoliaFunctions.syncAlgoliaWithFirestore(index, change));

   