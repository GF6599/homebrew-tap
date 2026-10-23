class Lazylab < Formula
  desc "Terminal UI for GitLab"
  homepage "https://github.com/GF6599/lazylab"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.1/lazylab-aarch64-apple-darwin.tar.xz"
      sha256 "281510a1f194b76506c1e8387fdd23e0e0f071fb2e00892f5594c70348dcc8f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.1/lazylab-x86_64-apple-darwin.tar.xz"
      sha256 "9298777cc09cbf260ec3a0794793ca9fc8e355d39122b9ff16274b8b8c29422b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.1/lazylab-aarch64-unknown-linux-musl.tar.xz"
      sha256 "16f3829c721dd01f3f69e9a18e694729040f7a4971efb95d0697ecb3aa664e8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.1/lazylab-x86_64-unknown-linux-musl.tar.xz"
      sha256 "92f40a86c52833a35f176cbe9193cba4d8af410af8dd2a9b50305126fe3cf15e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lazylab"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lazylab"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lazylab"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lazylab"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
