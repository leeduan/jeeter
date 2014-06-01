TruncateHtml.configure do |config|
  config.length        = 750
  config.omission      = '...'
  config.word_boundary = /\S[\.\?\!]/
end