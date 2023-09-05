
# Style

- Rules for using pattern matches vs if/else statements seem loose. Some rough guidelines include:
    - If pattern matching against true/false, consider an if/else.
    - Prefer pattern matching when constructing recurse functions, since they make the
      base cases more immediately evident.
