class OsidbMcp < Formula
  desc "Model Context Protocol (MCP) server for OSIDB"
  homepage "https://github.com/vdanen/osidb-mcp"
  url "https://files.pythonhosted.org/packages/3c/a4/ea49b1fa77bebaa28917c4cd3e5e85b3e6cf8c9a02db7461e9dc7a0680b8/osidb_mcp-0.2.1.tar.gz"
  sha256 "5e7eae6aa77adee6f5182290c1d63b8fecf43f059f683b7dc7d6cc83d2081884"
  license "MIT"

  depends_on "python@3.13"

  skip_clean "libexec"

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "venv", "--clear", libexec
    ENV.delete("PIP_NO_BINARY")
    ENV.delete("PIP_REQUIRE_HASHES")
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "."
    bin.install_symlink libexec/"bin/osidb-mcp"
  end

  test do
    assert_match %r{\A\d+\.\d+\.\d+\n\z}, shell_output("#{bin}/osidb-mcp --version")
  end
end
