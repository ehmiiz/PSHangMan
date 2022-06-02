<#
    HangMan PowerShell
    Idea:
    1. Tech Companies as words
    2. Having HangMan standard rules
        2b: Rules: Randomize a word, make one tile for every character, guess it before the man gets hung.
        guessing a char right can fill in multiple tiles.
    3. At the end (if success) Link to something cool about the company. (else failure) Link to something boring about the company
    4. No GUI
#>

function Invoke-HangMan {
    param (
        [Parameter()]
        [Int]$Stage
    )

    $HangMans = '
  +---+
  |   |
      |
      |
      |
      |
=========', '
  +---+
  |   |
  O   |
      |
      |
      |
=========', '
  +---+
  |   |
  O   |
  |   |
      |
      |
=========', '
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========', '
  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========', '
  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========', '
  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
========='

    $HangMans = $HangMans.split(",")
    Clear-Host
    $HangMans[$Stage]

}