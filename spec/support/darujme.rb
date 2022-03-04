def file_fixture(filename)
  Pathname(File.join(__dir__, "../fixtures/files", filename))
end

def darujme_cz_response_error(message:)
  { status: "error", responsibility: "client", message: message }
end
