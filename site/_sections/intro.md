<section>

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels/hallway-dome-interior.jpeg'); height: 200px"></div>

What is it?
-------------

In short, it's a way to build a really cool *reactive* single-page application using the latest frameworks without sacrificing page speed, and without needing a complex javascript app on your webserver.

It's features a very concise and convenient syntax which exposes the power of Redux and without the boilerplate, the application structure and folders, and all of the rest of the overhead.

The application you develop will also fully render for the user on the server side, reducing the time it takes to begin using your application. It will even render without javascript enabled in the user's browser.

Once rendered, the application comes to life the first time you interact with it.

Since the same code is used on both server and client, you will only need to implement your application once.

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels-opt/white-blank-notebook.jpg'); height: 200px"></div>

What can I do with it?
----------------------------

You can build practically any web application, using custom CSS, custom widget libraries, etc. You are building a real HTML+JS application, starting from a simple template file.

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels-opt/red-swing.jpg'); height: 400px"></div>

How can I try it?
---------------------

First, visit our <a href="https://playground.isymtope.org" target="_blank">playground</a> and view the examples. You can compile them right in your browser (web assembly is required).

Then, make some changes to the template or even clear it out and start your own app.

You can also <a href="https://github.com/tmzt/isymtope" target="_blank">get the source</a> and follow the directions in the `README.md` to build it for yourself.

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels/building-windows.jpeg'); height: 200px"></div>

What does it look like?
------------------------------

Here's an example of an Isymtope application:

<figure class="highlight">

```rust
use html;

store {
    let counter = 0;

    counter {
        action increment => value + 1;
        action decrement => value - 1;
    }
}

component counter() {
    h4 { ("Counter: ") (counter) }
    p (class="actions") {
        a (href="#decrement") click || { dispatch decrement; } {( "Decrement" )}
        (" | ")
        a (href="#increment") click || { dispatch increment; } {( "Increment" )}
    }
}

counter (get counter) {}
```
</figure>

This is a very simple example, a counter. We'll go through it line by line:

<figure class="highlight">

```rust
use html;
```
</figure>

This is mostly used to indicate that we are building a web app in Isymtope, versus a possible future native app target.

<figure class="highlight">

```rust
store {
}
```
</figure>

The *store* block is how we declare our Redux store, which includes the values we are storing (called *keys*) and the set of actions that can be dispatched for each of those keys.

We use the *let* keyword within the *store* block to define a key:

<figure class="highlight">

```rust
store {
    let counter = 0;
…
}
```
</figure>

In this case, we are defining the key `counter` and giving it a starting (or default) value of `0`. We are also defining it's type to be a number. Once a type has been given to a key, it won't change within the application.

Next we define the actions to be associated with the `counter` key:

<figure class="highlight">

```rust
store {
…
    counter {
        action increment => value + 1;
        action decrement => value - 1;
    }
}
```

</figure>

The `action` keyword is used to define an action within a *key* block. In this case, the actions are `increment` and `decrement`.

The expression after the *=>* (arrow) is the value that will be assigned to the *key* when the action is dispatched. The special names `state` and `value` both refer to the state of the key at the beginning of processing the action.

The semicolon (;) is used sparingly but is required in some instances, including after an action line in a key block.

Following the *store* block, we see the first (and only in this simple app) component defined:

<figure class="highlight">

```rust
…
component counter() {
    …
}
```
</figure>

A component is a self-contained, reusable block of output. It's made up of *elements* and calls to other components.

We can see here the syntax for an element:

<figure class="highlight">

```rust
…
component counter() {
    h4 { ("Counter: ") (counter) }
    …
}
```
</figure>

In this case, it's an *h4*. It's followed by a block which contains the child elements of this element. Strings of text and expressions must both be wrapped in parenthesis. This and other restrictions on the syntax will probably be lessoned as the language evolves.

We see here the expression term `counter` which simply refers to the current value of the key defined earlier.

Now let's look at the rest of the component:

<figure class="highlight">

```rust
…
component counter() {
    h4 { ("Counter: ") (counter) }
    p (class="actions") {
        a (href="#decrement") || { dispatch decrement to counter; } {( "Decrement" )}
        (" | ")
        a (href="#increment") || { dispatch increment to counter; } {( "Increment" )}
    }
}
```
</figure>

We see here a *p* tag containing two links which are divided by a vertical pipe. You can also see the syntax for an *attribute* of the element.

