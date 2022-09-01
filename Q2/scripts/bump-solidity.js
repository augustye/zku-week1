const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier/

for(var name of ["HelloWorldVerifier","Multiplier3Verifier","Multiplier3Verifier_plonk"]) {
    let content = fs.readFileSync("./contracts/" + name + ".sol", { encoding: 'utf-8' });
    let bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.0');
    bumped = bumped.replace(verifierRegex, 'contract ' + name);
    
    fs.writeFileSync("./contracts/" + name + ".sol", bumped);
}
