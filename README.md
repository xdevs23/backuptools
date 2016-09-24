## Backup tools for Android devices

Copyright (C) 2016 Simao Gomes Viana
<br /><br />

Licensed under the Creative Commons Attribution-ShareAlike 4.0 International Public License (CC BY-SA 4.0)

Read the license on https://creativecommons.org/licenses/by-sa/4.0/legalcode or a short summary on https://creativecommons.org/licenses/by-sa/4.0/

<hr />

These backup tools aim to be a all-in-one collection for android-powered devices.<br />
Note: This is not finished yet.
<br />

But this does not just contain backup tools, it also has a full-featured bash framework and tools which you can easily use to create your own bash scripts.
<br />
They are easy to use and very automated.
<br />
A great example are the way reflectors and commands work.<br />
You don't need to worry about absolute paths and stuff like that.
Just create the file, give it an ID and a name, and put it in the reflectors folder.
Now you can call your reflector file from anywhere just using its ID or name:

```
run example
```

You also can very easily associate a command to it. In that way you can very quickly organize your commands in different files. Inside a reflector:

```
reflectorName "Super example command"
reflectorId   "super_example_cmd"

associateCmd "superexample"
cmdHelpText  "This is an example command."

function reflect() {
  echo "Hello from the super example!"
}
```

As you can see, you can specify a name and an ID. An ID is **always** required, otherwise the reflector can not be called.
`associateCmd` associates the given command with your reflector.<br />
`cmdHelpText` associates the given help text with your command. In that way you don't have to manually write an maintain a separate help text for your commands.
Just write the help text into the reflector and you are ready to go.

And by the way: this is just bash!
