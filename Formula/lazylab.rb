class Lazylab < Formula
  desc "Terminal UI for GitLab"
  homepage "https://github.com/GF6599/lazylab"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.0/lazylab-aarch64-apple-darwin.tar.xz"
      sha256 "b958dd907961c0dd2cabe2ef9c9ff968e6b108324a43fc368f1ecb8eb0cef0f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.0/lazylab-x86_64-apple-darwin.tar.xz"
      sha256 "5e91c439620ab6de2f7f8fed83181925b9560a503536a29f8d4904a43bba33ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.0/lazylab-aarch64-unknown-linux-musl.tar.xz"
      sha256 "81e047bbe7a296b84f87042205ac8862858e2679ab13acd2696ffa932beb7479"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GF6599/lazylab/releases/download/v1.0.0/lazylab-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3063e6182ab27fac3c381510e5fdbd109bd5454f554df3dda8aa86316c4c4c1e"
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
