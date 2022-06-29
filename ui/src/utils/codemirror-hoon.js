import CodeMirror from 'codemirror'

// CodeMirror, copyright (c) by Marijn Haverbeke and others
// Distributed under an MIT license: https://codemirror.net/LICENSE

// doqbloq
// soqbloq
const COMMENT_REGEX = /::.*|"""[.\S\s]*?"""|'''[.\S\s]*?'''/
// tape
// cord
// arm
const ARM_REGEX = /([a-z]([a-z0-9-]*[a-z0-9])?\/)|(\+[-+] {2}(?=[a-z]([a-z0-9-]*[a-z0-9])?).+(?![a-z0-9-]))/;
// rune
const RUNE_REGEX = /(([+/\\\-|$%:.#^~;=?!_,@/%*]|&amp;|&lt;|&gt;)+)|(;script(type "text\/coffeescript")).+?==/;
// cube
const CUBE_REGEX = /%[a-z]([a-z0-9-]*[a-z0-9])?/;
// aura
const AURA_REGEX = /@[a-z]([a-z0-9-]*[a-z0-9])?/;

const KEYWORDS = [ARM_REGEX, RUNE_REGEX];

(function(mod) {
  mod(CodeMirror);
})(function(CodeMirror) {

  CodeMirror.defineMode("hoon", function(_config, modeConfig) {

    function switchState(source, setState, f) {
      setState(f);
      return f(source, setState);
    }

    var WHITESPACE_REGEX = /[ \t\v\f]/; // newlines are handled in tokenizer

    function normal(source, setState) {
      if (source.eatWhile(WHITESPACE_REGEX)) {
        return null;
      }

      if (source.match(COMMENT_REGEX)) {
        // using a different color than 'comment'
        return 'tag';
      }

      var ch = source.next();

      // AURA and CUBE
      if ((ch === '@' || ch === '%') && source.match(/[a-z]([a-z0-9-]*[a-z0-9])?/)) {
        return 'attribute';
      }

      if (KEYWORDS.reduce((acc, cur) => acc || source.match(cur), false)) {
        return 'keyword';
      }

      if (ch === "'" && source.match("''")) {
        return switchState(source, setState, ncomment(1, 'single'));
      } else if (ch === '"' && source.match('""')) {
        return switchState(source, setState, ncomment(1, 'double'));
      }

      if (ch === '"' || ch === "'") {
        return switchState(source, setState, stringLiteral);
      }

      return null;
    }

    function ncomment(nest, quoteType) {
      const type = 'tag'
      if (nest === 0) {
        return normal;
      }
      return function(source, setState) {
        // this has a problem where it doesn't close properly
        var currNest = nest;
        while (!source.eol()) {
          var ch = source.next();
          if ((ch === "'" && source.match("''") && quoteType === 'single') || (ch === '"' && source.match('""') && quoteType === 'double')) {
            if (currNest > 0) {
              --currNest;
            } else {
              ++currNest;
            }
          }
        }
        setState(ncomment(currNest, quoteType));
        return type;
      };
    }

    function stringLiteral(source, setState) {
      while (!source.eol()) {
        var ch = source.next();
        if (ch === '"' || ch === "'") {
          setState(normal);
          return "string";
        }
        if (ch === '\\') {
          if (source.eol() || source.eat(WHITESPACE_REGEX)) {
            setState(stringGap);
            return "string";
          }
          else {
            source.next(); // should handle other escapes here
          }
        }
      }
      setState(normal);
      return "string error";
    }

    function stringGap(source, setState) {
      if (source.eat('\\')) {
        return switchState(source, setState, stringLiteral);
      }
      source.next();
      setState(normal);
      return "error";
    }

    return {
      startState: function ()  { return { f: normal }; },
      copyState:  function (s) { return { f: s.f }; },

      token: function(stream, state) {
        var t = state.f(stream, function(s) { state.f = s; });
        var w = stream.current();

        if (t === 'keyword' && KEYWORDS.reduce((acc, cur) => acc || cur.test(w), false)) {
          return 'keyword'
        }

        return t;
      },
      blockCommentStart: "'''",
      blockCommentEnd: "'''",
      lineComment: "::"
    };

  });

  CodeMirror.defineMIME("text/x-hoon", "hoon");
});
