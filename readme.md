# Raid Night
Collection of resources to finally make us an effective fireteam.

## Development

### With Nix
Enter a nix develop shell:
```
nix develop
```
You should see a message that says `Raid night!`. From here, you can start the mdbook server with:
```
run
```
This will start a server on `localhost:3000`. Changes you save to the local markdown will automatically be updated there.

### Without Nix
Install mdbook following steps [here](https://rust-lang.github.io/mdBook/guide/installation.html). Start the dev server with:

```
mdbook serve
```

This will start a server on `localhost:3000`. Changes you save to the local markdown will automatically be updated there.

### Making Changes
Create new markdown files or update existing ones. New pages will need to be added to the `SUMMARY.md` if you want them to appear in the sidebar.

Once your changes look good, make a PR. Once merged to the main branch, github actions will automatically update the website.