reqall
======

require multiple files in node
## Why?

Mostly 'cause I'm really lazy. __reqall__ allows you to load modules at
runtime, based on scanning the filesystem. This means you have to write
less `require` code, though it _also_ means your application will be slower,
at initial launch (I think that's the only performance hit).

For instance, [critic](https://github.com/b3ngr33ni3r/critic) uses this to
`require` each model file, since they're each in their own `.js` file. This
way I can add models without changing ANY code. Also, the `models` directory
`index.js` file is one line (`module.exports = require('reqall')();`) so thats...fun.

## How?

```
var modules = require('reqall')();
```

will load __all__ the `.js` files in the directory into an object. If we had
4 javascript files in the directory, named 'one.js','two.js',etc our object
would look like this: 

```
{
  one: function,
  two: function,
  three: function,
  four: function
}
```

assuming that all the modules (one.js,etc) are written such that `exports = function(){};`
there's no magic there, all we do is call `require` on each one of the js modules in the
directory and create an object of the results.

You can also specify module names, and only those modules will be loaded. This uses
`require` syntax, so if you want to `reqall` some specific files in the same directory
you'd need to call `reqall('./file','./file2')`. 

```
var modules = require('reqall')('request','./mylib','flatiron');
```

would work just fine, assuming you've got `request` and `flatiron` installed
from npm. 

```
{
  request: function,
  mylib: valueOrWhatever,
  flatiron: object
}
```

## Caveats

you can't access the calling script via the returned object. ie, if i call `reqall` from
a script `index.js` then there will be no `index` property in the object. this is a node
limitation (well technically this could work in node sometimes, but I've disabled it for sure),
but also why would you ever want to do that.


## Moar

[MIT LICENSE](https://github.com/b3ngr33ni3r/reqall/blob/master/LICENSE)  
Follow me on twitter - [@b3ngr33ni3r](https://twitter.com/b3ngr33ni3r)  
  
Post questions/comments/bugs [here](https://github.com/b3ngr33ni3r/reqall/issues)
