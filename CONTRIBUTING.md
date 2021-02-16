# Contributing Guidelines

Hey! Do you want to contribute to the project? That's great! 🎉️

Below you will find a series of guides to help you do this, such as: how to
build and debug the app, the coding style we use, and various recommendations
when creating your commits and publishing your pull requests.

> NOTE: If you are a designer, and you want to contribute designs to the app,
> switch to the [`design`](https://github.com/nahuelwexd/Replay/tree/design)
> branch to find the design contribution guidelines 😊️

Don't forget to join the Telegram group listed on the [README](README.md)!

## Building the Project

Building this project is pretty straightforward - just use Builder.

- Open it (in case you don't have it installed, you can do it from
  [here](https://flathub.org/apps/details/org.gnome.Builder))
- In the option to clone a repository, copy and paste the URL of this one
- After the cloning has finished, press the "Run" button (▶️)

And that's it! Builder will take care of downloading and installing the
dependencies for you in an environment completely isolated from your system, to
avoid disasters 😉️

## Coding Style

This is the coding style we are currently using in Replay. It is highly inspired
by the one used in elementary, but with some slight modifications that we find
convenient to improve readability even without language servers.

- Public classes must go in their own separate files. If one of them is a mere
  helper to another, an exception can be made so that they go in the same file.
- The order of the class members must be as follows:
  - Public fields
  - Private fields
  - Public properties
  - Private properties
  - Public Vala's constructors
  - Private Vala's constructors
  - Public signals
  - Private signals
  - Public methods
  - Private methods
  - GObject code blocks
    - `construct` block
    - `static construct` block
    - `class construct` block
- The class members must be arranged alphabetically
- Vala's constructors should not be used to initialize the class, but rather as
  convenient functions to set certain properties when instantiating an object
  (such as construct properties), making use of the GObject construction style.
  See:
  ```vala
  public ApplicationWindow (Rpy.Application app) {
  	Object (
  		application: app
  	);
  }
  ```
- Private fields must start with an underscore (`_`)
- Avoid using the `using` keyword
- Always use namespace qualifications, the only exceptions to this rule being
  `GLib` and `Rpy`
- Don't use the `var` (implicit type) keyword if the type of the variable isn't
  really obvious from the right side of the assignment. See:
  ```vala
  // bad
  var result = ExampleClass.result_so_far ();

  // redundant => bad
  Person person = new Person ();

  // good
  ResultSet result = ExampleClass.result_so_far ();

  // good
  var person = new Person ();
  ```
- Don't rely on the name of a variable or method to determine its type, it may
  not be correct
- Always use the `this` keyword to refer to the members of the current instance
- The opening brace must always be at the end of the first line in classes,
  functions, loops, and general control flows ("One True Brace Style")
- Always use 4 column wide tabs to indent, and spaces to align
- Always use string templates to interpolate strings, except in error messages,
  which must be localizable and therefore use printf style
- Lines of code must not exceed 120 columns long
- The file names must follow the `class-name.vala` scheme
- The `return` keyword must be preceded by a blank line, except if it is the
  only line in the code block
- Always insert a blank line at the end of each file
- Always add a white space before the opening parenthesis both in method or
  signal declarations, as well as in calls to them
- Always insert white spaces between numbers and operators in math-related code
- The closing braces must always be succeeded by a blank line, except if it is
  followed by an `else` or another closing brace
- Always use braces to delimit code blocks, even if they have only one line
- Always cuddle the `else`
- In case you need to use multiple `else if`s, check if you can replace the
  conditional with a `switch...case`
- Always use descriptive names for your identifiers (avoid Hungarian notation or
  abbreviations)
- Use `//` for your comments
- Use `/// TRANSLATORS:` if you need to leave annotations for the translators
- Variable and method identifiers must use `snake_case`
- Type identifiers must use `PascalCase`
- Enum members and constants identifiers must use `SCREAMING_SNAKE_CASE`
- Prefer to use static type casting over dynamic type casting, since the latter
  produces nullable types
- Prefer to use properties over getters/setters methods
- Always use object initializers to avoid code redundancy. See:
  ```vala
  // bad
  var label = new Gtk.Label ("Test Label");
  label.ellipsize = Pango.EllipsizeMode.END;
  label.valign = Gtk.Align.END;
  label.width_chars = 33;
  label.xalign = 0;

  // good
  var label = new Gtk.Label ("Test Label") {
  	ellipsize = Pango.EllipsizeMode.END,
  	valign = Gtk.Align.END,
  	width_chars = 33,
  	xalign = 0
  };
  ```
- When you need to break a method call across multiple lines, use parentheses as
  braces and put one argument per line. See:
  ```vala
  this.bind_property (
  	"can-go-back",
  	this._back_button,
  	"visible",
  	BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE
  );
  ```
- Prefer to use operators over methods when they have syntax support
- Use the `public` access level only when really necessary, otherwise use
  `private`
- Use auto-implemented properties whenever possible. See:
  ```vala
  // bad
  private string _name;
  public string name {
  	get { return this._name; }
  	set { this._name = value; }
  }

  // good
  public string name { get; set; }
  ```
- Make use of blank lines to separate the code into logical pieces

## Commit Messages

There is a little convention for commit messages: The title should be no more
than 50 columns long, and should follow the `section changed: changes made`
scheme. Eg: `header-bar: fixed search entry style`.

It should also include a description for the commit, if it's really necessary.
Your lines should not exceed 80 columns long.

## Pull Requests

We suggest submitting your pull requests as soon as possible, marking them as
"draft" on GitHub, so we can assist you with any issues you may have 😉️

The name of the pull request should follow the same convention as commit
messages, as they will be squashed when the request is merged. The description
should be clear about the contents of the pull request, and if it fixes any
issues, it should end with `Fixes #123`.

## Issues

When you proceed to open an issue, verify that you can reproduce it with the
Flatpak package, to rule out the possibility that it is related to the packaging.
In case of visual issue, also check if it is reproducible with Adwaita.

For crash reports, attach the corresponding backtrace to facilitate its
correction.
