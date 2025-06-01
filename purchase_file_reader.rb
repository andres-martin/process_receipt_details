class PurchaseFileReader
  class FileReadError < StandardError; end

  # @param file_path [String] Path to the receipt file
  # @return [Array<String>] Array of lines from the purchase file
  # @raise [FileReadError] If file can't be read properly
  def self.read_file(file_path)
    lines = read_file_safely(file_path)
    lines
  end

  private

  # Reads lines from a file with comprehensive error handling
  # @param file_path [String] Path to the file
  # @return [Array<String>] Array of lines from the file
  # @raise [FileReadError] If file can't be read
  def self.read_file_safely(file_path)
    raise FileReadError, "File path cannot be empty" if file_path.to_s.empty?

    begin
      # Validate file existence and permissions
      unless File.exist?(file_path)
        raise FileReadError, "File not found: #{file_path}"
      end

      unless File.readable?(file_path)
        raise FileReadError, "File is not readable: #{file_path}"
      end

      File.open(file_path, 'r:UTF-8') do |file|
        file.each_line.map(&:chomp)
      end
    rescue Errno::EACCES
      raise FileReadError, "Permission denied for file: #{file_path}"
    rescue Errno::ENAMETOOLONG
      raise FileReadError, "File path is too long: #{file_path}"
    rescue Encoding::UndefinedConversionError
      raise FileReadError, "File contains invalid characters"
    rescue SystemCallError, IOError => e
      raise FileReadError, "Error reading file: #{e.message}"
    end
  end
end
