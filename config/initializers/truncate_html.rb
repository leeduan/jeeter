TruncateHtml.configure do |config|
  config.length        = 1500
  config.omission      = '...'
  config.word_boundary = /\S[\.\?\!]/
end