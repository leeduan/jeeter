Fabricator(:upload) do
  user
  media { ActionDispatch::Http::UploadedFile.new({
    filename: 'placeholder3d15e3a5eaae04842667502103f994d8.gif',
    type: 'image/gif',
    tempfile: File.new("#{Rails.root}/spec/fixtures/images/placeholder3d15e3a5eaae04842667502103f994d8.gif")
  }) }
  before_create { |upload| upload.sluggify_file_name }
end
