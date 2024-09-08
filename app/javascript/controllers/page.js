// commentaire

/* Commenter
plusieurs
lignes */

console.log("Hello");

let maSuperVariable = "Hello";

console.log(maSuperVariable);

// Les variables

var unTexte = "Voici un texte" ; // var = désuet
const prenom = "justine" ;
let unChiffre = 24 ;
let chaine = 'Je suis une chaine de caracteres' ; // guillemets ou apostrophe = pareil

let nouvelleChaine = "Chaine précédente = " + chaine ; // concaténation
let autreChaine = `Chaine précédente = ${chaine}` ; // interpolation

let arbre;
arbre = "chene" // on peut définir une variable sans rien assigner, et assigner plus tard

// Types de données

let string = "Je suis une chaine de caracteres" ;
let number = 24 ;
let boolean = true ;
let array = ["je","suis",1,"tableau"] ;
let object = {
  prenom : "audrey",
  age : 33,
  ville: "Bordeaux"
};

// Les opérateurs

console.log(3+4);
console.log(3-4);
console.log(3*4);
console.log(3/4);
console.log(3%4); // modulo
console.log(3**4); // puissance
total++; // incrementation
total += 2; // total = total + 2
total -= 2;
total *= 2;

// Conditions

let x = 1 ;
let y = 2 ;

if (x >y) {
  alert("Yes x plus fort que y");
} else if (y > x) {
  alert("y est plus grand !");
} else {
  alert("ils sont égaux");
}

/* le == teste l'égalité en type et en valeur
le === teste l'égalité sans prendre en compte le type
le || veut dire OU et le && veut dire ET
*/

// Les fonctions

function faireQuelqueChose() { // définir la fonction
  console.log("Je fais un truc");
}

faireQuelqueChose(); // appeler la fonction

const addition = (a, b) => { // fonction fléchée
  console.log(a + b);
}
