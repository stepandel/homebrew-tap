# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.14.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.14.0/cantelop_0.14.0_darwin_amd64.tar.gz"
      sha256 "1d56384b621ff98766b0dc94e1132cf82cc987fadca4c92c0c7de201b5e1e490"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.14.0/cantelop_0.14.0_darwin_arm64.tar.gz"
      sha256 "49d4a2149a9dc76693477e0d652d2eec4bdc43b952cf019b4f6467590efdcdcd"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.14.0/cantelop_0.14.0_linux_amd64.tar.gz"
      sha256 "db65650cc6f66cb19e2f764308c9190e6c79b44f2c379af1a20e929288320966"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.14.0/cantelop_0.14.0_linux_arm64.tar.gz"
      sha256 "a2344ec7e6fed1fa96e9c02008484b1b2bdc9f00e3103e98d35b6baf1617c36a"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
