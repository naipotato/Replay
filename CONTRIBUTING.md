# Contributing to this project

Hey! Are you wanting to contribute here? That's great! 🎉️

Below you'll find the build instructions of the project, the coding style and guides of how to submit great pull requests or  useful bug reports.

## Building the project

Well, in order to build this project, there's one way that's just perfect: use GNOME Builder. It's quick, easy, and quite convenient. You simply have to:

- Open it (if you don't have it installed yet, you can do it from [here](https://flathub.org/apps/details/org.gnome.Builder))

- In the option to clone a repository, paste the URL to this repo

- And after the cloning is done, just hit the build button (▶️)

And that's it! GNOME Builder will take care of downloading the dependencies for you in an isolated environment so that it doesn't cause a mess on your system 😉️

## Coding Style

The coding style that I developed for this project is special. It takes some things from other Vala projects, but it also takes things from C projects. All of this is in order to have an easily readable code that doesn't cause headaches.

- Classes must go in their own separate files. If there is a class that is merely a helper to another, they can go in the same file

- The structure of the code within a class must be the following:

  - Public fields

  - Private fields

  - Public properties

  - Private properties

  - Public Vala constructors

  - Private Vala constructors

  - Public signals

  - Private signals

  - Public methods

  - Private methods

  - GObject code blocks

    - `construct` block

    - `static construct` block

    - `class construct` block

- The members of a class must be arranged alphabetically

- Vala constructors must not be used to initialize the class, they must only be used as a convenient way to set certain properties when instantiating the object

- Each member region must be delimited by comments and two empty lines as shown in the following code block:

```vala
/* Private fields */

private string _a_field;

/* End private fields */


/* Public properties */

public string a_property { get; set; }

/* End public properties */
```

- Private fields must start with an underscore ('_')

- Do not use the `using` keyword

- Always use namespace qualifications, except with `GLib`, which is known to be imported by default:

```vala
// Use this
bool result = Process.spawn_command_line_sync (...);

// Instead of this
bool result = GLib.Process.spawn_command_line_sync (...);
```

- Do not use `var` keyword if the type of the variable is not really obvious from the right side of the assignment

- Do not rely on the variable or method name to specify the type of the variable, it might not be correct

- Always use `this` to refer to current's instance members

- The opening brace must be in the following line, on the same indentation level as its header only for classes, enums, structs and methods.

- Always use 4 (four) column tabs to indent, and spaces to align

- Always use string templates for string interpolation, except with error messages, which must be localizables, so they must use printf-style

- Source lines must be no more than 120 characters long

- Source filenames must be set following the `namespace-class-name-with-dashes.vala` scheme

- The `return` statement must be preceded by a blank line, except if it's the only line on a code block

- Always insert a blank line at the end of each file

- Always add a space before the parenthesis on method or signal calls

## Commit Messages

There's a little convention for the commit messages: The title should be no more than 50 characters long, and it should follow the `Name for the changed section: Changes applied`. E.g: `ReplayApp: Setted app name on startup vfunc`.

You should also include a description for the commit if it's really necessary to explain the changes. Its lines should be no more than 80 characters long.

## Pull Requests

If you want to submit a pull request to this project, I would suggest submitting it as soon as possible, marking it as a draft on GitHub, so that I can assist you with any issues that may arise 😉️

The name of the pull request should follow the same convention as commit messages, since commits will be squashed. The description should be clear about the contents of the pull request, and if it fixes any issues, it should end with `Fixes #123`.

## Issues

When opening a new issue, try to reproduce it with the Flatpak package and not using any native package, in order to avoid reporting bugs that are directly related to packaging mistakes. Also, try to reproduce it using Adwaita and not any custom theme, in order to avoid reporting issues related to a specific GTK theme.

For crash reports, attach the corresponding backtrace in order to make it easier to debug the crash.

## Final Notes

As always, these contribution guidelines are not rules of thumb, and can be relaxed if required. Any questions you have, you can contact me on Telegram by joining the group that I created for this app: https://t.me/ReplayApp 😄️