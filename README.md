# Bulls & Cows Game solver

This is a command line ruby game.

This idea was to write a solver solution for the Bulls & Cows game where the user just pick the secret word and tell the computer how many bulls and cows the word has.

## Solution

This solution is not complete but that's pretty much a working solution.

My idea was to try to reduce the possible words scope after each bull and cows response and then pick a random word from that new scope.

Basically I'm searching the words using regex and I am sure that the regex could be improved and dry some code.

If you run the game you will notice that I show the scopes and all usefull information after each round.