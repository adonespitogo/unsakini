window.App.filter 'markdown', [
  ->
    (input) ->
      return null if !input
      markdown.toHTML(input)
]