The two vertical pipes (`||`) following the list of attributes are the syntax for an *event handler*. This is taken from Rust where they are used as the syntax for a closure or lambda. An optional event name proceeds this symbol, but it's taken here to be the default for a link, which is *click*. The on prefix is not used as it is in javascript.

Otherwise, the event names are the same as javascript. The HTML reference on [mdn](https://developer.mozilla.org/en-US/docs/Web/HTML) is a good place to see what events are supported for a given element.

In addition to the standard events, shortcut events like `enterkey` are defined. This special event is fired when an `onkeydown` with `keyCode` 13 is received.

The body of the event handler is a block which can contain multiple *dispatch* statements.

The *dispatch* statement will dispatch a given action to a given key. If the *to* clause is left off, the action will be dispatched to the key defined by the first *let* statement.

Following the action name, the action parameters are given within parenthesis.

They take the form _`action`_(_`param`_: _`value`_).


Finally, after we've define the component, we invoke it.

<figure class="highlight">

```rust
…
counter (get counter) {    
}
```

</figure>


This uses the same syntax we use for an element. The block following the invocation is empty, but it would otherwise be treated as input to the component and not rendered automatically.

 We are also introducing a new concept here, which we call *lenses*.

Basically, this is a projection from the source of a value to where it is used. This is using the *get* lens, which simply gets a value defined in the store and injects it as a parameter with the same name as the key. (We can also alias the result with the *as* keyword, but we aren't doing that here.)

Other lenses include the *query* lens, which invokes a named query in the app, and the *for* lens which not only retrieves a value, but also loops over the element or component instance.

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels/scalloped-wall.jpeg'); height: 200px"></div>

How can I learn more?
-----------------------------

Take a look at our <a href="https://playground.isymtope.org" target="_blank">playground</a>  where you can play with this and many other demos.

More will be added and soon you will be able to create and share your creations.

How does it work?
------------------------

<figure class="img">
    <img src="{{ site.base_url }}/assets/img/sections/intro/how_does_it_work/diagram.svg" title="Converting ISM to output formats" />
    <figcaption>The same ISM file can be used to produce multiple output formats with different frameworks.</figcaption>
</figure>

The compiler takes the template and builds an abstract syntax tree (AST) from it. Then the code generation driver will build either HTML code where all expressions are resolved and components expanded in place, or javascript (JS) which will make the appropriate definitions and calls to a framework. Currently, the only supported framework is Incremental DOM. However, we intend to support React, Vue, and others in the near future. This would allow us to reuse components defined in any of those libraries, when your app targets the same framework. (In theory, cross-framework components should also work, as would web components.)

The template syntax will not have to change in order to support additional libraries, and the same app can be targeted to multiple frameworks, assuming the components needed are available in that framework.

With the default implementation, the HTML that is built is the same HTML that the JS application would build, and it's actually left in place and updated. This will also be possible for other frameworks that support *rehydration*.

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels/concrete-structure.jpeg'); height: 200px"></div>

How is this different from other isomorphic approaches?
---------------------------------------------------------------------------

Most other isomorphic frameworks work by executing javascript code on the server, usually with a runtime like _node.js_. Unlike code purpose written for node, this often results in code that was really intended to be rendered in a browser being rendered with a compatbility layer. It also has the same limitations as far as build tools and packaging systems.

Node is also slower than natively compiled code. One of the goals of Isymtope (and it's predecessor) is to be compiled to native code and focusing on shortening the _time-to-first-byte_, while also rendering complete HTML.

Isymtope uses the same routing mechanism on client and server, and will automatically apply the appropriate actions to the store internally when rendering the page. This is even true when the target is a static HTML page which can be cached.

Isymtope will also support a session implementation based on this concept, where the accumulated actions are applied server-side when rendering a page. We are also looking at merging state between the static page and user-specific changes, such as whether a user is logged in or has messages.

<div class="call-out" style="background-image: url('{{ site.base_url }}/assets/img/pexels/white-hallway-geometric.jpeg'); height: 200px"></div>

What is the future?
-------------------------

Isymtope is really about discovering what that future is and can be. Can a developer build an app the same way an artist might sketch a picture?

Can an organization organically "know itself"?.

Can an API grow from a data source, support a set of actions in a single page application, self-document and self-define?

Can an AI-driven agent build a complete picture of the possible and permissible actions for a person or piece of software, given all of the legacy data and systems within an organization?

Can we start with a demo coded in HTML and javascript and build a complete reactive app, without changing a single line of the original source?

We believe the answer to all of these is yes.

</section>