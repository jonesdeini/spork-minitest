class Spork::TestFramework::MiniTest < Spork::TestFramework
  DEFAULT_PORT = 8988
  HELPER_FILE = File.join(Dir.pwd, "test/minitest_helper.rb")

  def run_tests(argv, stderr, stdout)
    require "minitest/spec"
    $LOAD_PATH << "test" << "."
    ::MiniTest::Unit.output = stdout

    paths, opts = parse_options(argv)

    paths.each do |path|
      require path
    end

    ::MiniTest::Unit.new.run(opts)
  end

  def parse_options(argv)
    paths = argv.select { |arg| arg =~ /^\./ }
    paths ||= []
    opts ||= []
    opts.shift
    [paths, opts]
  end
end
