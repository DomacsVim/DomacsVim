# Collaboration

why not ! We accept any contribution and help in different sectors and we do not consider any of them to be small or unimportant. The only way to participate in this project is not to write or change the code, but you can also raise your ideas and opinions about adding a new feature, logo, interior design and etc.

* To getting started, it's better to create a symbolic link of the project :

```bash
ln -s ~/.local/share/domacsvim ~/projects/domacsvim
```

* Then, Create a new git repository and add your remote.

```bash
git remote add dev "remote"
```

## Setup tools

* [Stylua](https://github.com/johnnymorganz/stylua#installation) for formatting.
* [Luacheck](https://github.com/luarocks/luacheck) for linting.

## Commit Messages

**Note :** Commit header is limited to 72 characters.

```bash
<type>(<scope>?): <summary>
  │       │           │
  │       │           └─> Present tense.     'add something...'(O) vs 'added something...'(X)
  │       │               Imperative mood.   'move cursor to...'(O) vs 'moves cursor to...'(X)
  │       │               Not capitalized.
  │       │               No period at the end.
  │       │
  │       └─> Commit Scope is optional, but strongly recommended.
  │           Use lower case.
  │           'plugin', 'file', or 'directory' name is suggested, but not limited.
  │
  └─> Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```
---
* **build :** changes that affect the build system or external dependencies (example scopes: npm, pip, rg)
* **ci :** changes to CI configuration files and scripts (example scopes: format, lint, issue_templates)
* **docs :** changes to the documentation only
* **feat :** new feature for the user
* **fix :** bug fix
* **perf :** performance improvement
* **refactor :** code change that neither fixes a bug nor adds a feature
* **test :** adding missing tests or correcting existing tests
* **chore :** all the rest, including version bump for plugins

## Communication

* [Discord server](https://discord.gg/uF2SkwAw)
* [Twitter (persian)](https://twitter.com/Khod_SamMoosavi)
