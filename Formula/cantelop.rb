# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.15.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.4/cantelop_0.15.4_darwin_amd64.tar.gz"
      sha256 "9fe1ddf06f094b8f84ea61fd6ecf393c74b78f74a5e17a164f2ca3b8d31f8c26"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.4/cantelop_0.15.4_darwin_arm64.tar.gz"
      sha256 "619fc52e1adbc226cde2104b325923b95452ab33b9659df124d6155239c00f94"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.4/cantelop_0.15.4_linux_amd64.tar.gz"
      sha256 "098399e15c3f44396a69412365aa2858089c522b082bc77d733257aa02ca26ad"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.4/cantelop_0.15.4_linux_arm64.tar.gz"
      sha256 "0eef9c53a976df9095c8147bba1a86b54d81ea91d2f1bd9b5ac87c37af45f58b"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
